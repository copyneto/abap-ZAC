@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View Basic Parâmetro - Parâmetros'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_PARAM_PAR
  as select from ztca_param_par
  association to parent ZI_CA_PARAM_MOD as _Modulo on $projection.Modulo = _Modulo.Modulo
  composition [0..*] of ZI_CA_PARAM_VAL as _Valor
{
      @EndUserText.label: 'Módulo'
  key modulo                as Modulo,
      @EndUserText.label: 'Chave 1'
  key chave1                as Chave1,
      @EndUserText.label: 'Chave 2'
  key chave2                as Chave2,
      @EndUserText.label: 'Chave 3'
  key chave3                as Chave3,
      @EndUserText.label: 'Descrição'
      descricao             as Descricao,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,

      _Modulo,
      _Valor
}
