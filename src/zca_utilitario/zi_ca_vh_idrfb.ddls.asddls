@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help - ID catálogo RFB'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZI_CA_VH_IDRFB
  as select from    ztmm_catalogorfb as Idrfb

    left outer join makt             as _TextMaterial on  _TextMaterial.matnr = Idrfb.material
                                                      and _TextMaterial.spras = $session.system_language

    left outer join t134t            as _TextTpMat    on  _TextTpMat.mtart = Idrfb.materialtype
                                                      and _TextTpMat.spras = $session.system_language

    left outer join lfa1             as _TextSupplier on  _TextSupplier.lifnr = Idrfb.supplier
                                                      and _TextSupplier.spras = $session.system_language
{
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key Idrfb.idrfb         as Idrfb,

      @ObjectModel.text.element: ['TextMaterial']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Idrfb.material      as Material,

      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _TextMaterial.maktx as TextMaterial,

      @ObjectModel.text.element: ['TextTpMat']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Idrfb.materialtype  as Materialtype,

      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _TextTpMat.mtbez    as TextTpMat,

      @ObjectModel.text.element: ['TextSupplier']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      Idrfb.supplier      as Supplier,

      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _TextSupplier.name1 as TextSupplier
}
where
      Idrfb.status   = 'A'
  and Idrfb.datefrom <= $session.system_date
  and Idrfb.dateto   >= $session.system_date
