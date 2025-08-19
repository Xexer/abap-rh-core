@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RH: Contact'
define root view entity ZRH_R_ContactTP
  as select from ZRH_B_Contact
  association of one to one ZRH_I_ContactTypeVH as _ContactTypeInternal on _ContactTypeInternal.ContactTypeInt = $projection.ContactTypeInt
  association of one to one ZRH_I_ContactVH     as _ContactInfo         on _ContactInfo.ContactId = $projection.ContactId
  association of one to one I_CountryVH         as _Country             on _Country.Country = $projection.Country
  association of one to one ZRH_I_UserVH        as _UserCreated         on _UserCreated.UserID = $projection.LocalCreatedBy
  association of one to one ZRH_I_UserVH        as _UserChanged         on _UserChanged.UserID = $projection.LocalLastChangedBy
{
  key ContactId,
      ContactTypeInt,
      FirstName,
      LastName,
      Birthday,
      Street,
      HouseNumber,
      Town,
      ZipCode,
      Country,
      Telephone,
      Email,
      LocalCreatedBy,
      LocalLastChangedBy,
      LocalLastChanged,
      LastChanged,
      _ContactTypeInternal,
      _ContactInfo,
      _Country,
      _UserCreated,
      _UserChanged
}
