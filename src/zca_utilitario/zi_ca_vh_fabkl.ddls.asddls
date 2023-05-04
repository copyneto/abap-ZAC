@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help Calendário de fábrica'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_FABKL
  as select from tfacd
    inner join   tfact as Text on  Text.ident = tfacd.ident
                               and Text.spras = $session.system_language
{
      @ObjectModel.text.element: ['Descricao']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key tfacd.ident as IDCalend,

      tfacd.vjahr as Vjahr,
      tfacd.bjahr as Bjahr,
      tfacd.hocid as Hocid,
      tfacd.basis as Basis,
      tfacd.abbr  as Abbr,
      Text.ltext  as Descricao

}
