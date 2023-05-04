@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help - Bloqueio de remessa'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_LIFSP
  as select from tvls
  association [0..1] to I_DeliveryBlockReason     as _DeliveryBlockReason     on  _DeliveryBlockReason.DeliveryBlockReason = $projection.DeliveryBlockReason
  association [0..1] to I_DeliveryBlockReasonText as _DeliveryBlockReasonText on  _DeliveryBlockReasonText.DeliveryBlockReason = $projection.DeliveryBlockReason
                                                                              and _DeliveryBlockReasonText.Language            = $session.system_language

{
      @ObjectModel.foreignKey.association: '_DeliveryBlockReason'
  key lifsp as DeliveryBlockReason,


      @Consumption.filter.hidden: true
      @Semantics.text:true
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      _DeliveryBlockReasonText.DeliveryBlockReasonText,

      _DeliveryBlockReason,
      _DeliveryBlockReasonText
};
