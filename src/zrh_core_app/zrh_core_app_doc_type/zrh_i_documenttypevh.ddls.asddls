@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for Document Type'
@Search.searchable: true
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZRH_I_DocumentTypeVH
  as select from ZRH_I_DocumentType
{
      @ObjectModel.text.element: [ 'Description' ]
      @UI.textArrangement: #TEXT_FIRST
      @Search.defaultSearchElement: true
  key DocumentType,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Description,
      Process
}
