@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Processo'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_XNFE_PROCTYP
  as select from    /xnfe/proctypd as Process
    left outer join /xnfe/proctypt as _Text on  _Text.langu   = $session.system_language
                                            and _Text.proctyp = Process.proctyp
{
      @ObjectModel.text.element: ['ProcessText']
      @EndUserText.label: 'Status'
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key Process.proctyp as Process,
      @EndUserText.label: 'Descrição'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.procdescr as ProcessText
}
