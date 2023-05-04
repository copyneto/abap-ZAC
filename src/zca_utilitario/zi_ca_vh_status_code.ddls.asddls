@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: NFe Status code'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_STATUS_CODE
  as select from j_1bstscode  as _StatusCode
    inner join   j_1bstscodet as _Text on  _Text.code  = _StatusCode.code
                                       and _Text.spras = $session.system_language
{
       @ObjectModel.text.element: ['StatusCodeText']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
  key  _StatusCode.code as StatusCode,
       @Semantics.text: true
       @Search.defaultSearchElement: true
       @Search.ranking: #HIGH
       @Search.fuzzinessThreshold: 0.7
       _Text.text       as StatusCodeText
}
