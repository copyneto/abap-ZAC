@EndUserText.label: 'Projetos - Value Help'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable : true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CA_VH_PROJETOS
  as select from ztca_projetos
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.90
      @EndUserText.label: 'Projeto'
  key projeto    as Projeto,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.90
      @EndUserText.label: 'Cliente'
      cliente    as Cliente,
      @EndUserText.label: 'Criado Por'
      created_by as CreatedBy,
      @EndUserText.label: 'Criado Em'
      created_at as CreatedAt
}
