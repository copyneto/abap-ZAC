@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View Interface Timesheet Resumo'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_TIMESHEET_RES as select from ZI_CA_TIMESHEET {        
    key Contrato,           
    key Tarefa,    
    key Usuario,
    key DtApropriacao,    
    //sum ( cast(cast( HrInformada as abap.char( 20 ) ) as abap.numc( 20 ) ) )  as HrInformada
    HrInformada        
}
group by
    Contrato,           
    Tarefa,    
    Usuario,
    DtApropriacao,
    HrInformada
