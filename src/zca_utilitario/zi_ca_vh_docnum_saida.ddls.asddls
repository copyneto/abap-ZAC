@AbapCatalog.sqlViewName: 'ZVCA_NFSAIDA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: N° Documento Saída'
@Search.searchable: true
define view zi_ca_vh_docnum_saida
  as select from j_1bnfdoc as _NfSaida
{
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
  key _NfSaida.docnum as DocnumSaida,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      _NfSaida.nfenum as NfeSaida
}
where
  direct = '2'
