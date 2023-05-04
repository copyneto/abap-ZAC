@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Escritório de vendas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_VKBUR
  as select from tvbur as SalesOffice
    inner join   tvkbt as _Text on  _Text.spras = $session.system_language
                                and _Text.vkbur = SalesOffice.vkbur
{
      @ObjectModel.text.element: ['SalesOfficeName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key SalesOffice.vkbur as SalesOffice,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.bezei       as SalesOfficeName
}
