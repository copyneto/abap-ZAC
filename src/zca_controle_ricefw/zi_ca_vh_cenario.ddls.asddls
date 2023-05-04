@EndUserText.label: 'Value Help para Domínios'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CA_VH_CENARIO
  as select from    ztca_cenario  as _Cenario
    left outer join ztca_cenariot as _Text on  _Text.id_cenario = _Cenario.id_cenario
                                           and _Text.langu      = $session.system_language
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      @ObjectModel.text.element: ['Cenario']
  key _Cenario.id_cenario as IdCenario,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.95
      _Text.desc_cenario  as Cenario
}
