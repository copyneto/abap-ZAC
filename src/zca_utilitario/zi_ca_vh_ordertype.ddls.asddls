@AbapCatalog.sqlViewName: 'ZICA_ORDERTYPE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Tipo da Ordem'
@Search.searchable: true
define view ZI_CA_VH_ORDERTYPE
  as select from tvak as Tvak
  association to tvakt as _Text on  _Text.auart = $projection.Auart
                                and _Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
  key auart       as Auart,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.bezei as Text,
      @UI.hidden: true
      sperr as Block
}
