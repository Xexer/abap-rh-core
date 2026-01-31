@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZRH_Documents'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZRH_R_Documents
  as select from zrh_doc
  composition of exact one to many ZRH_I_DocumentTags as _Tags
  association of exact one to one ZRH_I_DocumentTypeVH as _DocumentDescription on _DocumentDescription.DocumentType = $projection.DocumentType
{
  key document_id           as DocumentID,
      document_type         as DocumentType,
      document              as Document,
      mimetype              as Mimetype,
      filename              as Filename,
      title                 as Title,
      description           as Description,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      _Tags,
      _DocumentDescription
}
