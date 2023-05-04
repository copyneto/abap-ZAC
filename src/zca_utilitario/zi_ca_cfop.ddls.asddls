@EndUserText.label: 'Busca dos valores do CFOP'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define root view entity ZI_CA_CFOP
  as select from j_1bagn  as J_1bagn
    join         j_1bagnt as _Text on  _Text.cfop    = j_1bagn.cfop
                                   and _Text.version = j_1bagn.version
                                   and _Text.cfotxt  <> ''
                                   and _Text.spras   = $session.system_language
{

      @Search.defaultSearchElement: true
  key cast( j_1bagn.cfop as abap.char( 10 ) ) as Cfop,
      max(j_1bagn.version)                    as Version
}
group by
  j_1bagn.cfop
