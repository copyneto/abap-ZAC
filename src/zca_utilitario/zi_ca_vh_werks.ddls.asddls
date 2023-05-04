@AbapCatalog.sqlViewName: 'ZICA_WERKS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Centro'
@Search.searchable: true
define view ZI_CA_VH_WERKS
  as select from t001w as _Centro
{
      @ObjectModel.text.element: ['WerksCodeName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key _Centro.werks as WerksCode,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Centro.name1 as WerksCodeName
}
