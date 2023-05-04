@AbapCatalog.sqlViewName: 'ZICA_COMPANY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Empresa'
@Search.searchable: true
define view ZI_CA_VH_COMPANY
  as select from t001 as Company
{
      @ObjectModel.text.element: ['CompanyCodeName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
    key bukrs as CompanyCode,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      butxt    as CompanyCodeName
  }
