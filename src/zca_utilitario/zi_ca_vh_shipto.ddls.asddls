@AbapCatalog.sqlViewName: 'ZCA_REGIONTAX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Região fiscal'
@Search.searchable: true
define view ZI_CA_VH_SHIPTO
  as select from j_1btregx as RegionTax
  association to j_1btregxt as _Text on  _Text.land1 = $projection.Country
                                     and _Text.txreg = $projection.Region
                                     and _Text.spras = $session.system_language
{
  key land1     as Country,
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key txreg     as Region,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.txt as Text
}
where
  land1 = 'BR'
