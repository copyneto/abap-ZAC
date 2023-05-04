@AbapCatalog.sqlViewName: 'ZICA_EKGRP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Centro'
@Search.searchable: true
@ObjectModel.resultSet.sizeCategory: #XS
define view ZI_CA_VH_EKGRP
  as select from t024 as _CompGroup
{
      @ObjectModel.text.element: ['CompGroupCodeName']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key _CompGroup.ekgrp as CompGroupCode,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _CompGroup.eknam as CompGroupCodeName
}
