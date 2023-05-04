@AbapCatalog.sqlViewName: 'ZICA_DOM_FISCAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Help Search: Domicílio fiscal'
@Search.searchable: true
define view ZI_CA_VH_DOMICILIO_FISCAL
  as select from    j_1btxjur      as _Tax
    left outer join j_1btxjurt     as _Text   on  _Text.taxjurcode = _Tax.taxjurcode
                                              and _Text.country    = _Tax.country
                                              and _Text.spras      = $session.system_language
    left outer join ZI_CA_VH_REGIO as _Region on  _Region.Country = _Tax.country
                                              and _Region.Region  = substring( _Tax.taxjurcode, 1, 2 )
{
       @EndUserText.label: 'País'
       @ObjectModel.text.element: ['Text']
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
  key  _Tax.country                                       as Country,
       @EndUserText.label: 'Domicílio Fiscal'
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
  key  _Tax.taxjurcode                                    as Txjcd,
       @EndUserText.label: 'Domicílio Fiscal'
       @Search.ranking: #MEDIUM
       @Search.defaultSearchElement: true
       _Text.text                                         as Text,
       @EndUserText.label: 'Região'
       cast( left( _Tax.taxjurcode, 2) as regio ) as Region,
       @EndUserText.label: 'Região'
       @Search.defaultSearchElement: true
       @Search.ranking: #MEDIUM
       _Region.RegionName                                 as RegionName
}
where
  _Tax.country = 'BR'
