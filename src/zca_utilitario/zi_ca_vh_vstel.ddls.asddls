@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Local de Expedição'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_VSTEL
  as select from tvst
    inner join   tvstt as _Text on  _Text.vstel = tvst.vstel
                                and _Text.spras = $session.system_language
{
  @ObjectModel.text.element: ['Text']
  @Search.ranking: #MEDIUM
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  key tvst.vstel  as LocalExpedicao,
  @Semantics.text: true
  @Search.defaultSearchElement: true
  @Search.ranking: #HIGH
  @Search.fuzzinessThreshold: 0.7
  _Text.vtext as Text
}
