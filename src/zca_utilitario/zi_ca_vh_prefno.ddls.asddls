@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Nº NF-e dos serviços'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_PREFNO
  as select from j_1bnfdoc
{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key prefno,
  key docnum,
      nftype,
      doctyp,
      direct,
      docdat,
      pstdat,
      credat,
      cretim,
      crenam
}
where
  prefno is not initial
