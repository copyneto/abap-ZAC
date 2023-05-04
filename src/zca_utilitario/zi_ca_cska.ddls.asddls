@AbapCatalog.sqlViewName: 'ZICA_CSKA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Classe de custo'
@Search.searchable: true
define view ZI_CA_CSKA
  as select from cska as ClCustos
  association to csku as _Text on  _Text.ktopl = ClCustos.ktopl
                               and _Text.kstar = ClCustos.kstar
                               and _Text.spras = $session.system_language
{

      @Search.defaultSearchElement: true
  key ktopl       as Ktopl,
      @Search.defaultSearchElement: true
  key kstar       as Kstar,
      ersda       as Ersda,
      usnam       as Usnam,
      stekz       as Stekz,
      zahkz       as Zahkz,
      kstsn       as Kstsn,
      func_area   as FuncArea,
      _Text.ktext as Text

}
