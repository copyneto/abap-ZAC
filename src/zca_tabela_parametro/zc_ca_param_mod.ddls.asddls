@EndUserText.label: 'View Consumption Parâmetro - Módulo'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

define root view entity ZC_CA_PARAM_MOD
  as projection on ZI_CA_PARAM_MOD
{
      @ObjectModel.text.element: ['Descricao']
  key Modulo,
      Descricao,
      LastChangedBy,
      LocalLastChangedAt,
      
      /* Associations */
      _Parametros : redirected to composition child ZC_CA_PARAM_PAR
}
