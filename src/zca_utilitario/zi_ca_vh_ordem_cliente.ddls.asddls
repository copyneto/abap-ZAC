@AbapCatalog.sqlViewName: 'ZICA_OV_CLIENTE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help Ordem do Cliente'
@Metadata.allowExtensions: true
@Search.searchable: true
define view ZI_CA_VH_ORDEM_CLIENTE
  as select from I_SalesOrder as SalesOrder
  inner join ZI_SD_TIPOS_ECOMMERCE as _Param  on _Param.OrderType  = SalesOrder.SalesOrderType
                              
{
      @ObjectModel.text.element: ['Text']
      @Search.defaultSearchElement: true
  key SalesOrder   as OrdCliente


}
