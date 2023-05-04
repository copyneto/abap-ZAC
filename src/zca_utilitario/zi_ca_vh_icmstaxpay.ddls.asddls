@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Contribuinte ICMS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_ICMSTAXPAY
  as select from j_1bticmstaxpay  as ICMSTaxPay
    inner join   j_1bticmstaxpayt as _Text
      on  ICMSTaxPay.j_1bicmstaxpay = _Text.j_1bicmstaxpay
      and _Text.spras               = $session.system_language
{
      @ObjectModel.text.element: ['Descricao']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key ICMSTaxPay.j_1bicmstaxpay as ICMSTaxpay,
      ICMSTaxPay.j_1biedest     as IEDest,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.j_1bicmstaxpayx     as Descricao

}
