@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Documents'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZRH_Documents'
}
@AccessControl.authorizationCheck: #MANDATORY
@ObjectModel.semanticKey: [ 'DocumentID' ]
@Search.searchable: true
define root view entity ZRH_C_Documents
  provider contract transactional_query
  as projection on ZRH_R_Documents
  association [1..1] to ZRH_R_Documents as _BaseEntity on $projection.DocumentID = _BaseEntity.DocumentID
{
      @ObjectModel.text.element: [ 'Title' ]
      @UI.textArrangement: #TEXT_ONLY
  key DocumentID,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRH_I_DocumentTypeVH', element : 'DocumentType' } }]
      @UI.textArrangement: #TEXT_FIRST
      @ObjectModel.text.element: [ 'DocumentTypeDescription' ]
      DocumentType,
      _DocumentDescription.Description as DocumentTypeDescription,
      @Semantics.largeObject: {
        mimeType: 'Mimetype',
        fileName: 'Filename'
      }
      Document,
      @Semantics.mimeType: true
      Mimetype,
      Filename,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Title,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Description,
      @Semantics: {
        user.createdBy: true
      }
      LocalCreatedBy,
      @Semantics: {
        systemDateTime.createdAt: true
      }
      LocalCreatedAt,
      @Semantics: {
        user.localInstanceLastChangedBy: true
      }
      LocalLastChangedBy,
      @Semantics: {
        systemDateTime.localInstanceLastChangedAt: true
      }
      LocalLastChangedAt,
      @Semantics: {
        systemDateTime.lastChangedAt: true
      }
      LastChangedAt,
      _BaseEntity,
      _DocumentDescription,
      _Tags : redirected to composition child ZRH_C_DocumentTags
}
