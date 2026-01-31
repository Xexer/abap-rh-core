@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help for Tags'
@Search.searchable: true
define view entity ZRH_I_TagsVH
  as select from ZRH_I_Tags
{
      @ObjectModel.text.element: [ 'Description' ]
      @UI.textArrangement: #TEXT_ONLY
      @Search.defaultSearchElement: true
  key TagId,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      Description
}
