@AbapCatalog.sqlViewName: 'ZICA_GRPMERCEXT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Grupo de Mercadoria'
@Search.searchable: true
define view ZI_CA_VH_GRP_MERC_EXT
  as select from twew as GrpMercExt
  association to twewt as _Text on  _Text.extwg = $projection.GrpMercExt
                                and _Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key extwg       as GrpMercExt,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.ewbez as Text
}
