@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help - Motivo de recusa'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_ABGRU
  as select from I_SalesDocumentRjcnReason

  association [0..1] to I_SalesDocumentRjcnReasonText as _SalesDocumentRjcnReasonText on  _SalesDocumentRjcnReasonText.SalesDocumentRjcnReason = $projection.SalesDocumentRjcnReason
                                                                                      and _SalesDocumentRjcnReasonText.Language                = $session.system_language
{
      @ObjectModel.text.element: ['SalesDocumentRjcnReasonName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key SalesDocumentRjcnReason,

      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _SalesDocumentRjcnReasonText.SalesDocumentRjcnReasonName,

      _SalesDocumentRjcnReasonText

};
