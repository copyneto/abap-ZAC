@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Centro de Custo'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_KOSTL as select from csks
  association [0..1] to cskt as _Text on _Text.kokrs = $projection.Area and 
                                         _Text.kostl = $projection.CentroCusto and
                                         _Text.spras = $session.system_language
{

    key kokrs       as Area,
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @ObjectModel.text.element: ['Descricao']    
    key kostl       as CentroCusto,
    @Semantics.text: true
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.7
    _Text.ktext     as Denominacao,
    _Text.ltext     as Descricao
}
