@EndUserText.label: 'Help Search - Tipo NF'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.dataCategory: #TEXT
@Search.searchable: true
define view entity ZI_CA_TP_DOC_NF
  as select from I_BR_NFIsCreatedManuallyText
{
      @ObjectModel.text.element: ['BR_NFIsCreatedManuallyDesc']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key BR_NFIsCreatedManually,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      BR_NFIsCreatedManuallyDesc
}
where
  Language = $session.system_language
