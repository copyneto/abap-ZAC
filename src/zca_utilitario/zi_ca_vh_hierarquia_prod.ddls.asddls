@AbapCatalog.sqlViewName: 'ZVCA_HIERPROD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Hierarquia de produtos'
@Search.searchable: true
define view ZI_CA_VH_HIERARQUIA_PROD
  as select from t179 as TipoMat
  association to t179t as _Text on  _Text.prodh = $projection.HierProd
                                and _Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key prodh       as HierProd,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.vtext as Text
}
