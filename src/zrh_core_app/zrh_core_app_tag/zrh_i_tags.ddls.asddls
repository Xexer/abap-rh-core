@EndUserText.label: 'Tags'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZRH_I_Tags
  as select from ZRH_TAG
  association to parent ZRH_R_TagsS as _TagsAll on $projection.SingletonID = _TagsAll.SingletonID
{
  key TAG_ID as TagId,
  DESCRIPTION as Description,
  @Consumption.hidden: true
  1 as SingletonID,
  _TagsAll
}
