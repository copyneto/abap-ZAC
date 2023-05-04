@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Chave de Acesso'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_ACCKEY
  as select from j_1bnfe_active
{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Chave de acesso'
  key concat( regio,
      concat( nfyear,
      concat( nfmonth,
      concat( stcd1,
      concat( model,
      concat( serie,
      concat( nfnum9,
      concat( docnum9, cdv )))))))) as acckey,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      docnum                        as docnum,
      docsta                        as docsta,
      cancel                        as cancel,
      regio                         as regio,
      nfyear                        as nfyear,
      nfmonth                       as nfmonth,
      stcd1                         as stcd1,
      model                         as model,
      serie                         as serie,
      nfnum9                        as nfnum9,
      docnum9                       as docnum9,
      cdv                           as cdv




}
