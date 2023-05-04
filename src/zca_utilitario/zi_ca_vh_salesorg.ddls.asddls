@AbapCatalog.sqlViewName: 'ZICA_SALESORG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Organização de vendas'
@Search.searchable: true
define view ZI_CA_VH_SALESORG as select from tvko as SalesOrg
  association to tvkot as _Text
    on  $projection.SalesOrgID = _Text.vkorg
    and _Text.spras            = $session.system_language

{
      @ObjectModel.text.element: ['Text']
      @Search.defaultSearchElement: true
  key vkorg       as SalesOrgID,
      @Search.defaultSearchElement: true
      _Text.vtext as Text
}

where
  SalesOrg.hide = ''
