@AbapCatalog.sqlViewName: 'ZICA_MATKL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: GrpMercads.'
@Search.searchable: true
define view ZI_CA_VH_MATKL
  as select from t023
  association to t023t as _Text on  _Text.spras = $session.system_language
                                and _Text.matkl = $projection.Matkl

{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key matkl         as Matkl,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.wgbez60 as Text,

      _Text
}
