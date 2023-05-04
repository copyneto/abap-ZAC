@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Tipo de documento de vendas'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_AUART
  as select from    tvak  as SalesDocumentType
    left outer join tvakt as _Text on  _Text.spras = $session.system_language
                                   and _Text.auart = SalesDocumentType.auart
{
      @ObjectModel.text.element: ['SalesDocumentTypeName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key SalesDocumentType.auart as SalesDocumentType,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.bezei             as SalesDocumentTypeName
}
where SalesDocumentType.sperr = ''
