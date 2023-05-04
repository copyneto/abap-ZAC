@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Setor de Atividade'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_SPART
  as select from tspa  as SetorAtividade
    inner join   tspat as _Text on  _Text.spras = $session.system_language
                                and _Text.spart = SetorAtividade.spart
{
      @ObjectModel.text.element: ['SetorAtividadeText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key SetorAtividade.spart as SetorAtividade,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.vtext          as SetorAtividadeText
}
