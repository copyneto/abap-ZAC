@AbapCatalog.sqlViewName: 'ZVCA_SHKZG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'DD'
define view ZI_CA_VH_SHKZG
  as select from I_DebitCreditCodeText
{
  key Language,
  key DebitCreditCode,
      DebitCreditCodeName,
      /* Associations */
      _Language
}
where
  Language = 'P'
