@AbapCatalog.sqlViewName: 'ZI_UNION_SETNODE'
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: SetName - tabela Setleaf'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED

}
define view ZI_CA_VH_UNION_SETNODE
  as select from setnode as _Node

{
       @ObjectModel.text.element: ['SetName']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
       @EndUserText.label: 'Filial'
  key  setname as SetName

}
where
  (
       setclass = '0312'
    or setclass = '0315'
  )
  and  subclass = 'AF3C'
group by
  setname



union select from setnode as _Node

{
       @ObjectModel.text.element: ['SetName']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
       @EndUserText.label: 'Filial'
  key  subsetname as SetName

}
where
  (
       setclass = '0312'
    or setclass = '0315'
  )
  and  subclass = 'AF3C'
group by
  subsetname
