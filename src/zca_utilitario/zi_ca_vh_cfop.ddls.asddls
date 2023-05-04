@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help CFOP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_CFOP
  as select from ZI_CA_CFOP as J_1bagn
  
   inner join   j_1bagnt as _Text on  _Text.cfop   =  J_1bagn.Cfop
                                  and _Text.version = J_1bagn.Version
                                  and _Text.cfotxt <> ''
                                  and _Text.spras  = $session.system_language
{
      @ObjectModel.virtualElement: true
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCLCA_CDS_CFOP'
      @EndUserText.label: 'CFOP'
  key J_1bagn.Cfop        as Cfop,      
      @EndUserText.label: 'CFOP Interno'
      //      @UI.hidden: true
      J_1bagn.Cfop        as Cfop1,  
       @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7    
      _Text.cfotxt as Text
}
