@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Canal de Distribuição'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_VTWEG
  as select from tvtw  as CanalDistrib
    inner join   tvtwt as _Text on  _Text.spras = $session.system_language
                                and _Text.vtweg = CanalDistrib.vtweg
{
      @ObjectModel.text.element: ['CanalDistribText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key CanalDistrib.vtweg as CanalDistrib,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.vtext        as CanalDistribText
}
