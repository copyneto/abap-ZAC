@AbapCatalog.sqlViewName: 'ZICAGETPARM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consulta de parâmetros'
define view ZI_CA_GET_PARAMETER
  with parameters
    p_modulo : ze_param_modulo,
    p_chave1 : ze_param_chave,
    p_chave2 : ze_param_chave,
    p_chave3 : ze_param_chave_3

  as select from ZI_CA_PARAM_VAL
{
  key Modulo,
  key Chave1,
  key Chave2,
  key Chave3,
  key Sign,
  key Opt,
  key Low,
      High,
      Descricao,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      SignText,
      OptText,
      /* Associations */
      _Modulo,
      _Parametros
}
where
      Modulo = $parameters.p_modulo
  and Chave1 = $parameters.p_chave1
  and Chave2 = $parameters.p_chave2
  and Chave3 = $parameters.p_chave3
