@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help - Status documento(UKM_DCD_DOC_STATUS)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_CA_VH_DOC_STATUS  
  as select from dd07l as Objeto
    join         dd07t as Text on  Text.domname    = Objeto.domname
                               and Text.as4local   = Objeto.as4local
                               and Text.valpos     = Objeto.valpos
                               and Text.as4vers    = Objeto.as4vers
                               and Text.ddlanguage = $session.system_language

  //  association [0..1] to I_Language as _Language on $projection.language = _Language.Language
{
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: ['ObjetoName']
  key cast ( substring( Objeto.domvalue_l, 1, 1 ) as ze_visao preserving type ) as ObjetoId,

      //      @Semantics.language: true
      //  key cast( Text.ddlanguage as spras preserving type )                         as Language,

      @UI.hidden: true
      substring ( Text.ddtext, 1, 60 )                                          as ObjetoName

      //      _Language
}
where
      Objeto.domname  = 'UKM_DCD_DOC_STATUS'
  and Objeto.as4local = 'A'
