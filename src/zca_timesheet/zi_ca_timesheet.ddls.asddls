@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View Interface Timesheet'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_CA_TIMESHEET 
as select from ztca_timesheet as TimeSheet {
    key guid as Guid,
    id as Id,
    contrato as Contrato,
    ge_contrato as GestorContrato,
    tp_hora as TpHora,
    equipe as Equipe,
    tarefa as Tarefa,
    tp_tarefa as TpTarefa,
    usuario as Usuario,
    dt_apro as DtApropriacao,
    hr_apro as HrAprovada,
    hr_inf as HrInformada,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
}
