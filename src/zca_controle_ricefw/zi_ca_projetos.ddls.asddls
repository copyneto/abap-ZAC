@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS View Projetos'
@ObjectModel.semanticKey: ['Cliente']
define root view entity ZI_CA_PROJETOS
  as select from ztca_projetos

  composition [0..*] of ZI_CA_RICEFWS     as _Ricefws

  association [0..1] to ZI_CA_VH_PROJETOS as _VHProjetos on _VHProjetos.Projeto = $projection.Projeto
  association [0..1] to I_CreatedByUser   as _CreatedBy  on _CreatedBy.UserName = $projection.CreatedBy
  association [0..1] to I_ChangedByUser   as _ChangedBy  on _ChangedBy.UserName = $projection.LastChangedBy

{
  key uuid_projeto               as UuidProjeto,
      cliente                    as Cliente,
      projeto                    as Projeto,
      descricao                  as Descricao,
      @Semantics.user.createdBy: true
      created_by                 as CreatedBy,
      _CreatedBy.UserDescription as NomeCriador,
      @Semantics.systemDateTime.createdAt: true
      created_at                 as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by            as LastChangedBy,
      _ChangedBy.UserDescription as NomeModificador,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at            as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at      as LocalLastChangedAt,  

      _Ricefws,
      _VHProjetos,
      _CreatedBy,
      _ChangedBy
      
}
