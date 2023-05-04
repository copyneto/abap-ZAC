@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Condições'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_KSCHL
  as select from t685t
{
  key spras as Spras,
  key kvewe as Kvewe,
  key kappl as Kappl,
  key kschl as Kschl,
      vtext as Vtext
}
where
  spras = $session.system_language
