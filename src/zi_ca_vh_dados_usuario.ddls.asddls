@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help Dados Usuário'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//@Search.searchable: true
define view entity ZI_CA_VH_DADOS_USUARIO
  as select from I_UserContactCard
  {
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  key ContactCardID,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  FirstName,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  LastName,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  FullName,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  EmailAddress,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  Department,
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.8
  FunctionalTitleName
}
