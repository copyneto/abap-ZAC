@AbapCatalog.sqlViewName: 'ZICA_GRPMERC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Grupo de Mercadoria'
@Search.searchable: true
define view ZI_CA_VH_GRP_MERCADORIA
  as select from t023 as GrpMerc
  association to t023t as _Text on  _Text.matkl = $projection.GrpMercadoria
                                and _Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key matkl       as GrpMercadoria,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.wgbez as Text
}
