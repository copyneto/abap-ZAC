@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Bloqueio Adv.'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_MANSP
  as select from t040s  as BloqAdv
    inner join   t040t as _Text on  _Text.spras = $session.system_language
                                 and _Text.mansp = BloqAdv.mansp
{
      @ObjectModel.text.element: ['BloqAdvText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key BloqAdv.mansp as BloqAdv,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.text1          as BloqAdvText
}
