@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RH: Contact (Consumption)'
@Metadata.allowExtensions: true
define root view entity ZRH_C_ContactTP
  provider contract transactional_query
  as projection on ZRH_R_ContactTP
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
