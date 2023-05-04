@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Classe de risco'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_RISK_CLASS
  as select from ukm_risk_cl   as ClasseRisco
    inner join   ukm_risk_cl0t as _Text on  _Text.langu      = $session.system_language
                                        and _Text.risk_class = ClasseRisco.risk_class
{
      @ObjectModel.text.element: ['ClasseRiscoText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key ClasseRisco.risk_class as ClasseRisco,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.risk_class_txt   as ClasseRiscoText
}
