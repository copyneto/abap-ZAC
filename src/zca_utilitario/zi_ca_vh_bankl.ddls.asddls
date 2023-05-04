@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help Chave dos Bancos'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
// Utilizar CDS ZI_CA_VH_BANK
define view entity ZI_CA_VH_BANKL
  as select from bnka
{
  key banks                  as Banks,
  key substring(bankl, 1, 3) as BanKey,
      banka                  as BankName
}
