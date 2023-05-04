@AbapCatalog.sqlViewName: 'ZICA_DEPOSITO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Entradas Depósitos'
@Search.searchable: true
define view ZI_CA_VH_DEPOSITO
  as select from t001l
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
  key werks as Werks,
      @Search.defaultSearchElement: true
  key lgort as Lgort,
      @Search.defaultSearchElement: true
      lgobe as Lgobe

}
