@AbapCatalog.sqlViewName: 'ZVCA_GRPMERC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Tipo de Material'
@Search.searchable: true
define view ZI_CA_VH_TIPO_MATERIAL
  as select from t134 as TipoMat
  association to t134t as _Text on  _Text.mtart = $projection.TipoMaterial
                                and _Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key mtart       as TipoMaterial,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.mtbez as Text
}
