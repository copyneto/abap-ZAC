@EndUserText.label: 'View Consumption Parâmetro - Valores'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_CA_PARAM_VAL
  as projection on ZI_CA_PARAM_VAL
{

      @ObjectModel.text.element: ['ModuloDescricao']
  key Modulo,

  key Chave1,

  key Chave2,

  key Chave3,
      @Consumption.valueHelpDefinition: [ {
            entity: {
              name: 'ZI_CA_PARAM_SIGN',
              element: 'DomvalueL'
            }
          } ]

      @ObjectModel.text.element: ['SignText']
      @UI.textArrangement: #TEXT_LAST
  key Sign,

      @Consumption.valueHelpDefinition: [ {
            entity: {
              name: 'ZI_CA_PARAM_DDOPTION',
              element: 'DomvalueL'
            }
          } ]

      @ObjectModel.text.element: ['OptText']
      @UI.textArrangement: #TEXT_LAST
  key Opt,

  key Low,

      High,

      Descricao,

      LastChangedBy,

      LocalLastChangedAt,

      _Modulo.Descricao as ModuloDescricao,

      OptText,

      SignText,

      /* Associations */
      _Modulo     : redirected to ZC_CA_PARAM_MOD,
      _Parametros : redirected to parent ZC_CA_PARAM_PAR
}
