@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Bloqueio de Pagamento'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_ad_remark2
  as select from I_BPEmailAddressTP
{

  key AddressCommunicationRemarkText
}

group by
  AddressCommunicationRemarkText
