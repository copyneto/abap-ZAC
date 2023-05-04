@AbapCatalog.sqlViewName: 'ZVCA_STGRD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help Motivo de Estorno'
//@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.dataCategory: #TEXT
define view ZI_CA_STGRD
  as select from    t041c  as _Base
    left outer join t041ct as _Text on _Base.stgrd = _Text.stgrd

  association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
{
      @UI.textArrangement:#TEXT_LAST
      @ObjectModel.text.element: ['Descricao']
  key _Base.stgrd as MotEstorno,
      @Semantics.language: true
      @UI.hidden: true
  key _Text.spras as Language,
      _Text.txt40 as Descricao,

      // Association
      _Language

}
where
  _Text.spras = $session.system_language
