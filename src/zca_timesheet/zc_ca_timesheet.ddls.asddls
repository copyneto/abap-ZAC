@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View Consumo Timesheet'
@Metadata.allowExtensions: true

define root view entity ZC_CA_TIMESHEET 
as projection on ZI_CA_TIMESHEET  {
    @EndUserText.label: 'Guid Gerado'
    key Guid,
    @EndUserText.label: 'ID Importação'
    Id,
    @EndUserText.label: 'Contrato'
    @Consumption.valueHelpDefinition: [ { entity:  { name: 'ZI_CA_VH_TIMESHEET_CONTRATO', element: 'Contrato' } }]
    Contrato,
    @EndUserText.label: 'Gestor do Contrato'
    @Consumption.valueHelpDefinition: [ { entity:  { name: 'ZI_CA_VH_TIMESHEET_GCONTRATO', element: 'GestorContrato' } }]
    GestorContrato,
    @EndUserText.label: 'Tipo de Hora'
    @Consumption.valueHelpDefinition: [ { entity:  { name: 'ZI_CA_VH_TIMESHEET_TP_HORA', element: 'TpHora' } }]
    TpHora,
    @EndUserText.label: 'Equipe'
    @Consumption.valueHelpDefinition: [ { entity:  { name: 'ZI_CA_VH_TIMESHEET_EQUIPE', element: 'Equipe' } }]
    Equipe,
    @EndUserText.label: 'Tarefa'
    @Consumption.valueHelpDefinition: [ { entity:  { name: 'ZI_CA_VH_TIMESHEET_TAREFA', element: 'Tarefa' } }]
    Tarefa,
    @EndUserText.label: 'Tipo de Tarefa'
    @Consumption.valueHelpDefinition: [ { entity:  { name: 'ZI_CA_VH_TIMESHEET_TP_TAREFA', element: 'TpTarefa' } }]
    TpTarefa,
    @EndUserText.label: 'Usuário'
    @Consumption.valueHelpDefinition: [ { entity:  { name: 'ZI_CA_VH_TIMESHEET_USUARIO', element: 'Usuario' } }]
    Usuario,
    @EndUserText.label: 'Data Apropriação'
    DtApropriacao,
    @EndUserText.label: 'Horas Aprovada'
    HrAprovada,
    @EndUserText.label: 'Horas Informada'
    HrInformada,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt    
}
