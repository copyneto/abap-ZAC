@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Condição expedição'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_VSBED
  as select from tvsb
    inner join   tvsbt as _Text on  _Text.vsbed = tvsb.vsbed
                                and _Text.spras = $session.system_language
{
       @ObjectModel.text.element: ['CondicaoExpedicaoText']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
  key  tvsb.vsbed  as CondicaoExpedicao,
       @Semantics.text: true
       @Search.defaultSearchElement: true
       @Search.ranking: #HIGH
       @Search.fuzzinessThreshold: 0.7
       _Text.vtext as CondicaoExpedicaoText

}
