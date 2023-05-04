@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Área de Advertência'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
//@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_CA_VH_MABER
  as select from    t047m as Area
    left outer join t047n as _Text on  _Text.spras = $session.system_language
                                   and _Text.bukrs = Area.bukrs
                                   and _Text.maber = Area.maber
{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true 
      @Search.fuzzinessThreshold: 0.8
  key Area.bukrs  as Empresa,
      @ObjectModel.text.element: ['AreaAdvText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key Area.maber  as AreaAdv,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.text1 as AreaAdvText
}
