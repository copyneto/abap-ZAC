@AbapCatalog.sqlViewName: 'ZVCA_BWART'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help Movimento de Mercadorias'
@ObjectModel.dataCategory: #TEXT
define view ZI_CA_VH_BWART 
  as select from I_GoodsMovementType as Base
  association [0..1] to I_GoodsMovementTypeT as _Text on  $projection.GoodsMovementType = _Text.GoodsMovementType
                                                      and _Text.Language                = $session.system_language
{

      @ObjectModel.text.element: ['Description']
  key GoodsMovementType,
      @Semantics.language: true
      @UI.hidden: true
  key _Text.Language              as Language,
      @Semantics.text: true
      _Text.GoodsMovementTypeName as Description

}
