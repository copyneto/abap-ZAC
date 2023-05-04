@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search - Setor de Atividade'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.dataCategory: #TEXT
@Search.searchable: true
define view entity ZI_CA_SETOR_ATIV_LIST
  as select from tspa

  association [0..*] to I_DivisionText as _Text on $projection.Division = _Text.Division
{
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @ObjectModel.text.association: '_Text'
  key spart as Division,

      _Text
};
