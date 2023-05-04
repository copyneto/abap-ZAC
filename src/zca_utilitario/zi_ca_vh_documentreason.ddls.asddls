@AbapCatalog.sqlViewName: 'ZICA_SETORATIV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Setor de atividade'
@Metadata.allowExtensions: true
@Search.searchable: true
define view ZI_CA_VH_DocumentReason as select from tspa as SalesArea 
 association to tspat as _Text on $projection.SalesAreaId = _Text.spart
                                        and _Text.spras           = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.defaultSearchElement: true
  key spart       as SalesAreaId,  
      @Search.defaultSearchElement: true
      _Text.vtext as Text    
}
