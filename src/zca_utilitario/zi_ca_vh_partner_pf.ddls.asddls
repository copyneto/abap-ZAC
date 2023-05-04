@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Parceiro (Pessoa física)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_PARTNER_PF
  as select from    but000       as Pessoa
    left outer join dfkkbptaxnum as _CPF on  _CPF.partner = Pessoa.partner
                                         and _CPF.taxtype = 'BR2'
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
      case
        when length( Pessoa.name1_text ) < 1
         then concat_with_space( Pessoa.name_first, Pessoa.name_last, 1 )
        else Pessoa.name1_text
      end as Nome,
      @EndUserText.label: 'CPF'
      @UI.hidden: true
      _CPF.taxnum       as CPF,
      @EndUserText.label: 'CPF'
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      case when _CPF.taxnum is initial then ''
           else concat( substring(_CPF.taxnum, 1, 3),
                concat( '.',
                concat( substring(_CPF.taxnum, 4, 3),
                concat( '.',
                concat( substring(_CPF.taxnum, 7, 3),
                concat( '-', substring(_CPF.taxnum, 10, 2) ) ) ) ) ) )
           end          as CPFText
}
where
  _CPF.taxnum is not initial
