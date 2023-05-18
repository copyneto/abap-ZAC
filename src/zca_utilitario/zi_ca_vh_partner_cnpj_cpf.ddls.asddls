@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Parceiro'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_PARTNER_CNPJ_CPF
  as select from    but000       as Pessoa
    left outer join dfkkbptaxnum as _Cnpj on  _Cnpj.partner = Pessoa.partner
                                          and _Cnpj.taxtype = 'BR1'
    left outer join dfkkbptaxnum as _Cpf  on  _Cpf.partner = Pessoa.partner
                                          and _Cpf.taxtype = 'BR2'
    left outer join dfkkbptaxnum as _Ie   on  _Ie.partner = Pessoa.partner
                                          and _Ie.taxtype = 'BR3'
    left outer join dfkkbptaxnum as _Im   on  _Im.partner = Pessoa.partner
                                          and _Im.taxtype = 'BR4'
{
      @EndUserText.label: 'CNPJ/CPF'
  key case when _Cnpj.taxnum is not null
           then _Cnpj.taxnum
           when _Cpf.taxnum is not initial
           then _Cpf.taxnum
           else ''
           end          as cnpj_cpf,

      @UI.hidden: true
      @EndUserText.label: 'CNPJ/CPF'
      case when _Cnpj.taxnum is not null
           then concat( substring(_Cnpj.taxnum, 1, 2),
                concat( '.',
                concat( substring(_Cnpj.taxnum, 3, 3),
                concat( '.',
                concat( substring(_Cnpj.taxnum, 6, 3),
                concat( '/',
                concat( substring(_Cnpj.taxnum, 9, 4),
                concat( '-',  substring(_Cnpj.taxnum, 13, 2) ) ) ) ) ) ) ) )
           when _Cpf.taxnum is not initial
           then concat( substring(_Cpf.taxnum, 1, 3),
                concat( '.',
                concat( substring(_Cpf.taxnum, 4, 3),
                concat( '.',
                concat( substring(_Cpf.taxnum, 7, 3),
                concat( '-', substring(_Cpf.taxnum, 10, 2) ) ) ) ) ) )
           else ''
           end          as cnpj_cpf_txt,

      @EndUserText.label: 'Parceiro de negócios'
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Pessoa.partner    as Parceiro,
      @EndUserText.label: 'Tipo do Parceiro'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      Pessoa.bpkind     as Bpkind,
      @EndUserText.label: 'Nome completo'
      case when Pessoa.name1_text is not initial
           then Pessoa.name1_text
           when Pessoa.name_first is not initial
           then concat_with_space(Pessoa.name_first, Pessoa.name_last, 1 )
           when Pessoa.name_org1 is not initial
           then Pessoa.name_org1
           else ''
      end               as Nome,
      @EndUserText.label: 'Inscrição Estadual'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Ie.taxnum        as InscricaoEstadual,
      @EndUserText.label: 'Inscrição Municipal'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Im.taxnum        as InscricaoMunicipal,

      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.hidden: true
      _Cnpj.taxnum      as cnpj_search,
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @UI.hidden: true
      _Cpf.taxnum       as cpf_search,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      @UI.hidden: true
      Pessoa.name1_text as name_search,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      @UI.hidden: true
      Pessoa.name_first as name_first_search,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      @UI.hidden: true
      Pessoa.name_last  as name_last_search,
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      @UI.hidden: true
      Pessoa.name_org1  as name_org_search

}
where
     _Cnpj.taxnum is not initial
  or _Cpf.taxnum  is not initial
