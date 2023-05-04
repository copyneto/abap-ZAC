@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View Basic Parâmetro - Valores'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_PARAM_VAL
  as select from ztca_param_val
  association        to parent ZI_CA_PARAM_PAR as _Parametros on  $projection.Modulo = _Parametros.Modulo
                                                              and $projection.Chave1 = _Parametros.Chave1
                                                              and $projection.Chave2 = _Parametros.Chave2
                                                              and $projection.Chave3 = _Parametros.Chave3
  association [1..1] to ZI_CA_PARAM_MOD        as _Modulo     on  $projection.Modulo = _Modulo.Modulo
  association [1..1] to ZI_CA_PARAM_SIGN       as _Sign       on  $projection.Sign = _Sign.DomvalueL
  association [1..1] to ZI_CA_PARAM_DDOPTION   as _DDOption   on  $projection.Opt = _DDOption.DomvalueL
{
      @EndUserText.label: 'Módulo'
  key modulo                                                               as Modulo,
      @EndUserText.label: 'Chave 1'
  key chave1                                                               as Chave1,
      @EndUserText.label: 'Chave 2'
  key chave2                                                               as Chave2,
      @EndUserText.label: 'Chave 3'
  key chave3                                                               as Chave3,
      @EndUserText.label: 'Sinal'
  key sign                                                                 as Sign,
      @EndUserText.label: 'Opção'
  key opt                                                                  as Opt,
      @EndUserText.label: 'Valor Mínimo'
  key low                                                                  as Low,
      @EndUserText.label: 'Valor Máximo'
      high                                                                 as High,
      @EndUserText.label: 'Descrição'
      concat( '(', concat( modulo , concat( ')', _Parametros.Descricao)) ) as Descricao,
      @Semantics.user.createdBy: true
      created_by                                                           as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at                                                           as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                                                      as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                                                      as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at                                                as LocalLastChangedAt,

      _Sign.Text                                                           as SignText,
      _DDOption.Text                                                       as OptText,

      _Modulo,
      _Parametros

}
