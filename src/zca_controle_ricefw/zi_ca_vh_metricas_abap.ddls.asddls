@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Métricas ABAP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CA_VH_METRICAS_ABAP
  as select from ztca_metricas as _Metricas
{
  key tipo    as Tipo,
  key complex as Complex,
      metrica as Metrica
}
where
  espec = 'A'
