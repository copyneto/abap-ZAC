@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Doc. adm. liquidação'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_WBELN
  as select from wbrk

  association [0..1] to ZI_CA_VH_WDTYP as _wdtyp on _wdtyp.wdtyp = $projection.wdtyp
  association [0..1] to ZI_CA_VH_EKORG as _ekorg on _ekorg.PurchasingOrganization = $projection.ekorg
  association [0..1] to ZI_CA_VH_VKORG as _vkorg on _vkorg.OrgVendas = $projection.vkorg
  association [0..1] to ZI_CA_VH_BUKRS as _bukrs on _bukrs.Empresa = $projection.bukrs
{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key wbeln                             as wbeln,
      @ObjectModel.text.element: ['wdtyp_txt']
      wdtyp                             as wdtyp,
      _wdtyp.wdtyp_txt                  as wdtyp_txt,
      @ObjectModel.text.element: ['ekorg_txt']
      ekorg                             as ekorg,
      _ekorg.PurchasingOrganizationText as ekorg_txt,
      @ObjectModel.text.element: ['vkorg_txt']
      vkorg                             as vkorg,
      _vkorg.OrgVendasText              as vkorg_txt,
      @ObjectModel.text.element: ['bukrs_txt']
      bukrs                             as bukrs,
      _bukrs.EmpresaText                as bukrs_txt
}
