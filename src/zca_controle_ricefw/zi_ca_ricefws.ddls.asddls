@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS View RICEFWs'
@ObjectModel.semanticKey: ['IdRicefw']
@Search.searchable: true
define view entity ZI_CA_RICEFWS
  as select from ztca_ricefws

  association        to parent ZI_CA_PROJETOS  as _Projetos        on  _Projetos.UuidProjeto = $projection.UuidProjeto

  composition [0..*] of ZI_CA_ESTIMATIVAS      as _Estimativas

  association [0..1] to ZI_CA_VH_MODULOS       as _Modulos         on  _Modulos.IdModulo = $projection.IdModulo

  association [0..1] to ZI_CA_VH_CENARIO       as _Cenario         on  _Cenario.IdCenario = $projection.IdCenario

  association [0..1] to ZI_CA_VH_TIPO_RICEFW   as _TipoIni         on  _TipoIni.Valor = $projection.TipoIni

  association [0..1] to ZI_CA_VH_COMPLEXIDADE  as _ComplexABAPIni  on  _ComplexABAPIni.Valor = $projection.ComplexAbapIni

  association [0..1] to ZI_CA_VH_COMPLEXIDADE  as _ComplexPOIni    on  _ComplexPOIni.Valor = $projection.ComplexPoIni

  association [0..1] to ZI_CA_VH_TIPO_RICEFW   as _TipoReal        on  _TipoReal.Valor = $projection.TipoReal

  association [0..1] to ZI_CA_VH_COMPLEXIDADE  as _ComplexABAPReal on  _ComplexABAPReal.Valor = $projection.ComplexAbapReal

  association [0..1] to ZI_CA_VH_COMPLEXIDADE  as _ComplexPOReal   on  _ComplexPOReal.Valor = $projection.ComplexPoReal

  association [0..1] to ZI_CA_VH_METRICAS_ABAP as _MetricaABAPIni  on  _MetricaABAPIni.Tipo    = $projection.TipoIni
                                                                   and _MetricaABAPIni.Complex = $projection.ComplexAbapIni
  association [0..1] to ZI_CA_VH_METRICAS_PO   as _MetricaPOIni    on  _MetricaPOIni.Complex = $projection.ComplexPoIni

  association [0..1] to ZI_CA_VH_METRICAS_FUNC as _MetricaFuncIni  on  _MetricaFuncIni.Tipo    = $projection.TipoIni
                                                                   and _MetricaFuncIni.Complex = $projection.ComplexAbapIni
  association [0..1] to ZI_CA_VH_METRICAS_ABAP as _MetricaABAPReal on  _MetricaABAPReal.Tipo    = $projection.TipoReal
                                                                   and _MetricaABAPReal.Complex = $projection.ComplexAbapReal
  association [0..1] to ZI_CA_VH_METRICAS_PO   as _MetricaPOReal   on  _MetricaPOReal.Complex = $projection.ComplexPoReal

  association [0..1] to ZI_CA_VH_METRICAS_FUNC as _MetricaFuncReal on  _MetricaFuncReal.Tipo    = $projection.TipoReal
                                                                   and _MetricaFuncReal.Complex = $projection.ComplexAbapReal
  association [0..1] to ZI_CA_VH_SPRINT        as _Sprint          on  _Sprint.Valor = $projection.Sprint

  association [0..1] to ZI_CA_VH_STATUS        as _Status          on  _Status.Idstatus = $projection.Status

  association [0..1] to I_CreatedByUser        as _CreatedBy       on  _CreatedBy.UserName = $projection.CreatedBy

  association [0..1] to I_ChangedByUser        as _ChangedBy       on  _ChangedBy.UserName = $projection.LastChangedBy

{
  key uuid_ricefw                        as UuidRicefw,
      uuid_projeto                       as UuidProjeto,
      id_ricefw                          as IdRicefw,
      desc_ricefw                        as DescRicefw,
      id_gap                             as IdGap,
      contador                           as Contador,
      cast( id_modulo as abap.char(24) ) as IdModulo,
      id_cenario                         as IdCenario,
      _Cenario.Cenario                   as Cenario,
      sist_legado                        as SistLegado,
      tipo_ini                           as TipoIni,
      _TipoIni.Texto                     as DescTipoIni,
      complex_abap_ini                   as ComplexAbapIni,
      _ComplexABAPIni.Texto              as DescComplexABAPIni,
      _MetricaABAPIni.Metrica            as MetricaAbapIni,
      complex_po_ini                     as ComplexPoIni,
      _ComplexPOIni.Texto                as DescComplexPoIni,
      _MetricaPOIni.Metrica              as MetricaPoIni,
      _MetricaFuncIni.Metrica            as MetricaFuncIni,
      tipo_real                          as TipoReal,
      _TipoReal.Texto                    as DescTipoReal,
      complex_abap_real                  as ComplexAbapReal,
      _ComplexABAPReal.Texto             as DescComplexABAPReal,
      _MetricaABAPReal.Metrica           as MetricaAbapReal,
      complex_po_real                    as ComplexPoReal,
      _ComplexPOReal.Texto               as DescComplexPOReal,
      _MetricaPOReal.Metrica             as MetricaPoReal,
      _MetricaFuncReal.Metrica           as MetricaFuncReal,
      sprint                             as Sprint,
      _Sprint.Texto                      as DescSprint,
      status                             as Status,
      _Status.NomeStatus                 as DescStatus,
      _Status.Criticidade                as StatusCriticality,
      abap_estim_ini                     as ABAPEstimIni,
      po_estim_ini                       as POEstimIni,
      abap_estim                         as ABAPEstim,
      po_estim                           as POEstim,
      abap_desenv                        as ABAPDesenv,
      po_desenv                          as PODesenv,
      observacoes                        as Observacoes,

      @Semantics.user.createdBy: true
      created_by                         as CreatedBy,
      _CreatedBy.UserDescription         as NomeCriador,
      @Semantics.systemDateTime.createdAt: true
      created_at                         as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by                    as LastChangedBy,
      _ChangedBy.UserDescription         as NomeModificador,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at                    as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at              as LocalLastChangedAt,

      cast( 'H' as meins )               as Horas,

      _Projetos,
      _Estimativas,
      _Modulos,
      _Cenario,
      _TipoIni,
      _ComplexABAPIni,
      _MetricaABAPIni,
      _ComplexPOIni,
      _MetricaPOIni,
      _MetricaFuncIni,
      _TipoReal,
      _ComplexABAPReal,
      _MetricaABAPReal,
      _ComplexPOReal,
      _MetricaPOReal,
      _MetricaFuncReal,
      _Sprint,
      _Status,
      _CreatedBy,
      _ChangedBy
}
