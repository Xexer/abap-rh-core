@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Document Tags'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZRH_C_DocumentTags
  as projection on ZRH_I_DocumentTags
{
  key DocumentId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRH_I_TagsVH', element : 'TagId' } }]
      @UI.textArrangement: #TEXT_ONLY
      @ObjectModel.text.element: [ 'Description' ]
  key TagId,
      _Tags.Description,
      _Document : redirected to parent ZRH_C_Documents,
      _Tags
}
