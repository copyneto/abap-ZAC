@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Tipo do objeto técnico'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_EQART
  as select from t370k
    inner join   t370k_t as _Text on  _Text.eqart = t370k.eqart
                                  and _Text.spras = $session.system_language
{
       @ObjectModel.text.element: ['Text']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
  key  t370k.eqart as TipoEquip,
       @Semantics.text: true
       @Search.defaultSearchElement: true
       @Search.ranking: #HIGH
       @Search.fuzzinessThreshold: 0.7
       _Text.eartx as Text
}
