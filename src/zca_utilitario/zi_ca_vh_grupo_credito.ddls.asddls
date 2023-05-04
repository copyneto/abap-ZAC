@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help - Grupo credito'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_GRUPO_CREDITO
  as select from ukm_cust_grp as GrupoCredito

  association [0..1] to ukm_cust_grp0t as _GrupoCreditoText on  _GrupoCreditoText.cred_group = $projection.GrupoCredito
                                                            and _GrupoCreditoText.langu      = $session.system_language
{
      @ObjectModel.text.element: ['GrupoCreditoText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key cred_group                       as GrupoCredito,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _GrupoCreditoText.cred_group_txt as GrupoCreditoText,

      _GrupoCreditoText

}
