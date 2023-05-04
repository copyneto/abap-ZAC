@EndUserText.label: 'Projetos'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['Cliente']
define root view entity ZC_CA_PROJETOS
  as projection on ZI_CA_PROJETOS as Projetos
{
  key     UuidProjeto,

          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_PROJETOS', element: 'Cliente' },
                                               additionalBinding: [{  element: 'Projeto', localElement: 'Projeto' }]}]
          @EndUserText.label: 'Cliente'
          Cliente,

          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZI_CA_VH_PROJETOS', element: 'Projeto' },
                                               additionalBinding: [{  element: 'Cliente', localElement: 'Cliente' }]}]
          @EndUserText.label: 'Projeto'
          Projeto,

          @EndUserText.label: 'Descrição'
          @UI.multiLineText: true
          Descricao,

          @EndUserText.label: 'Criado Por'
          @ObjectModel.text.element: ['NomeCriador']
          CreatedBy,
          NomeCriador,

          @EndUserText.label: 'Criado Em'
          CreatedAt,

          @EndUserText.label: 'Modificado Por'
          @ObjectModel.text.element: ['NomeModificador']
          LastChangedBy,
          NomeModificador,

          @EndUserText.label: 'Modificado Em'
          LastChangedAt,

          @EndUserText.label: 'Última Modif.'
          LocalLastChangedAt,

          /* Associations */
          _Ricefws : redirected to composition child ZC_CA_RICEFWS,
          _VHProjetos,
          _CreatedBy,
          _ChangedBy
}
