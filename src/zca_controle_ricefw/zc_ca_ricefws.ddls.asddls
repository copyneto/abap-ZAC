@EndUserText.label: 'RICEFWs'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: ['DescRicefw']
define view entity ZC_CA_RICEFWS
  as projection on ZI_CA_RICEFWS
{
  key UuidRicefw,
      UuidProjeto,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.50
      @EndUserText.label: 'RICEFW'
      IdRicefw,

      @EndUserText.label: 'GAP'
      IdGap,

      @EndUserText.label: 'Contador'
      Contador,

      @EndUserText.label: 'Descrição'
      @UI.multiLineText: true
      DescRicefw,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_MODULOS', element: 'IdModulo' }}]
      @EndUserText.label: 'Módulo'
      @ObjectModel.text.element: ['Modulo']
      IdModulo,
      _Modulos.NomeModulo as Modulo,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_CENARIO', element: 'IdCenario' }}]
      @EndUserText.label: 'Cenário'
      @ObjectModel.text.element: ['Cenario']
      IdCenario,
      Cenario,

      @EndUserText.label: 'Sistema Legado'
      SistLegado,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_TIPO_RICEFW', element: 'Valor' }}]
      @EndUserText.label: 'Tipo Inicial'
      @ObjectModel.text.element: ['DescTipoIni']
      TipoIni,
      DescTipoIni,

      // Estimativa Inicial ABAP
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_COMPLEXIDADE', element: 'Valor' }}]
      @EndUserText.label: 'Comp.Ini.ABAP'
      @ObjectModel.text.element: ['DescComplexABAPIni']
      ComplexAbapIni,
      DescComplexABAPIni,

//      @Semantics.quantity.unitOfMeasure: 'Horas'
      @EndUserText.label: 'Mét.Ini.ABAP'
      MetricaAbapIni,

      @EndUserText.label: 'ABAP Estim.Ini.'
      ABAPEstimIni,

      // Estimativa Inicial PO
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_COMPLEXIDADE', element: 'Valor' }}]
      @EndUserText.label: 'Comp.Ini.PO'
      @ObjectModel.text.element: ['DescComplexPoIni']
      ComplexPoIni,
      DescComplexPoIni,

//      @Semantics.quantity.unitOfMeasure: 'Horas'
      @EndUserText.label: 'Mét.Ini.PO'
      MetricaPoIni,

      @EndUserText.label: 'PO Estim.Ini.'
      POEstimIni,

//      @Semantics.quantity.unitOfMeasure: 'Horas'
      @EndUserText.label: 'Mét.Ini.Func.'
      MetricaFuncIni,

      // Estimativa EF ABAP
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_TIPO_RICEFW', element: 'Valor' }}]
      @EndUserText.label: 'Tipo EF'
      @ObjectModel.text.element: ['DescTipoReal']
      TipoReal,
      DescTipoReal,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_COMPLEXIDADE', element: 'Valor' }}]
      @EndUserText.label: 'Comp.EF ABAP'
      @ObjectModel.text.element: ['DescComplexABAPReal']
      ComplexAbapReal,
      DescComplexABAPReal,

//      @Semantics.quantity.unitOfMeasure: 'Horas'
      @EndUserText.label: 'Mét.EF ABAP'
      MetricaAbapReal,

      @EndUserText.label: 'ABAP Estim.EF'
      ABAPEstim,

      // Estimativa EF PO
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_COMPLEXIDADE', element: 'Valor' }}]
      @EndUserText.label: 'Comp.EF PO'
      @ObjectModel.text.element: ['DescComplexPOReal']
      ComplexPoReal,
      @EndUserText.label: 'Desc.Complex.EF'
      DescComplexPOReal,

//      @Semantics.quantity.unitOfMeasure: 'Horas'
      @EndUserText.label: 'Mét.EF PO'
      MetricaPoReal,

      @EndUserText.label: 'PO Estim.EF'
      POEstim,

//      @Semantics.quantity.unitOfMeasure: 'Horas'
      @EndUserText.label: 'Mét.EF Func.'
      MetricaFuncReal,

      @EndUserText.label: 'Horas'
      Horas,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_SPRINT', element: 'Valor' }}]
      @EndUserText.label: 'Sprint'
      @ObjectModel.text.element: ['DescSprint']
      Sprint,
      @EndUserText.label: 'Descrição Sprint'
      DescSprint,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_STATUS', element: 'Idstatus' }}]
      @EndUserText.label: 'Status'
      @ObjectModel.text.element: ['DescStatus']
      Status,
      @EndUserText.label: 'Descrição Status'
      DescStatus,
      @EndUserText.label: 'Criticidade Status'
      StatusCriticality,

      @EndUserText.label: 'ABAP Desenv.'
      ABAPDesenv,

      @EndUserText.label: 'PO Desenv.'
      PODesenv,

      @EndUserText.label: 'Observações'
      @UI.multiLineText: true
      Observacoes,

      @EndUserText.label: 'Criado Por'
      @ObjectModel.text.element: ['NomeCriador']
      CreatedBy,
      @EndUserText.label: 'Nome do Criador'
      NomeCriador,

      @EndUserText.label: 'Criado Em'
      CreatedAt,

      @EndUserText.label: 'Modificado Por'
      @ObjectModel.text.element: ['NomeModificador']
      LastChangedBy,
      @EndUserText.label: 'Nome do Modificador'
      NomeModificador,

      @EndUserText.label: 'Modificado Em'
      LastChangedAt,

      @EndUserText.label: 'Última Modif.'
      LocalLastChangedAt,


      /* Associations */
      _Projetos    : redirected to parent ZC_CA_PROJETOS,
      _Estimativas : redirected to composition child ZC_CA_ESTIMATIVAS,
      _Modulos
//      _Cenario,
//      _TipoIni,
//      _ComplexABAPIni,
//      _MetricaABAPIni,
//      _TipoReal,
//      _ComplexABAPReal,
//      _ComplexPOIni,
//      _ComplexPOReal,
//      _MetricaABAPReal,
//      _MetricaFuncIni,
//      _MetricaFuncReal,
//      _MetricaPOIni,
//      _MetricaPOReal,
//      _Sprint,
//      _Status,
//      _CreatedBy,
//      _ChangedBy
}
