@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Etapa do Processo'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_XNFE_PROCSTEP
  as select from    /xnfe/procstep  as ProcessStep
    left outer join /xnfe/procstept as _Text on  _Text.langu    = $session.system_language
                                             and _Text.procstep = ProcessStep.procstep
{
      @ObjectModel.text.element: ['ProcessStepText']
      @EndUserText.label: 'Status'
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key ProcessStep.procstep as ProcessStep,
      @EndUserText.label: 'Descrição'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.description    as ProcessStepText
}
