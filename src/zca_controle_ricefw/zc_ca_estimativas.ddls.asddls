@EndUserText.label: 'Estimativas'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: ['Atividade']
define view entity ZC_CA_ESTIMATIVAS
  as projection on ZI_CA_ESTIMATIVAS
{
  key UuidEstimativa,
      UuidProjeto,
      UuidRicefw,
 
      @EndUserText.label: 'Seq'
      Sequencial,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      @EndUserText.label: 'Atividade'
      Atividade,

      @Semantics.quantity.unitOfMeasure: 'Horas'
      @EndUserText.label: 'Métrica ABAP'
      MetricaAbap,

      @Semantics.quantity.unitOfMeasure: 'Horas'
      @EndUserText.label: 'Métrica PO'
      MetricaPo,

      @EndUserText.label: 'Horas'
      Horas,

      @EndUserText.label: 'Dev.OK'
      @ObjectModel.text.element: ['DesenvOk']
      IdDesenvOk,
      DesenvOk,

      @EndUserText.label: 'Dependência'
      Dependencia,

      @EndUserText.label: 'Desenvolvedor'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CreatedByUser', element: 'UserName' }}]
      @ObjectModel.text.element: ['NomeDesenv']
      DesenvAbapPo,
      NomeDesenv,
      
      @EndUserText.label: 'Data Início'
      DataInicio,

      @EndUserText.label: 'Data Prevista'
      DataPrevista,

      @EndUserText.label: 'Data Prevista Critic.'
      DataPrevistaCritic,

      @EndUserText.label: 'Data Entrega'
      DataEntrega,

      @EndUserText.label: 'Data Entrega Critic.'
      DataEntregaCritic,

      @EndUserText.label: 'Pacote'
      Pacote,

      @EndUserText.label: 'Pencentual'
      Percent,
      
      @Semantics.quantity.unitOfMeasure: 'Percent'
      @EndUserText.label: 'Evolução'
      Evolucao,
      
      @EndUserText.label: 'Evolução'
      DistinctEvolucao,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_STATUS', element: 'Idstatus' }}]
      @EndUserText.label: 'Status'
      @ObjectModel.text.element: ['DescStatus']
      DesenvStatus,
      @EndUserText.label: 'Descrição Status'
      DescStatus,
      @EndUserText.label: 'Criticidade Status'
      StatusCriticality,
      @EndUserText.label: 'Observações'
      @UI.multiLineText: true
      Observacoes,

      @EndUserText.label: 'Criado Por'
      @ObjectModel.text.element: ['NomeCriador']
      CreatedBy,
      NomeCriador,

      @EndUserText.label: 'Criado Em'
      CreatedAt,

      @EndUserText.label: 'Modificado Por'
      @ObjectModel.text.element: ['NomeModificador']
      LastChangedBy,
      NomeModificador,

      @EndUserText.label: 'Modificado Em'
      LastChangedAt,

      @EndUserText.label: 'Última Modif.'
      LocalLastChangedAt,

      /* Associations */
      _Projetos : redirected to ZC_CA_PROJETOS,
      _Ricefws  : redirected to parent ZC_CA_RICEFWS

}
