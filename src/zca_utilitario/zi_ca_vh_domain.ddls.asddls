@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help para Domínios'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_CA_VH_DOMAIN  
  as select from dd07l as _Domain
    inner join   dd07t as _Text on  _Text.domname    = _Domain.domname
                                and _Text.as4local   = _Domain.as4local
                                and _Text.valpos     = _Domain.valpos
                                and _Text.as4vers    = _Domain.as4vers
                                and _Text.ddlanguage = $session.system_language
{

      @UI.hidden: true
  key _Domain.domname    as Dominio,
      @ObjectModel.text.element: ['Texto']
      @UI.textArrangement: #TEXT_LAST
  key _Domain.domvalue_l as Valor,
      _Text.ddtext       as Texto
}
where
  _Domain.as4local = 'A';
