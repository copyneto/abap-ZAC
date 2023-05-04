@AbapCatalog.sqlViewName: 'ZICA_KUNNR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Clientes'
@Search.searchable: true
define view ZI_CA_VH_KUNNR
  as select from kna1 as _Cliente
{
      @ObjectModel.text.element: ['KunnrName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key _Cliente.kunnr as Kunnr,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Cliente.name1 as KunnrName
}
