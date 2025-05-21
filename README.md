# Debtor Clustering for TCE/RN Multas

This repository contains notebooks and scripts to analyze and cluster debtors of the Tribunal de Contas do Estado do Rio Grande do Norte (TCE/RN), based on fines (`multas`) issued according to [Resolução 013/2015-TCE](https://www.tce.rn.gov.br/). Debts are modeled analogously to credit card liabilities and analyzed using unsupervised learning techniques.

## 📊 Objective

To explore the characteristics of debtors and group them into meaningful clusters using techniques like:

- K-Means and DBSCAN
- PCA and t-SNE for dimensionality reduction
- Debt behavior modeling inspired by credit risk analysis

This profiling can support:

- Public resource recovery strategies
- Proactive risk monitoring
- Tailored compliance interventions

## 🧾 Data Sources

- **Resolução 013/2015**: Legal framework for enforcement and classification.
- **TCERN Execution Logs**: Information on payment stages, parcelamento, and cadastro de inadimplentes.

## ⚙️ Dependencies

Install all necessary packages:

```bash
pip install -r requirements.txt
