@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Segmento de Crédito'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_CREDIT_SGMNT
  as select from ukmcred_sgm0c as Segmento
    inner join   ukmcred_sgm0t as _Text on  _Text.langu        = $session.system_language
                                        and _Text.credit_sgmnt = Segmento.credit_sgmnt
{
      @ObjectModel.text.element: ['CreditSegmentText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true 
      @Search.fuzzinessThreshold: 0.8
  key Segmento.credit_sgmnt  as CreditSegment,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.credit_sgmnt_txt as CreditSegmentText
}
