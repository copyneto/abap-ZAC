@AbapCatalog.sqlViewName: 'ZICA_DIRFISCAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Help Search: Direito fiscal: IPI'
@Search.searchable: true
define view ZI_CA_VH_DIREITO_FISCAL_IPI
  as select from j_1batl2
  association to j_1batl2t as _Text on  _Text.taxlaw = $projection.Taxlaw
                                    and _Text.langu  = $session.system_language
{

      @ObjectModel.text.element: ['Text']
      @Search.ranking: #MEDIUM
      @Search.defaultSearchElement: true
  key taxlaw        as Taxlaw,
      @Search.defaultSearchElement: true
      _Text.descrip as Descrip
}
