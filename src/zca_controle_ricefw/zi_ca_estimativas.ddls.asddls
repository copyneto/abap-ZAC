@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS View Estimativas'
define view entity ZI_CA_ESTIMATIVAS
  as select from ztca_estimativa

  association        to parent ZI_CA_RICEFWS as _Ricefws   on _Ricefws.UuidRicefw = $projection.UuidRicefw
  association [1..1] to ZI_CA_PROJETOS       as _Projetos  on _Projetos.UuidProjeto = $projection.UuidProjeto
  association [0..1] to ZI_CA_VH_DESENV_OK   as _DesenvOK  on _DesenvOK.Valor = $projection.DesenvOk
  association [0..1] to I_CreatedByUser      as _Desenv    on _Desenv.UserName = $projection.DesenvAbapPo
  association [0..1] to ZI_CA_VH_STATUS      as _DevStatus on _DevStatus.Idstatus = $projection.DesenvStatus
  association [0..1] to I_CreatedByUser      as _CreatedBy on _CreatedBy.UserName = $projection.CreatedBy
  association [0..1] to I_ChangedByUser      as _ChangedBy on _ChangedBy.UserName = $projection.LastChangedBy

{
  key uuid_estimativa            as UuidEstimativa,
      uuid_projeto               as UuidProjeto,
      uuid_ricefw                as UuidRicefw,
      sequencial                 as Sequencial,
      atividade                  as Atividade,
      metrica_abap               as MetricaAbap,
      metrica_po                 as MetricaPo,
      desenv_ok                  as IdDesenvOk,
      _DesenvOK.Texto            as DesenvOk,
      dependencia                as Dependencia,
      desenv_abap_po             as DesenvAbapPo,
      _Desenv.UserDescription    as NomeDesenv,
      data_inicio                as DataInicio,
      data_prevista              as DataPrevista,
      data_entrega               as DataEntrega,
      pacote                     as Pacote,
      evolucao                   as Evolucao,
      desenv_status              as DesenvStatus,
      _DevStatus.NomeStatus      as DescStatus,
      _DevStatus.Criticidade     as StatusCriticality,
      observacoes                as Observacoes,
      @Semantics.user.createdBy: true
      created_by                 as CreatedBy,
      _CreatedBy.UserDescription as NomeCriador,
      @Semantics.systemDateTime.createdAt: true
      created_at                 as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by            as LastChangedBy,
      _ChangedBy.UserDescription as NomeModificador,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at            as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at      as LocalLastChangedAt,
      
      cast( 1 as abap.int4 )                                  as DistinctEvolucao,
      
      cast( '%' as meins )       as Percent,
      cast( 'H' as meins )       as Horas,

      case
        when data_prevista < $session.system_date
         and evolucao < 100
          then 1 else 0
       end                       as DataPrevistaCritic,

      case
        when data_entrega > data_prevista
          then 1 else 0
       end                       as DataEntregaCritic,

      _Ricefws,
      _Projetos,
      _DesenvOK,
      _Desenv,
      _DevStatus,
      _CreatedBy,
      _ChangedBy
}
