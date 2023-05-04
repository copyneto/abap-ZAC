@AbapCatalog.sqlViewName: 'ZICA_LIFNR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Centro'
@Search.searchable: true
define view ZI_CA_VH_LIFNR
  as select from lfa1 as _Fornecedor
{
      @ObjectModel.text.element: ['LifnrCodeName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key _Fornecedor.lifnr as LifnrCode,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Fornecedor.name1 as LifnrCodeName
}
