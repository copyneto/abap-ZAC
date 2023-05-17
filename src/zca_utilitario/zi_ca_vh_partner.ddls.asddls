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
define view entity ZI_CA_VH_PARTNER
  as select from    but000       as Pessoa
    left outer join dfkkbptaxnum as _Cnpj   on  _Cnpj.partner = Pessoa.partner
                                            and _Cnpj.taxtype = 'BR1'
    left outer join dfkkbptaxnum as _Cpf    on  _Cpf.partner = Pessoa.partner
                                            and _Cpf.taxtype = 'BR2'
    left outer join dfkkbptaxnum as _Ie     on  _Ie.partner = Pessoa.partner
                                            and _Ie.taxtype = 'BR3'
    left outer join dfkkbptaxnum as _Im     on  _Im.partner = Pessoa.partner
                                            and _Im.taxtype = 'BR4'
    left outer join t001w        as _Centro on _Centro.kunnr = Pessoa.partner
{
      @EndUserText.label: 'Parceiro de negócios'
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key Pessoa.partner     as Parceiro,
      @EndUserText.label: 'Tipo do Parceiro'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      Pessoa.bpkind      as Bpkind,
      @EndUserText.label: 'Nome completo'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      case when Pessoa.name1_text is not initial
           then Pessoa.name1_text
           when Pessoa.name_first is not initial
           then concat_with_space(Pessoa.name_first, Pessoa.name_last, 1 )
           when Pessoa.name_org1 is not initial
           then Pessoa.name_org1
           else ''
      end                as Nome,
      @EndUserText.label: 'CNPJ'
      @UI.hidden: true
      _Cnpj.taxnum       as CNPJ,
      @EndUserText.label: 'CNPJ'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      case when _Cnpj.taxnum is initial then ''
           else concat( substring(_Cnpj.taxnum, 1, 2),
                concat( '.',
                concat( substring(_Cnpj.taxnum, 3, 3),
                concat( '.',
                concat( substring(_Cnpj.taxnum, 6, 3),
                concat( '/',
                concat( substring(_Cnpj.taxnum, 9, 4),
                concat( '-',  substring(_Cnpj.taxnum, 13, 2) ) ) ) ) ) ) ) )
      end                as CNPJText,
      @EndUserText.label: 'CPF'
      @UI.hidden: true
      _Cpf.taxnum        as CPF,
      @EndUserText.label: 'CPF'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      case when _Cpf.taxnum is initial then ''
           else concat( substring(_Cpf.taxnum, 1, 3),
                concat( '.',
                concat( substring(_Cpf.taxnum, 4, 3),
                concat( '.',
                concat( substring(_Cpf.taxnum, 7, 3),
                concat( '-', substring(_Cpf.taxnum, 10, 2) ) ) ) ) ) )
           end           as CPFText,
      @EndUserText.label: 'Inscrição Estadual'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Ie.taxnum         as InscricaoEstadual,
      @EndUserText.label: 'Inscrição Municipal'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Im.taxnum         as InscricaoMunicipal,
      @EndUserText.label: 'Centro'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Centro.werks      as Centro,
      @EndUserText.label: 'Local de negócio'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Centro.j_1bbranch as LocalNegocio
}
where
     _Cnpj.taxnum is not initial
  or _Cpf.taxnum  is not initial
  or _Ie.taxnum   is not initial
  or _Im.taxnum   is not initial
