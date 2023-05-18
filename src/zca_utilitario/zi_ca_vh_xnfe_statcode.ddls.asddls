@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Código de status (SEFAZ)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_XNFE_STATCODE
  as select from    /xnfe/tstat  as Status
    left outer join /xnfe/tstatt as _Text on  _Text.langu    = $session.system_language
                                          and _Text.statcode = Status.statcode
{
      @ObjectModel.text.element: ['StatusText']
      @EndUserText.label: 'Status'
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key Status.statcode                  as StatusCode,
      @EndUserText.label: 'Descrição'
      replace( _Text.description, 'NF-e', 'MDF-e') as StatusText
}
