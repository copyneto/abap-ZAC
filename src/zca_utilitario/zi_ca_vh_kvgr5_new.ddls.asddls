@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Agendamento'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_KVGR5_NEW
  as select from tvv5  as AdditionalCustomerGroup5
    inner join   tvv5t as _Text on  _Text.spras = $session.system_language
                                and _Text.kvgr5 = AdditionalCustomerGroup5.kvgr5
{
      @ObjectModel.text.element: ['AdditionalCustomerGroup5Name']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key AdditionalCustomerGroup5.kvgr5 as AdditionalCustomerGroup5,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.bezei                    as AdditionalCustomerGroup5Name
}
