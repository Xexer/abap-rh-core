@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RH: Value help for Contact'
define view entity ZRH_I_ContactVH
  as select from ZRH_B_Contact
{
  key ContactId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRH_I_ContactTypeVH', element : 'ContactTypeInt' } }]
      ContactTypeInt,
      concat_with_space(FirstName, LastName, 1) as FullName,
      Town,
      Country
}
