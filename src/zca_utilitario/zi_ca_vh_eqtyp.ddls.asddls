@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Categoria de equipamento'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_EQTYP
  as select from t370t
    inner join   t370u as _Text on  _Text.eqtyp = t370t.eqtyp
                                and _Text.spras = $session.system_language
{
       @ObjectModel.text.element: ['Text']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
  key  t370t.eqtyp as CategoriaEquip,
       @Semantics.text: true
       @Search.defaultSearchElement: true
       @Search.ranking: #HIGH
       @Search.fuzzinessThreshold: 0.7
       _Text.typtx as Text
  }
