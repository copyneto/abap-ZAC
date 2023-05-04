@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Região'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_REGIO_BR
  as select from t005s
  association [0..1] to t005u as _Text on  _Text.land1 = 'BR'
                                       and _Text.bland = $projection.Region
                                       and _Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['RegionName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key bland       as Region,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.bezei as RegionName
} where t005s.land1 = 'BR'
