@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help - Bloqueio de faturamento'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_FAKSP
  as select from tvfs
  association [0..1] to I_BillingBlockReason     as _BillingBlockReason     on  _BillingBlockReason.BillingBlockReason = $projection.BillingBlockReason
  association [0..1] to I_BillingBlockReasonText as _BillingBlockReasonText on  _BillingBlockReasonText.BillingBlockReason = $projection.BillingBlockReason
                                                                            and _BillingBlockReasonText.Language           = $session.system_language
{
      @ObjectModel.foreignKey.association: '_BillingBlockReason'
  key faksp as BillingBlockReason,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @Semantics.text
      _BillingBlockReasonText.BillingBlockReasonDescription,

      _BillingBlockReason,
      _BillingBlockReasonText
};
