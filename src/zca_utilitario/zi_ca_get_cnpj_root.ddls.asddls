@AbapCatalog.sqlViewName: 'ZVCA_ROOTCNPJ'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Busca raiz cnpj por cliente'
define view ZI_CA_GET_CNPJ_ROOT 
  as select from kna1 as a
{
  key a.kunnr,
      left(a.stcd1, 8) as rootCnpj

}
where
  stcd1 is not initial
