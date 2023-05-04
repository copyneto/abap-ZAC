@AbapCatalog.sqlViewName: 'ZICA_PROJ_PROF' 
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Perfil do projeto'
@Search.searchable: true
//@ObjectModel.resultSet.sizeCategory: #XS
define view ZI_CA_VH_PROJECT_PROFILE

  as select from tcj41 as Project
  association to tcj4t as _Text on  _Text.spras      = $session.system_language
                                and _Text.profidproj = $projection.ProfileId
{
      @ObjectModel.text.element: ['ProfileText']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
  key profidproj      as ProfileId,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7
      _Text.profi_txt as ProfileText
}
