@EndUserText.label: 'Document Type'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZRH_I_DocumentType
  as select from zrh_doc_type
  association to parent ZRH_I_DocumentTypeS as _DocumentTypeAll on $projection.SingletonID = _DocumentTypeAll.SingletonID
{
  key document_type as DocumentType,
      description   as Description,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRH_I_PROCESSVH', element : 'Process' } }]
      process       as Process,
      @Consumption.hidden: true
      1             as SingletonID,
      _DocumentTypeAll
}
