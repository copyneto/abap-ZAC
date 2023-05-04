@EndUserText.label: 'View Consumption Parâmetro - Parâmetros'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search.searchable: true
define view entity ZC_CA_PARAM_PAR
  as projection on ZI_CA_PARAM_PAR
{

      @ObjectModel.text.element: ['ModuloDescricao']
  key Modulo,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key Chave1,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key Chave2,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key Chave3,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Descricao,
      LastChangedBy,
      LocalLastChangedAt,

      _Modulo.Descricao as ModuloDescricao,

      /* Associations */
      _Modulo : redirected to parent ZC_CA_PARAM_MOD,
      _Valor  : redirected to composition child ZC_CA_PARAM_VAL
}
