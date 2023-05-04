@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Cód.Situação NF'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_NFCODSIT
  as select from dd07l as Domain
  association to dd07t as _Text on  $projection.Domname  = _Text.domname
                                and $projection.As4local = _Text.as4local
                                and $projection.Valpos   = _Text.valpos
                                and $projection.As4vers  = _Text.as4vers
                                and _Text.ddlanguage     = $session.system_language
{

      @UI.hidden: true
  key domname      as Domname,
      @UI.hidden: true
  key as4local     as As4local,
      @UI.hidden: true
  key valpos       as Valpos,
      @UI.hidden: true
  key as4vers      as As4vers,

      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      domvalue_l   as NFCodSit,

      _Text.ddtext as Text,

      @UI.hidden: true
      domvalue_h   as DomvalueH,
      @UI.hidden: true
      appval       as Appval

}
where
      Domain.domname  = 'J_1B_STATUS_FISC_DOC'
  and Domain.as4local = 'A';
