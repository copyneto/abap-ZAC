@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help Tarefa'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_TIMESHEET_TAREFA 
as select from ZI_CA_TIMESHEET 
{
    @Search.ranking: #HIGH
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @EndUserText.label:'Tarefa'
    key Tarefa
}
group by
    Tarefa
