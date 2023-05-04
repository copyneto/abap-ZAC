@AbapCatalog.sqlViewName: 'ZVCA_BSCHL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'Posting Key'
@EndUserText.label: 'Match Code: Chave Lançamento'
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZI_CA_VH_BSCHL
  as select from I_PostingKeyText
{
      @ObjectModel.text.element: ['PostingKeyName']
  key PostingKey,
      PostingKeyName

}
where
  Language = $session.system_language
