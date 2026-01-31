@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Document Tags'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZRH_I_DocumentTags
  as select from zrh_doc_tag
  association to parent ZRH_R_Documents as _Document on _Document.DocumentID = $projection.DocumentId
  association of exact one to one ZRH_I_TagsVH as _Tags on _Tags.TagId = $projection.TagId
{
  key document_id as DocumentId,
  key tag_id      as TagId,
  _Document,
  _Tags
}
