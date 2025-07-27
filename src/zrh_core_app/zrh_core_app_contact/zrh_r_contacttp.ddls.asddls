@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RH: Contact'
define root view entity ZRH_R_ContactTP
  as select from ZRH_B_Contact
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
      LastChanged
}
