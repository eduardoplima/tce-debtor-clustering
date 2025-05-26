SELECT
    -- Exe_Debito
    d.IdDebito AS exe_debito_iddebito,
    d.IdProcessoExecucao AS exe_debito_idprocessoexecucao,
    d.valorOriginalDebito AS exe_debito_valororiginaldebito,
    d.ValorPago AS exe_debito_valorpago,
    d.CodigoTipoDebito AS exe_debito_codigotipodebito,
    d.datainclusao AS exe_debito_datainclusao,

    -- Exe_DebitoPessoa
    dp.IDDebitoPessoa AS exe_debitopessoa_iddebitopessoa,
    dp.IDPessoa AS exe_debitopessoa_idpessoa,
    dp.DataInclusao AS exe_debitopessoa_datainclusao,

    -- Exe_DebitoBoleto
    db.IdDebitoBoleto AS exe_debitoboleto_iddebitoboleto,
    db.ValorOriginal AS exe_debitoboleto_valororiginal,
    db.ValorPago AS exe_debitoboleto_valorpago,
    db.DataPagamento AS exe_debitoboleto_datapagamento,

    -- Exe_Debito_MultaDiaria
    md.IdDebitoMultaDiaria AS exe_debito_multadiaria_iddebitomultadiaria,
    md.ValorMultaDiaria AS exe_debito_multadiaria_valormultadiaria,
    md.DataInicioImputacaoMultaDiaria AS exe_debito_multadiaria_datainicio,
    md.DataFinalImputacaoMultaDiaria AS exe_debito_multadiaria_datafinal,

    -- Exe_CreditoPagamento
    cp.IdCreditoPagamento AS exe_creditopagamento_idcreditopagamento,
    cp.ValorCredito AS exe_creditopagamento_valorcredito,
    cp.DataInclusao AS exe_creditopagamento_datainclusao,

    -- Exe_Parcelamento
    p.IdParcelamento AS exe_parcelamento_idparcelamento,
    p.NumeroParcelas AS exe_parcelamento_numeroparcelas,
    p.SituacaoParcelamento AS exe_parcelamento_situacaoparcelamento,
    p.DataCancelamentoParcelamento AS exe_parcelamento_datacancelamento,
    p.DataReabertura AS exe_parcelamento_datareabertura,

    -- Protesto_TitulosRemessa
    pt.IdTituloRemessa AS protesto_titulosremessa_idtituloremessa,
    pt.NumeroProtocoloTitulo AS protesto_titulosremessa_numeroprotocolotitulo,
    pt.DataProtocoloTitulo AS protesto_titulosremessa_dataprotocolotitulo,
    d.StatusProtesto AS protesto_status,

    -- PGE_Processo
    pge.IdProcessoPGE AS pge_processo_idprocessopge,
    pge.NumeroProcessoExecucao AS pge_processo_numeroprocessoexecucao,
    pge.AnoProcessoExecucao AS pge_processo_anoprocessoexecucao,
    pge.ValorAtualizadoPGE AS pge_processo_valoratualizadopge,
    pge.ValorPagoPGE AS pge_processo_valorpagopge,
    pge.HomologadoPGE AS pge_processo_homologadopge,
    d.Status_PGE AS pge_status,
    
 	-- Trânsito?
    ptj.datatransito as processo_data_transito_julgado,
    
    -- Civil Servant? 
    ISNULL(oac_civil_servant.CivilServantFound, 0) AS is_civil_servant,

    -- Legal Organization? 
    CASE WHEN pes.TipoPessoa = '2' THEN 1 ELSE 0 END as is_legal_organization

FROM processo.dbo.Exe_Debito d
LEFT JOIN processo.dbo.Exe_DebitoPessoa dp
    ON d.IdDebito = dp.IDDebito
LEFT JOIN processo.dbo.Exe_DebitoBoleto db
    ON d.IdDebito = db.IdDebito
LEFT JOIN processo.dbo.Exe_Debito_MultaDiaria md
    ON d.IdDebito = md.IdDebito
LEFT JOIN processo.dbo.Exe_CreditoPagamento cp
    ON d.IdDebito = cp.IdDebito
LEFT JOIN processo.dbo.Exe_Parcelamento p
    ON d.IdDebito = p.IdDebito
LEFT JOIN processo.dbo.Protesto_TitulosRemessa pt
    ON d.IdDebito = pt.IdDebito
LEFT JOIN processo.dbo.PGE_Processo pge
    ON d.IdDebito = pge.IdDebitoExecucao
LEFT JOIN processo.dbo.GenPessoa pes 
    ON dp.IDPessoa = pes.IdPessoa
LEFT JOIN processo.dbo.Processos pro
	ON d.IdProcessoOrigem = pro.IdProcesso
LEFT JOIN processo.dbo.Processo_TransitoJulgado ptj
	ON ptj.numero_processo = pro.numero_processo AND
	ptj.ano_processo = pro.ano_processo
OUTER APPLY (
    SELECT TOP 1 1 AS CivilServantFound
    FROM BdDIP.dbo.vwSiaiPessoalFolhaResumida fr
    WHERE YEAR(d.DataDecisao) = CAST(fr.ano AS INT) 
      AND MONTH(d.DataDecisao) = CAST(fr.mes AS INT) 
) oac_civil_servant
WHERE YEAR(d.DataDecisao) > 2022