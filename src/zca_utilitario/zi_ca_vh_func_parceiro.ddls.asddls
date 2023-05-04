//@AbapCatalog.sqlViewName: 'ZICA_FUNC_PARCEI'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Search Help: Função Parceiro'
//@Search.searchable: true
//define view ZI_CA_VH_FUNC_PARCEIRO
//  as select from tpar as _FuncParc
//  association to tpart as _TextParc on  _TextParc.parvw = $projection.Parvw
//                                    and _TextParc.spras = $session.system_language
//{
//      @ObjectModel.text.element: ['Text']
//      @Search.ranking: #MEDIUM
//      @Search.defaultSearchElement: true
//      //key cast( _FuncParc.parvw as abap.char( 2 ) ) as Parvw,
//      key parvw as Parvw,
//      @Search.defaultSearchElement: true
//      _TextParc.vtext as Text
//
//
//}
//where
//    _TextParc.vtext != ''
////group by tpart.parvw

@AbapCatalog.sqlViewName: 'ZICA_FUNC_PARCEI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
//@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.dataCategory: #TEXT
define view ZI_CA_VH_FUNC_PARCEIRO
  as select from tpar as _FuncParc
    join         tpart as _TextParc on  _TextParc.parvw = _FuncParc.parvw
                                    and _TextParc.spras = $session.system_language

  //association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
{
//      @UI.textArrangement: #TEXT_ONLY
//      @ObjectModel.text.element: ['Descricao']
//  key cast ( substring( Status.domvalue_l, 1, 1 ) as ze_operacao preserving type ) as Operacao,
//
//      @Semantics.language: true
//      @UI.hidden: true
//  key cast( Text.ddlanguage as spras preserving type )                             as Language,
//
//      @UI.hidden: true
//      substring ( Text.ddtext, 1, 60 )                                             as Descricao,
//
//      // Association
//      _Language
      
      key _FuncParc.parvw as Parvw,
      @Search.defaultSearchElement: true
      _TextParc.vtext as Text
}
//where
//      Status.domname  = 'ZD_OPERACAO'
//  and Status.as4local = 'A'
