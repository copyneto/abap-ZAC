@AbapCatalog.sqlViewName: 'ZVCA_BEWAR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Tipo de Movimento'
define view ZI_CA_VH_BEWAR
  as select from t856t
{

  key langu as Langu,
  key trtyp as Trtyp,
      txt   as Txt

}
where
  langu = 'P'
