@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help Tipo de Hora'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_TIMESHEET_TP_HORA 
as select from ZI_CA_TIMESHEET 
{
    @Search.ranking: #HIGH
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @EndUserText.label:'Tipo de Hora'
    key TpHora
}
group by
    TpHora
