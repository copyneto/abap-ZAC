@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Equipe de Vendas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_VKGRP
  as select from tvkgr as SalesGroup
    inner join   tvgrt as _Text on  _Text.spras = $session.system_language
                                and _Text.vkgrp = SalesGroup.vkgrp
{
      @ObjectModel.text.element: ['SalesGroupName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key SalesGroup.vkgrp as SalesGroup,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.bezei      as SalesGroupName
}
