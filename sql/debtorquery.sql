SELECT
    -- Exe_Debito
    d.IdDebito AS Exe_Debito_IdDebito,
    d.IdProcessoExecucao AS Exe_Debito_IdProcessoExecucao,
    d.valorOriginalDebito AS Exe_Debito_valorOriginalDebito,
    d.ValorPago AS Exe_Debito_ValorPago,
    d.CodigoTipoDebito AS Exe_Debito_CodigoTipoDebito,
    d.datainclusao AS Exe_Debito_datainclusao,

    -- Exe_DebitoPessoa
    dp.IDDebitoPessoa AS Exe_DebitoPessoa_IDDebitoPessoa,
    dp.IDPessoa AS Exe_DebitoPessoa_IDPessoa,
    dp.DataInclusao AS Exe_DebitoPessoa_DataInclusao,

    -- Exe_DebitoBoleto
    db.IdDebitoBoleto AS Exe_DebitoBoleto_IdDebitoBoleto,
    db.ValorOriginal AS Exe_DebitoBoleto_ValorOriginal,
    db.ValorPago AS Exe_DebitoBoleto_ValorPago,
    db.DataPagamento AS Exe_DebitoBoleto_DataPagamento,

    -- Exe_Debito_MultaDiaria
    md.IdDebitoMultaDiaria AS Exe_Debito_MultaDiaria_IdDebitoMultaDiaria,
    md.ValorMultaDiaria AS Exe_Debito_MultaDiaria_ValorMultaDiaria,
    md.DataInicioImputacaoMultaDiaria AS Exe_Debito_MultaDiaria_DataInicio,
    md.DataFinalImputacaoMultaDiaria AS Exe_Debito_MultaDiaria_DataFinal,

    -- Exe_CreditoPagamento
    cp.IdCreditoPagamento AS Exe_CreditoPagamento_IdCreditoPagamento,
    cp.ValorCredito AS Exe_CreditoPagamento_ValorCredito,
    cp.DataInclusao AS Exe_CreditoPagamento_DataInclusao,

    -- Exe_Parcelamento
    p.IdParcelamento AS Exe_Parcelamento_IdParcelamento,
    p.NumeroParcelas AS Exe_Parcelamento_NumeroParcelas,
    p.SituacaoParcelamento AS Exe_Parcelamento_SituacaoParcelamento,
    p.DataCancelamentoParcelamento AS Exe_Parcelamento_DataCancelamento,

    -- Protesto_TitulosRemessa
    pt.IdTituloRemessa AS Protesto_TitulosRemessa_IdTituloRemessa,
    pt.NumeroProtocoloTitulo AS Protesto_TitulosRemessa_NumeroProtocoloTitulo,
    pt.DataProtocoloTitulo AS Protesto_TitulosRemessa_DataProtocoloTitulo,

    -- PGE_Processo
    pge.IdProcessoPGE AS PGE_Processo_IdProcessoPGE,
    pge.NumeroProcessoExecucao AS PGE_Processo_NumeroProcessoExecucao,
    pge.AnoProcessoExecucao AS PGE_Processo_AnoProcessoExecucao,
    pge.ValorAtualizadoPGE AS PGE_Processo_ValorAtualizadoPGE,
    pge.ValorPagoPGE AS PGE_Processo_ValorPagoPGE,
    pge.HomologadoPGE AS PGE_Processo_HomologadoPGE

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