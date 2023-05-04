@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Calendário de Fábrica'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_IDENT
  as select from tfacd as CalendarioFabrica
    inner join   tfact as _Text on  _Text.spras = $session.system_language
                                and _Text.ident = CalendarioFabrica.ident
{
      @ObjectModel.text.element: ['IdentText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key CalendarioFabrica.ident as Ident,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.ltext             as IdentText
}
