@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CPF/CNPJ Parceiro de Negócio'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_CPF_CNPJ
  as select from dfkkbptaxnum as _CpfCnpj
  //    left outer join dfkkbptaxnum as _CPF on  _CPF.partner = _CNPJ.partner
  //                                         and _CPF.taxtype = 'BR2'
  association [1..1] to but000 as _Partner on _Partner.partner = $projection.Partner
{

      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key _CpfCnpj.taxnum   as CpfCnpj,
      _CpfCnpj.partner  as Partner,
      _Partner.mc_name1 as Nome,
      @EndUserText.label: 'Tipo BP'
      case
        when _CpfCnpj.taxtype = 'BR1'
        then 'PJ'
        else 'PF'
      end               as TipoBP

}
where
     _CpfCnpj.taxtype = 'BR1'
  or _CpfCnpj.taxtype = 'BR2'
