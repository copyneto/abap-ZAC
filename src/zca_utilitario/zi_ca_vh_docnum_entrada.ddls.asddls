@AbapCatalog.sqlViewName: 'ZVCA_NFENTRAD'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: N° Documento Entrada'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view zi_ca_vh_docnum_entrada 
 as select from j_1bnfdoc as _NfSaida
{
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
  key _NfSaida.docnum as DocnumEntrada,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      _NfSaida.nfenum as NfeEntrada
}
where
  direct = '1'
