@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Grupo de contas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_KTOKD
  as select from t077d  as GrupoContas
    inner join   t077x as _Text on  _Text.spras = $session.system_language
                                and _Text.ktokd = GrupoContas.ktokd
{
      @ObjectModel.text.element: ['GrupoContasText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key GrupoContas.ktokd as GrupoContas,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.txt30        as GrupoContasText
}
