@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Bloqueio de Pagamento'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_ZLSPR
  as select from t008  as BloqPagamento
    inner join   t008t as _Text on  _Text.spras = $session.system_language
                                and _Text.zahls = BloqPagamento.zahls
{
      @ObjectModel.text.element: ['BloqPagamentoText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key BloqPagamento.zahls as BloqPagamento,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.textl         as BloqPagamentoText
}
