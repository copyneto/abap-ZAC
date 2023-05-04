@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Boolean'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_CA_VH_BOOLE
  as select from dd07l as Objeto
    join         dd07t as Text on  Text.domname  = Objeto.domname
                               and Text.as4local = Objeto.as4local
                               and Text.valpos   = Objeto.valpos
                               and Text.as4vers  = Objeto.as4vers

  association [0..1] to I_Language as _Language on $projection.Language = _Language.Language
{
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: ['ObjetoName']
  key cast ( substring( Objeto.domvalue_l, 1, 1 ) as ze_visao preserving type ) as ObjetoId,

      @Semantics.language: true
  key cast( Text.ddlanguage as spras preserving type )                          as Language,

      @UI.hidden: true
      //      substring ( Text.ddtext, 1, 60 )                                          as ObjetoName,
      case substring( Text.ddtext, 1, 60 )
      when 'Verdadeiro' then 'Sim'
      else 'Não'
      end                                                                       as ObjetoName,

      _Language
}
where
      Objeto.domname  = 'BOOLE'
  and Objeto.as4local = 'A'
  and Text.ddlanguage = $session.system_language
