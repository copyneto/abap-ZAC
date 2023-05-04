@AbapCatalog.sqlViewName: 'ZCBRTAXLAW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Direitos fiscais'
define view ZI_CA_TAXLAW
  as select distinct from j_1batl4t
//    inner join   I_BR_NFItem on j_1batl4t.taxlaw = I_BR_NFItem.BR_COFINSTaxLaw
{
//  key I_BR_NFItem.BR_NotaFiscal,
  key cast('COFI' as  j_1btaxgrp )                    as Taxgroup,
  key langu                                           as Langu,
  key taxlaw                                          as Taxlaw,
      descrip                                         as Descrip,
      concat_with_space(line1,
        concat_with_space(line2,
          concat_with_space(line3, line4, 1), 1), 1 ) as Taxtext
      //      line1                        as Line1,
      //      line2                        as Line2,
      //      line3                        as Line3,
      //      line4                        as Line4
}
where
  langu = $session.system_language
union select distinct from j_1batl5t
//  inner join      I_BR_NFItem on j_1batl5t.taxlaw = I_BR_NFItem.BR_PISTaxLaw
{
//  key I_BR_NFItem.BR_NotaFiscal,
  key cast('PIS' as  j_1btaxgrp )                     as Taxgroup,
  key langu                                           as Langu,
  key taxlaw                                          as Taxlaw,
      descrip                                         as Descrip,
      concat_with_space(line1,
        concat_with_space(line2,
          concat_with_space(line3, line4, 1), 1), 1 ) as Taxtext
}
where
  langu = $session.system_language
union select distinct from j_1batl1t
//  inner join      I_BR_NFItem on j_1batl1t.taxlaw = I_BR_NFItem.BR_ICMSTaxLaw
{
//  key I_BR_NFItem.BR_NotaFiscal,
  key cast('ICMS' as  j_1btaxgrp )                    as Taxgroup,
  key langu                                           as Langu,
  key taxlaw                                          as Taxlaw,
      descrip                                         as Descrip,
      concat_with_space(line1,
        concat_with_space(line2,
          concat_with_space(line3, line4, 1), 1), 1 ) as Taxtext
}
where
  langu = $session.system_language
union select distinct from j_1batl2t
//  inner join      I_BR_NFItem on j_1batl2t.taxlaw = I_BR_NFItem.BR_IPITaxLaw
{
//  key I_BR_NFItem.BR_NotaFiscal,
  key cast('IPI' as  j_1btaxgrp )                     as Taxgroup,
  key langu                                           as Langu,
  key taxlaw                                          as Taxlaw,
      descrip                                         as Descrip,
      concat_with_space(line1,
        concat_with_space(line2,
          concat_with_space(line3, line4, 1), 1), 1 ) as Taxtext
}
where
  langu = $session.system_language
