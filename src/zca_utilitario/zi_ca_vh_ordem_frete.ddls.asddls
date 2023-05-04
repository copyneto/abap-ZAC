@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Ordem de Frete'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true

define view entity ZI_CA_VH_ORDEM_FRETE
  as select from I_TransportationOrder
{
      @Search.ranking: #HIGH
      @Search.defaultSearchElement: true
  key TransportationOrder,
      @ObjectModel.text.element: ['TransportationOrderCatDesc']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      TransportationOrderCategory,
      _TransportationOrderCategory._Text[ 1:Language = $session.system_language ].TransportationOrderCatDesc,
      @ObjectModel.text.element: ['TransportationOrderTypeDesc']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      TransportationOrderType,
      _TransportationOrderType._Text[ 1:Language = $session.system_language ].TransportationOrderTypeDesc,
      @ObjectModel.text.element: ['TranspOrdLifeCycleStatusDesc']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      TranspOrdLifeCycleStatus,
      _TranspOrdLifeCycleStatus._Text[ 1:Language = $session.system_language ].TranspOrdLifeCycleStatusDesc,
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      CreatedByUser,
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      CreationDateTime
      
        
}
where
      TransportationOrderCategory = 'TO'
  and TransportationOrder         is not initial
