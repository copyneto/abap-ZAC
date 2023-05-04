@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Região fiscal'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_TXREG
  as select from j_1btregxt
{

      @ObjectModel.text.element: ['Txt']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key txreg as Txreg,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      txt   as Txt

}

where
      spras = $session.system_language
  and land1 = 'BR'
