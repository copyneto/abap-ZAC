@AbapCatalog.sqlViewName: 'ZVCA_CLIROOT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Busca Cliente por raiz CNPJ'
define view ZI_CA_GET_KUNNR_BY_CNPJROOT
  as select distinct from ZI_CA_GET_CNPJ_ROOT as a
    inner join            ZI_CA_GET_CNPJ_ROOT as b on a.rootCnpj = b.rootCnpj
{

  key a.kunnr    as ClienteBase,
  key b.kunnr    as Cliente,
      b.rootCnpj as rootCnpj

}
