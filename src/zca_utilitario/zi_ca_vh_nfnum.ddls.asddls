@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Nº da nota fiscal'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_NFNUM
  as select from j_1bnfdoc
{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key nfnum                                            as NFNum,
      @EndUserText.label: ' Ctg.de nota fiscal'
      max(nftype)                                      as Nftype,
      @EndUserText.label: ' Tipo de documento'
      max(doctyp)                                      as Doctyp,
      @EndUserText.label: ' Direção do movimento'
      max(direct)                                      as Direct,
      @EndUserText.label: ' Data do documento'
      max(docdat)                                      as Docdat,
      @EndUserText.label: ' Data de lançamento'
      max(pstdat)                                      as Pstdat,
      @EndUserText.label: ' Criar data'
      max(credat)                                      as Credat,
      @EndUserText.label: 'Hora da criação'
      max(cretim)                                      as Cretim,
      @EndUserText.label: ' Nome do usuário'
      max(crenam)                                      as Crenam
}
where
  nfnum is not initial
group by
  nfnum
