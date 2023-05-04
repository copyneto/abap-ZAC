@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Status RICEFW'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
@Search.searchable : true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CA_VH_STATUS
  as select from ztca_status as _Status
{
      @ObjectModel.text.element: ['NomeStatus']
      @UI.textArrangement: #TEXT_LAST
  key idstatus    as Idstatus,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.90
      status      as NomeStatus,
      criticidade as Criticidade
}
