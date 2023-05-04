@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Modalidade de frete'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_MDFRETE
  as select from    dd07l as Domain
    left outer join dd07t as Text on  Text.domname    = Domain.domname
                                  and Text.as4local   = Domain.as4local
                                  and Text.valpos     = Domain.valpos 
                                  and Text.as4vers    = Domain.as4vers
                                  and Text.ddlanguage = $session.system_language
{
       @ObjectModel.text.element: ['Nome']
  key  Domain.domvalue_l as mdFrete,
       Text.ddtext       as Nome
}
where
  Domain.domname = 'ZD_MDFRETE'
