@EndUserText.label: 'View Consumo Timesheet Resumo'
@ObjectModel: { query.implementedBy: 'ABAP:ZCLCA_TIMESHEET_RESUMO'}

@UI: { headerInfo: { typeName: 'Relatório de Horas Agrupado',
                     typeNamePlural: 'Relatório de Horas Agrupado' } }

@UI.presentationVariant: [{
     groupBy: [ 'Contrato', 'Tarefa', 'Usuario' ],
     initialExpansionLevel: 1,
     requestAtLeast: [ 'Contrato', 'Tarefa', 'Usuario'],
     includeGrandTotal: true }]

define custom entity ZC_CA_TIMESHEET_RES 
{
  
    @UI : { lineItem      : [ { position: 10 } ]}
    @UI : { selectionField : [ { position: 10 } ]}
    @EndUserText.label: 'Contrato'    
    @Consumption.valueHelpDefinition: [ { entity:  { name: 'ZI_CA_VH_TIMESHEET_CONTRATO', element: 'Contrato' } }]    
    key Contrato : abap.char( 250 );
    @UI : { lineItem      : [ { position: 20 } ]}
    @UI : { selectionField : [ { position: 20 } ]}
    @EndUserText.label: 'Tarefa'               
    @Consumption.valueHelpDefinition: [ { entity:  { name: 'ZI_CA_VH_TIMESHEET_TAREFA', element: 'Tarefa' } }]
    key Tarefa : abap.char( 250 );
    @UI : { lineItem      : [ { position: 30 } ]}
    @UI : { selectionField : [ { position: 30 } ]}
    @EndUserText.label: 'Usuário'        
    @Consumption.valueHelpDefinition: [ { entity:  { name: 'ZI_CA_VH_TIMESHEET_USUARIO', element: 'Usuario' } }]
    key Usuario: abap.char( 250 );
    @UI : { selectionField : [ { position: 40 } ]}
    @EndUserText.label: 'Data Apropriação'    
    @Consumption.filter.selectionType: #INTERVAL
    DtApro: abap.dats;            
    @UI : { lineItem      : [ { position: 45 } ]}
    @EndUserText.label: 'HH Total'       
    hhTotal : abap.char( 10 );
    @UI : { lineItem      : [ { position: 50 } ]}
    @EndUserText.label: '26'       
    d26 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 60 } ]}
    @EndUserText.label: '27'       
    d27 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 70 } ]}        
    @EndUserText.label: '28'       
    d28 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 80 } ]}
    @EndUserText.label: '29'       
    d29 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 90 } ]}
    @EndUserText.label: '30'       
    d30 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 100 } ]}
    @EndUserText.label: '31'       
    d31 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 110 } ]}
    @EndUserText.label: '01'       
    d01 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 120 } ]}
    @EndUserText.label: '02'       
    d02 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 130 } ]}
    @EndUserText.label: '03'       
    d03 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 140 } ]}
    @EndUserText.label: '04'       
    d04 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 150 } ]}
    @EndUserText.label: '05'       
    d05 : abap.char( 10 ); 
    @UI : { lineItem      : [ { position: 160 } ]}
    @EndUserText.label: '06'       
    d06 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 170 } ]}
    @EndUserText.label: '07'       
    d07 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 180 } ]}
    @EndUserText.label: '08'       
    d08 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 190 } ]}
    @EndUserText.label: '09'       
    d09 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 200 } ]}
    @EndUserText.label: '10'    
    @Aggregation.default  :#SUM        
    d10 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 210 } ]}
    @EndUserText.label: '11'       
    d11 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 220 } ]}
    @EndUserText.label: '12'       
    d12 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 230 } ]}
    @EndUserText.label: '13'       
    d13 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 240 } ]}
    @EndUserText.label: '14'       
    d14 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 250 } ]}
    @EndUserText.label: '15'       
    d15 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 260 } ]}
    @EndUserText.label: '16'       
    d16 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 270 } ]}
    @EndUserText.label: '17'       
    d17 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 280 } ]}
    @EndUserText.label: '18'       
    d18 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 290 } ]}
    @EndUserText.label: '19'       
    d19 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 300 } ]}
    @EndUserText.label: '20'       
    d20 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 310 } ]}
    @EndUserText.label: '21'       
    d21 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 320 } ]}
    @EndUserText.label: '22'       
    d22 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 330 } ]}
    @EndUserText.label: '23'       
    d23 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 340 } ]}
    @EndUserText.label: '24'       
    d24 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 350 } ]}
    @EndUserText.label: '25'       
    d25 : abap.char( 10 );                                                                                                                                                       
}
