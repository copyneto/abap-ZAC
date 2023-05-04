@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Motivo do Estorno'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_MOTESTORNO
  as select from t041c
    inner join   t041ct on  t041ct.spras = $session.system_language
                        and t041c.stgrd  = t041ct.stgrd
{
  key t041c.stgrd  as MotEstorno,
      t041ct.txt40 as TextEstorno
}
