@AbapCatalog.sqlViewName: 'ZICA_KNTTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Catg. Class. Contábil'
@Search.searchable: true
@ObjectModel.resultSet.sizeCategory: #XS
define view ZI_CA_VH_KNTTP
  as select from t163k as _Categoria
    inner join   t163i as _CategoriaText on  _Categoria.knttp     = _CategoriaText.knttp
                                         and _CategoriaText.spras = $session.system_language
{
      @ObjectModel.text.element: ['CategoriaCodeName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key _Categoria.knttp as CategoriaCode,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _CategoriaText.knttx as CategoriaCodeName
}
