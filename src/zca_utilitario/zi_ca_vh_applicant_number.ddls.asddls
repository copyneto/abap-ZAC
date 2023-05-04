@AbapCatalog.sqlViewName: 'ZICA_APPL_NUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Nº Solicitante'
@Search.searchable: true
@ObjectModel.resultSet.sizeCategory: #XS
define view ZI_CA_VH_APPLICANT_NUMBER 
  as select from tcj05 as Applicant
{
      @ObjectModel.text.element: ['ApplicantText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key astnr       as ApplicantNumber,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      astna       as ApplicantText
}
