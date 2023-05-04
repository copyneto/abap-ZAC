@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Função parceiro'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_PARVW
  as select from tpar
  association [0..1] to tpart as _Text on  _Text.parvw = $projection.PartnerFunction
                                       and _Text.spras = $session.system_language
{
  @ObjectModel.text.element: ['PartnerFunctionName']
  @Search.ranking: #MEDIUM
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  parvw       as PartnerFunction,
  @Semantics.text: true
  @Search.defaultSearchElement: true
  @Search.ranking: #HIGH
  @Search.fuzzinessThreshold: 0.7
  _Text.vtext as PartnerFunctionName

}
