@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Lista de Preço'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_PLTYP
  as select from t189
    inner join   t189t as _Text on  _Text.pltyp = t189.pltyp
                                and _Text.spras = $session.system_language
{
       @ObjectModel.text.element: ['PriceListText']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
       @Search.fuzzinessThreshold: 0.8
  key  t189.pltyp  as PriceList,
       @Semantics.text: true
       @Search.defaultSearchElement: true
       @Search.ranking: #HIGH
       @Search.fuzzinessThreshold: 0.7
       _Text.ptext as PriceListText
}
