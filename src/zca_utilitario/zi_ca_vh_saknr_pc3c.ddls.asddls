@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Search Help: Plano de contas (PC3C)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_SAKNR_PC3C
  as select from    ska1 as Account
    left outer join skat as _Text on  _Text.spras = $session.system_language
                                  and _Text.ktopl = Account.ktopl
                                  and _Text.saknr = Account.saknr
{
  key Account.saknr as GLAccount,
      _Text.txt50   as GLAccountLongName
}

where
  Account.ktopl = 'PC3C'
