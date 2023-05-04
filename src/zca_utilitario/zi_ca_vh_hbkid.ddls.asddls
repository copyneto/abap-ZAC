@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Banco Empresa'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_HBKID
  as select from t012        as BancoEmpresa
    inner join   V_T012t_Ddl as _Text on  BancoEmpresa.bukrs = _Text.bukrs
                                      and BancoEmpresa.hbkid = _Text.hbkid
                                      and _Text.spras        = $session.system_language

{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key BancoEmpresa.bukrs as Empresa,
      @ObjectModel.text.element: ['BancoEmpresaText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key BancoEmpresa.hbkid as BancoEmpresa,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.text1        as BancoEmpresaText
}
