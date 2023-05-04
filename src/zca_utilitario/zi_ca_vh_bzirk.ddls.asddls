@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Reg. Vendas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_BZIRK
  as select from t171  as RegiaoVendas
    inner join   t171t as _Text on  _Text.spras = $session.system_language
                                and _Text.bzirk = RegiaoVendas.bzirk
{
      @ObjectModel.text.element: ['RegiaoVendasText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key RegiaoVendas.bzirk as RegiaoVendas,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.bztxt        as RegiaoVendasText
}
