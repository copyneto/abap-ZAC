@EndUserText.label: 'Search Help Insumos'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_CA_VH_CFOP_INS
  as select from ZI_CA_VH_CFOP as J_1bagn

    inner join   j_1bagnt      as _Text on  _Text.cfop    =  J_1bagn.Cfop
                                        and _Text.version =  '04'
                                        and _Text.cfotxt  <> ''
                                        and _Text.spras   = $session.system_language
{
       @EndUserText.label: 'CFOP Interno'
  key  LEFT(J_1bagn.Cfop, 4) as Cfop1,
       @EndUserText.label: 'CFOP'
  key  J_1bagn.Cfop          as Cfop,
       _Text.cfotxt          as Text

}
