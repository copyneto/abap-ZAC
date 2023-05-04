@AbapCatalog.sqlViewName: 'ZVMMTXSDC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Centro'
@Search.searchable: true
define view ZI_MM_VH_TXSDC
  as select from j_1btxsdct
{
  @Search.defaultSearchElement: true
  key taxcode,
   @Search.defaultSearchElement: true
    txt
}
where
  langu = 'P'
