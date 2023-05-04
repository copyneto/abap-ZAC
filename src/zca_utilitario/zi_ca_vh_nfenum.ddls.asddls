@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Nº nota fiscal eletrônica'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_NFENUM
  as select from j_1bnfdoc
{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key nfenum,
  key docnum,
      nftype,
      doctyp,
      direct,
      docdat,
      pstdat,
      credat,
      cretim,
      crenam,
      cast(ltrim(j_1bnfdoc.nfenum, '0') as logbr_nfnum9 preserving type) as nfenumcast
}
where
  nfenum is not initial
