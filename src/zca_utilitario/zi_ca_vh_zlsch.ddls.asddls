@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Forma Pagamento'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_ZLSCH
  as select from t042z  as FormaPagamento
    inner join   t042zt as _Text on  _Text.spras = $session.system_language
                                 and _Text.land1 = FormaPagamento.land1
                                 and _Text.zlsch = FormaPagamento.zlsch
{
      @ObjectModel.text.element: ['FormaPagamentoText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key FormaPagamento.zlsch as FormaPagamento,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.text2          as FormaPagamentoText
}
where
  FormaPagamento.land1 = 'BR'
