@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Área Financeira'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_AREAFIN
  as select from fm01t
{
  @ObjectModel.text.element: ['Text']
  @Search.ranking: #MEDIUM
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  key fikrs as Fikrs,
  @Semantics.text: true
  @Search.defaultSearchElement: true
  @Search.ranking: #HIGH
  @Search.fuzzinessThreshold: 0.7
  fitxt   as Text

}
where
    spras   = $session.system_language
