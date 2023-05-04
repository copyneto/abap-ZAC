@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help Direção Nota Fiscal'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.dataCategory: #TEXT
@Search.searchable: true
define view entity ZI_CA_VH_DIRECAO_NF
  as select from I_BR_NFDirectionText
{

      @ObjectModel.text.element: ['BR_NFDirectionDesc']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key BR_NFDirection,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      BR_NFDirectionDesc
}
where
  Language = $session.system_language
