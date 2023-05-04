@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help Contrato'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_TIMESHEET_CONTRATO 
as select from ZI_CA_TIMESHEET 
{
    @Search.ranking: #HIGH
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @EndUserText.label:'Contrato'
    key Contrato
}
group by
    Contrato
