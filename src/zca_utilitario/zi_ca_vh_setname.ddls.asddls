@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: SetName - tabela Setleaf'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED

}
define view entity ZI_CA_VH_SETNAME
//  as select from I_Setleaf as _Setleaf
  as select from ZI_CA_VH_UNION_SETNODE as _Setleaf

{


       @ObjectModel.text.element: ['SetName']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
       @EndUserText.label: 'Filial'
  key  SetName  as SetName

}
//where
//  (
//       SetClass    = '0312'
//    or SetClass    = '0315'
//  )
//  and  SetSubClass = 'AF3C'
group by
  _Setleaf.SetName
  
