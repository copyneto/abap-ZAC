@AbapCatalog.sqlViewName: 'ZICA_DISTCHANNEL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Canal de distribuição'
@Metadata.allowExtensions: true
@Search.searchable: true
define view ZI_CA_VH_DISTRIBUTIONCHANNEL
  as select from tvtw as OrgUnid
  association to tvtwt as _Text on  $projection.OrgUnidID = _Text.vtweg
                                and _Text.spras           = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.defaultSearchElement: true
  key vtweg       as OrgUnidID,
      @Search.defaultSearchElement: true
      _Text.vtext as Text

}
