@AbapCatalog.sqlViewName: 'ZVCA_MTORG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Utilização de material'
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.dataCategory: #TEXT
define view ZI_CA_VH_MTORG
  as select from dd07l as Base
    join         dd07t as Text on  Text.domname  = Base.domname
                               and Text.as4local = Base.as4local
                               and Text.valpos   = Base.valpos
                               and Text.as4vers  = Base.as4vers

  association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
{
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: ['Descricao']
  key cast ( substring( Base.domvalue_l, 1, 1 ) as j_1bmatorg preserving type ) as Mtorg,

      @Semantics.language: true
      @UI.hidden: true
  key cast( Text.ddlanguage as spras preserving type )                             as Language,
      
      substring ( Text.ddtext, 1, 60 )                                             as Descricao,

      // Association
      _Language
}
where
      Base.domname  = 'J_1BMATORG'
  and Base.as4local = 'A'
