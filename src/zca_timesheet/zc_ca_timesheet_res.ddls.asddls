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
//    @UI : { lineItem      : [ { position: 40 } ]}
//    @UI : { selectionField : [ { position: 40 } ]}
//    @EndUserText.label: 'Data Apropriação'    
//    @Consumption.filter.selectionType: #INTERVAL
//    DtApropriacao: abap.dats;            
//    @UI : { lineItem      : [ { position: 60 } ]}
//    @EndUserText.label: 'Horas Informada'            
//    HrInformada : abap.char( 20 );

    @UI : { lineItem      : [ { position: 50 } ]}
    @EndUserText.label: '26'
    @Aggregation.default  :#SUM            
    d26 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 60 } ]}
    @EndUserText.label: '27'   
    @Aggregation.default  :#SUM         
    d27 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 70 } ]}        
    @EndUserText.label: '28'   
    @Aggregation.default  :#SUM         
    d28 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 80 } ]}
    @EndUserText.label: '29'   
    @Aggregation.default  :#SUM         
    d29 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 90 } ]}
    @EndUserText.label: '30'   
    @Aggregation.default  :#SUM         
    d30 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 100 } ]}
    @EndUserText.label: '31'   
    @Aggregation.default  :#SUM         
    d31 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 110 } ]}
    @EndUserText.label: '01'   
    @Aggregation.default  :#SUM         
    d01 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 120 } ]}
    @EndUserText.label: '02'
    @Aggregation.default  :#SUM            
    d02 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 130 } ]}
    @EndUserText.label: '03'   
    @Aggregation.default  :#SUM         
    d03 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 140 } ]}
    @EndUserText.label: '04'   
    @Aggregation.default  :#SUM         
    d04 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 150 } ]}
    @EndUserText.label: '05'   
    @Aggregation.default  :#SUM         
    d05 : abap.char( 10 ); 
    @UI : { lineItem      : [ { position: 160 } ]}
    @EndUserText.label: '06'   
    @Aggregation.default  :#SUM         
    d06 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 170 } ]}
    @EndUserText.label: '07'   
    @Aggregation.default  :#SUM         
    d07 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 180 } ]}
    @EndUserText.label: '08'   
    @Aggregation.default  :#SUM         
    d08 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 190 } ]}
    @EndUserText.label: '09'   
    @Aggregation.default  :#SUM         
    d09 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 200 } ]}
    @EndUserText.label: '10'    
    @Aggregation.default  :#SUM        
    d10 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 210 } ]}
    @EndUserText.label: '11'   
    @Aggregation.default  :#SUM         
    d11 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 220 } ]}
    @EndUserText.label: '12' 
    @Aggregation.default  :#SUM           
    d12 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 230 } ]}
    @EndUserText.label: '13'   
    @Aggregation.default  :#SUM         
    d13 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 240 } ]}
    @EndUserText.label: '14'   
    @Aggregation.default  :#SUM         
    d14 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 250 } ]}
    @EndUserText.label: '15'   
    @Aggregation.default  :#SUM         
    d15 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 260 } ]}
    @EndUserText.label: '16'   
    @Aggregation.default  :#SUM         
    d16 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 270 } ]}
    @EndUserText.label: '17'   
    @Aggregation.default  :#SUM         
    d17 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 280 } ]}
    @EndUserText.label: '18'   
    @Aggregation.default  :#SUM         
    d18 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 290 } ]}
    @EndUserText.label: '19'   
    @Aggregation.default  :#SUM         
    d19 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 300 } ]}
    @EndUserText.label: '20'   
    @Aggregation.default  :#SUM         
    d20 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 310 } ]}
    @EndUserText.label: '21'   
    @Aggregation.default  :#SUM         
    d21 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 320 } ]}
    @EndUserText.label: '22'   
    @Aggregation.default  :#SUM         
    d22 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 330 } ]}
    @EndUserText.label: '23'   
    @Aggregation.default  :#SUM         
    d23 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 340 } ]}
    @EndUserText.label: '24'   
    @Aggregation.default  :#SUM         
    d24 : abap.char( 10 );
    @UI : { lineItem      : [ { position: 350 } ]}
    @EndUserText.label: '25'   
    @Aggregation.default  :#SUM         
    d25 : abap.char( 10 );                                                                                                                                                       
}
