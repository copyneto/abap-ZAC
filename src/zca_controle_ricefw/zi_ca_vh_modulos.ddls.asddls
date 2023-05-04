@EndUserText.label: 'Módulos SAP'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
@ObjectModel.usageType: {
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_CA_VH_MODULOS
  as select from    df14l as _Modulo
    left outer join df14t as _Texto on  _Texto.fctr_id  = _Modulo.fctr_id
                                    and _Texto.as4local = _Modulo.as4local
                                    and _Texto.langu    = $session.system_language
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      @ObjectModel.text.element: ['NomeModulo']
  key cast( _Modulo.ps_posid as abap.char(24) ) as IdModulo,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.9
      _Texto.name                               as NomeModulo
}
where
  _Modulo.as4local = 'A';
