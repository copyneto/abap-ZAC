@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Origem da entrada'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_SCMTMS_SET_BY_SERVICE
  as select from dd07l as Domain
    join         dd07t as _Text on  _Text.domname    = Domain.domname
                                and _Text.as4local   = Domain.as4local
                                and _Text.valpos     = Domain.valpos
                                and _Text.as4vers    = Domain.as4vers
                                and _Text.ddlanguage = $session.system_language
{
      @ObjectModel.text.element: ['SetByServiceText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key cast( Domain.domvalue_l as /scmtms/set_by_service  ) as SetByService,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.ddtext                                         as SetByServiceText
}
where
      Domain.domname  = '/SCMTMS/SET_BY_SERVICE'
  and Domain.as4local = 'A'
