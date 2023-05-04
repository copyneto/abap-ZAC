@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Chave Advertência'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
//@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_CA_VH_MSCHL
  as select from    t040  as Chave
    left outer join t040a as _Text on  _Text.spras = $session.system_language
                                   and _Text.mschl = Chave.mschl
{
      @ObjectModel.text.element: ['ChaveAdvText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key Chave.mschl as ChaveAdv,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.text1 as ChaveAdvText
}
