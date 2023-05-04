@AbapCatalog.sqlViewName: 'ZVCA_PLANCONT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Plano de Contas'
define view ZI_CA_VH_PLANCONTAS
  as select from I_ChartOfAccountsText
{

  key ChartOfAccounts,
  key Language,
      ChartOfAccountsName,
      /* Associations */
      _ChartOfAccounts,
      _ChartOfAccountsText,
      _Language

}
where
  Language = $session.system_language
