@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Grupo de Conta'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true

define view entity ZI_CA_VH_GRUPO_CONTA
  as select from t077d as GrpConta
  association to t077x as _Text on  _Text.spras = $session.system_language
                                and _Text.ktokd = $projection.GrupoConta
{

       @ObjectModel.text.element: ['Text']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
  key  GrpConta.ktokd    as GrupoConta,
       @Search.defaultSearchElement: true
       _Text.txt30 as Text
}
