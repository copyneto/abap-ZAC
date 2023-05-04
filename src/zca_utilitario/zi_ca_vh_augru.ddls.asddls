@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search help: Motivo da ordem'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_AUGRU
  as select from    tvau  as _MotivoOrdem
    left outer join tvaut as _MotivoOrdemText on  _MotivoOrdemText.augru = _MotivoOrdem.augru
                                              and _MotivoOrdemText.spras = $session.system_language
{
      //      @ObjectModel.text.element: ['SDDocumentReason']
      //      @Search.ranking: #MEDIUM
      //      @Search.defaultSearchElement: true
      //      @Search.fuzzinessThreshold: 0.8
  key _MotivoOrdem.augru,

      //      @Semantics.text: true
      //      @Search.defaultSearchElement: true
      //      @Search.ranking: #HIGH
      //      @Search.fuzzinessThreshold: 0.7
      _MotivoOrdemText.bezei

}
