@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help Bancos'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_BANK
  as select from ZI_CA_VH_BANKL
{
  key BanKey          as BanKey,
      max( BankName ) as BankName
}
where
  Banks = 'BR'
group by
  Banks,
  BanKey
