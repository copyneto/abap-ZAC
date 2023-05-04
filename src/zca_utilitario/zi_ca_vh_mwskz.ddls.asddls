@AbapCatalog.sqlViewName: 'ZICA_MWSKZ'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Código Imposto'
@Search.searchable: true
define view ZI_CA_VH_MWSKZ
  as select from t007a as _IVA
    inner join   t007s as _IVAText on  _IVA.kalsm     = _IVAText.kalsm
                                   and _IVA.mwskz     = _IVAText.mwskz
                                   and _IVAText.spras = $session.system_language
{
      @UI.hidden: true
  key _IVA.kalsm,
      @ObjectModel.text.element: ['IVACodeName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key _IVA.mwskz     as IVACode,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _IVAText.text1 as IVACodeName
}
