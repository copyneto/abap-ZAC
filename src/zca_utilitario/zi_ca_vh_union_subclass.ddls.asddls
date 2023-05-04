@AbapCatalog.sqlViewName: 'ZI_UNION_SUBCL'
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: SetName - tabela Setleaf'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED

}
define view ZI_CA_VH_UNION_SUBCLASS
  as select from setnode as _Node

{
//       @ObjectModel.text.element: ['SetName']
//       @Search.ranking: #MEDIUM
//       @Search.defaultSearchElement: true
//       @Search.fuzzinessThreshold: 0.8
//       @EndUserText.label: 'Pacote'
  key  setname as SetName

}
where
       setclass = '0311'
  and  subclass = 'AF3C'
group by
  setname



union select from setnode as _Node

{
//       @ObjectModel.text.element: ['SetName']
//       @Search.ranking: #MEDIUM
//       @Search.defaultSearchElement: true
//       @Search.fuzzinessThreshold: 0.8
//       @EndUserText.label: 'Pacote'
  key  subsetname as SetName

}
where
       setclass = '0311'
  and  subclass = 'AF3C'
group by
  subsetname
