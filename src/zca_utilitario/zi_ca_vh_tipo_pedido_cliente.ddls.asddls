@AbapCatalog.sqlViewName: 'ZICA_TIPO_PEDIDO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Tipo pedido do cliente'
@Search.searchable: true
define view ZI_CA_VH_TIPO_PEDIDO_CLIENTE as select from t176 
  association to t176t as _Text on  _Text.bsark = $projection.Bsark
                                and _Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
  key bsark       as Bsark,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.vtext as Text

}
