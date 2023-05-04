@AbapCatalog.sqlViewName: 'ZICA_TDT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Tp.decl.imposto'
@Search.searchable: true
define view ZI_CA_VH_TDT
  as select from j_1bttdt as TipoDeclImposto
  association to j_1bttdtt as _Text on  _Text.j_1btdt = $projection.J_1BTDT
                                and _Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key j_1btdt       as J_1BTDT,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.j_1btdtx as Text
}
