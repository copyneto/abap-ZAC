@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Grupo de condições clientes'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
serviceQuality: #X,
sizeCategory: #S,
dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_TVKGGT
  as select from tvkggt
{
//  key spras as Spras,
  key kdkgr as Kdkgr,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      vtext as Vtext
}
where
spras = $session.system_language
