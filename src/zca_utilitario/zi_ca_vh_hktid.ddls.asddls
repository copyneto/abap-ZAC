@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help ID conta'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CA_VH_HKTID
  as select from t012k
    inner join   t012t on  t012t.spras = $session.system_language
                       and t012t.bukrs = t012k.bukrs
                       and t012t.hbkid = t012k.hbkid
                       and t012t.hktid = t012k.hktid
{
  key t012k.bukrs as Bukrs,
  key t012k.hbkid as Hbkid,
  key t012k.hktid as Hktid,
      t012t.text1 as Text1
      
}
