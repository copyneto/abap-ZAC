@AbapCatalog.sqlViewName: 'ZICA_EMISSOR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Emissor da Ordem'
@Search.searchable: true
define view ZI_CA_VH_EMISSOR_ORDEM
  as select from kna1
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
  key kunnr  as Kunnr,
      @Search.defaultSearchElement: true
      sortl as Text,
      @Search.defaultSearchElement: true
      land1 as Land1,
      @Search.defaultSearchElement: true
      pstlz as Pstlz,
      @Search.defaultSearchElement: true
      mcod3 as Mcod3,
      @Search.defaultSearchElement: true
      mcod1 as Mcod1
}
