@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Impressoras'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZI_CA_PRINT
  as select from tsp03  as _Printer
    inner join   tsp03l as _Text on _Text.padest = _Printer.padest
{
      @EndUserText.label: 'Impressora'
  key cast ( _Printer.padest as abap.char( 4) ) as Printer,
      @EndUserText.label: 'Descrição do dispositivo'
      _Text.lname                               as DescPrinter,
      @EndUserText.label: 'Tipo de dispositivo'
      _Printer.patype                           as PrinterType
}
