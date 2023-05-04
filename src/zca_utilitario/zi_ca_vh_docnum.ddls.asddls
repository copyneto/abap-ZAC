@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Notas Fiscais'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_DOCNUM
  as select from    I_BR_NFDocument
{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key BR_NotaFiscal,
      BR_NFPartnerFunction,
      BR_NFPartner,
      BR_NFPartnerName1,
      BR_NFPartnerType,
      BR_NFPartnerCityName,
      BR_NFPartnerRegionCode,
      BR_NFPartnerDistrictName,
      BR_NFPartnerCountryCode,
      BR_NFPartnerPostalCode,
      BR_NFPartnerIsNaturalPerson,
      BR_NFPartnerCNPJ,
      BR_NFPartnerCPF,
      BR_NFDirection,
      BR_NFType,
      BR_NFDocumentType,
      BR_NFModel,
      BR_NFNumber,
      BR_NFSeries,
      BR_NFeNumber
      
}
