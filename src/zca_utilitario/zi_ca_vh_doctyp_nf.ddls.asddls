@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Tipos de Documento da NF'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_DOCTYP_NF
  as select from j_1bdoctypest
{
      @ObjectModel.text.element: ['Text']
      @Search.defaultSearchElement: true
  key doctyp as BR_NFDocumentType,
      @Search.defaultSearchElement: true
      text   as Text
}
where
  spras = $session.system_language
