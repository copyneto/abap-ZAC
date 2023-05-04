@AbapCatalog.sqlViewName: 'ZVCA_VH_TXCOD_MM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help search MM : Código de impostos'
define view zi_ca_vh_taxcode_mm
  as select from t007s
{
      @UI.hidden: true
  key spras as Spras,
      @UI.hidden: true
  key kalsm as Kalsm,
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
  key mwskz as Mwskz,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      text1 as Text
}
where
      spras = $session.system_language
  and kalsm = 'TAXBRA'
