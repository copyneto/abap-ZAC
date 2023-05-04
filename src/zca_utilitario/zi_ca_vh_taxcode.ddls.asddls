@AbapCatalog.sqlViewName: 'ZVCA_VH_TAXCODE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: SD código do imposto'
@Search.searchable: true
define view ZI_CA_VH_TAXCODE
  as select from j_1btxsdc as Tax
  association to j_1btxsdct as _Text on  $projection.Taxcode = _Text.taxcode
                                     and _Text.langu         = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
  key taxcode   as Taxcode,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7  
      _Text.txt as Text
}
