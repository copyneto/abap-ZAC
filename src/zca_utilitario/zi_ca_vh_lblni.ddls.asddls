@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Folha registro de serviços'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_LBLNI
  as select from essr
{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key lblni  as lblni,
      ernam  as ernam,
      erdat  as erdat,
      packno as packno,
      txz01  as txz01,
      ebeln  as ebeln,
      ebelp  as ebelp,
      @Semantics.amount.currencyCode : 'waers'
      netwr  as netwr,
      waers  as waers
}
