@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Tipo de parceiro da NF'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.dataCategory: #TEXT
@Search.searchable: true
define view entity ZI_CA_VH_PARTYP_LIST
  as select from I_BR_NFPartnerTypeText
{
      @ObjectModel.text.element: ['BR_NFPartnerTypeDesc']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key BR_NFPartnerType,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      BR_NFPartnerTypeDesc
}
where
  Language = $session.system_language
