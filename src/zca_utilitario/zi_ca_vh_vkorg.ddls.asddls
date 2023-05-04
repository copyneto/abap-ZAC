@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Organização de Vendas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_VKORG
  as select from tvko  as OrgVendas
    inner join   tvkot as _Text on  _Text.spras = $session.system_language
                                and _Text.vkorg = OrgVendas.vkorg
{
      @ObjectModel.text.element: ['OrgVendasText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key OrgVendas.vkorg as OrgVendas,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.vtext     as OrgVendasText
}
where OrgVendas.hide = ''

