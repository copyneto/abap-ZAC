@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Parceiro (Organização)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true

define view entity ZI_CA_VH_PARTNER_ORG
  as select from    but000       as Pessoa
    left outer join dfkkbptaxnum as _CNPJ on  _CNPJ.partner = Pessoa.partner
                                          and _CNPJ.taxtype = 'BR1'
{
      @EndUserText.label: 'Parceiro de negócios'
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key Pessoa.partner    as Parceiro,
      @EndUserText.label: 'Nome completo'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      Pessoa.name1_text as Nome,
      @EndUserText.label: 'CNPJ'
      @UI.hidden: true
      _CNPJ.taxnum      as CNPJ,
      @EndUserText.label: 'CNPJ'
      case when _CNPJ.taxnum is initial then ''
           else concat( substring(_CNPJ.taxnum, 1, 2),
                concat( '.',
                concat( substring(_CNPJ.taxnum, 3, 3),
                concat( '.',
                concat( substring(_CNPJ.taxnum, 6, 3),
                concat( '/',
                concat( substring(_CNPJ.taxnum, 9, 4),
                concat( '-',  substring(_CNPJ.taxnum, 13, 2) ) ) ) ) ) ) ) )
      end               as CNPJText,
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.hidden: true
      _CNPJ.taxnum      as CNPJSearch

}
where
  Pessoa.type = '2'
