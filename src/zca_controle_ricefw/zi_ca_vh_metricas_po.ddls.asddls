@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Métricas PO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CA_VH_METRICAS_PO
  as select from ztca_metricas as _Metricas
{
  key complex as Complex,
      metrica as Metrica
}
where
      espec = 'P'
  and tipo  = 'I'
