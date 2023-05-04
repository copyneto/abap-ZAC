@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help Unidades de medida'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_MEINS
  as select from t006a
{
       @ObjectModel.text.element: ['UnidName']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
  key  mseh3 as UnidadeMed,
//       @Search.ranking: #MEDIUM
//       @Search.defaultSearchElement: true
//       @Search.fuzzinessThreshold: 0.8
//  key  msehi as UnidadeInterna,
       @Semantics.text: true
       @Search.defaultSearchElement: true
       @Search.ranking: #HIGH
       @Search.fuzzinessThreshold: 0.7
       msehl as UnidName
}
where
  spras = $session.system_language
