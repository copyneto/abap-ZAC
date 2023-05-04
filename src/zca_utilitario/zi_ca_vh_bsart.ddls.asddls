@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help Tipo documento'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_BSART
  as select from t161t
{
  key bsart as Bsart,
  key bstyp as Bstyp,
      batxt as Batxt
}
where
  spras = $session.system_language
