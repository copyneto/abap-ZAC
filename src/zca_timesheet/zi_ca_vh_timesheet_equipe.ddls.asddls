@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help Equipe'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_TIMESHEET_EQUIPE 
as select from ZI_CA_TIMESHEET 
{
    @Search.ranking: #HIGH
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    @EndUserText.label:'Equipe'
    key Equipe
}
group by
    Equipe
