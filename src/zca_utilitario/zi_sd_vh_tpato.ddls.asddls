@EndUserText.label: 'Search Help: Tipo de Ato Concessório'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_SD_VH_TPATO 
  as select from dd07t as _Domain
{
      @ObjectModel.text.element: ['Descricao']
  key _Domain.domvalue_l as TPATO,
      _Domain.ddtext     as Descricao
}
where
      _Domain.domname    = 'J_1BNFE_TPATO'
  and _Domain.ddlanguage = $session.system_language
