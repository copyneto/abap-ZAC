@AbapCatalog.sqlViewName: 'ZICA_USER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Usuário'
@Search.searchable: true
define view ZI_CA_VH_USER as select from usr21  as User
inner join adrp as _Text on  _Text.persnumber = User.persnumber
{
      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
    key bname as Bname,
      @Semantics.text: true
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @Search.fuzzinessThreshold: 0.7    
    _Text.name_text as Text
       
}
