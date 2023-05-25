@AbapCatalog.sqlViewName: 'ZVCA_VH_ICMSTAX'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: SD código do imposto'
define view ZI_CA_VH_ICMSTAX
  as select from dd07l as Objeto
    join         dd07t as Text on  Text.domname  = Objeto.domname
                               and Text.as4local = Objeto.as4local
                               and Text.valpos   = Objeto.valpos
                               and Text.as4vers  = Objeto.as4vers

  association [0..1] to I_Language as _Language on $projection.language = _Language.Language
{
      @ObjectModel.text.element: ['Text']
      //    @Search.defaultSearchElement: true
  key cast(case substring( Objeto.domvalue_l, 1, 1 )
    when 'A' then '41'
    when 'B' then '51'
    else Objeto.domvalue_l
  end as logbr_taxsit) as BR_ICMSTaxSituation,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      Text.ddtext      as Text
}
where
      Objeto.domname  = 'J_1BTAXSIT'
  and Objeto.as4local = 'A'
  and Text.ddlanguage = $session.system_language
