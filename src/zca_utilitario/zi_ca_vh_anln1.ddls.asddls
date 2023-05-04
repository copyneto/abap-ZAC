@AbapCatalog.sqlViewName: 'ZICA_IMOBIL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Imobilizado'
@Search.searchable: true
define view ZI_CA_VH_ANLN1
  as select from anlh as Imobilizado
{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
  key bukrs   as Empresa,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
  key lpad( anln1, 12, '0' )   as Imobilizado,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      anlhtxt as TextoImobilizado
}
