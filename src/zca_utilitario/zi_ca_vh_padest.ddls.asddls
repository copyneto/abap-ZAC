@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Impressora'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
 @Search.searchable: true
define view entity ZI_CA_VH_PADEST
  as select from tsp03  as _Printer
    inner join   tsp03l as _Text on _Text.padest = _Printer.padest
{
      @EndUserText.label: 'Impressora'
  key cast ( _Printer.padest as abap.char(30) ) as Printer,
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      @EndUserText.label: 'Descrição do dispositivo'
      _Text.lname                         as DescPrinter,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      @EndUserText.label: 'Tipo de dispositivo'
      _Printer.patype                          as PrinterType
//      ,
//      @Search.defaultSearchElement: true
//     @Search.ranking: #MEDIUM
//      @Search.fuzzinessThreshold: 0.7
//      @UI.hidden: true
//     _Printer.padest                          as PrinterSearch
}
