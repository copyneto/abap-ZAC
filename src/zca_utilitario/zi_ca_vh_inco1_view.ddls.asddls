@AbapCatalog.sqlViewName: 'ZICA_INCO1_VIEW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Incoterms 1'
@Search.searchable: true
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZI_CA_VH_INCO1_VIEW
  as select from tinct as Tinct

{
      @ObjectModel.text.element: ['bezei']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key inco1,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      bezei

}
where
  spras = $session.system_language
