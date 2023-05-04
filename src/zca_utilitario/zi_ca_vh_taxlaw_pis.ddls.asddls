@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Imposto PIS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_TAXLAW_PIS
  as select from    j_1batl5       as Tax
    left outer join j_1batl5t      as _Text     on  _Text.langu  = $session.system_language
                                                and _Text.taxlaw = Tax.taxlaw
    left outer join j_1btaxsitpis  as _Trib     on _Trib.taxsit = Tax.taxsit
    left outer join j_1btaxsitpist as _TribText on  _TribText.langu  = $session.system_language
                                                and _TribText.taxsit = _Trib.taxsit
{
  key Tax.taxlaw    as Taxlaw,
      _Text.descrip as Descrip,
      Tax.taxsit    as Taxsit,
      _TribText.txt as DescripTaxsit,
      Tax.taxsitout as Taxsitout,
      _Text.line1   as Line1,
      _Text.line2   as Line2,
      _Text.line3   as Line3,
      _Text.line4   as Line4
}
