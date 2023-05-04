@AbapCatalog.sqlViewName: 'ZICA_ZTERM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Cond. Pgto.'
@Search.searchable: true
define view ZI_CA_VH_ZTERM
  as select from t052  as _CndPgto
    inner join   t052u as _CndPgtoText on  _CndPgto.zterm     = _CndPgtoText.zterm
                                       and _CndPgtoText.spras = $session.system_language
{
      @ObjectModel.text.element: ['CndPgtoCodeName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key _CndPgto.zterm     as CndPgtoCode,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _CndPgtoText.text1 as CndPgtoCodeName
}
