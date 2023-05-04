@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: SetName - tabela Setleaf'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED

}
define view entity ZI_CA_VH_SETSUBCLASS
  //  as select from I_Setleaf as Setleaf
  as select from ZI_CA_VH_UNION_SUBCLASS as Setleaf


{


      @ObjectModel.text.element: ['SetName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @EndUserText.label: 'Pacote'
  key Setleaf.SetName as SetName


}
//where
//      SetClass    = '0311'
//  and SetSubClass = 'AF3C'
group by
  Setleaf.SetName
