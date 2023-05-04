@AbapCatalog.sqlViewName: 'ZICA_MATERIAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Material'
@Search.searchable: true
define view ZI_CA_VH_MATERIAL   as select from mara as Material
  association to makt as _Text on  _Text.matnr = $projection.Material
                                and _Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key matnr       as Material,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.maktx as Text
}
