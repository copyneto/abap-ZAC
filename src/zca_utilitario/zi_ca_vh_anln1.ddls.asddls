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
  key bukrs                  as Empresa,
  key lpad( anln1, 12, '0' ) as Imobilizado,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      anlhtxt                as TextoImobilizado,
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.hidden: true
      anln1                  as ImobilizadoSearch

}
