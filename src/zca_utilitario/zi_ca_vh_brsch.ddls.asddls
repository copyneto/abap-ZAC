@AbapCatalog.sqlViewName: 'ZICA_BRSCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Chave do setor industrial'
@Search.searchable: true
define view ZI_CA_VH_BRSCH   as select from t016 as SetorIndustrial
  association to t016t as _Text on  _Text.brsch = $projection.Brsch
                                and _Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key brsch       as Brsch,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.brtxt as Text
}
