@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RH: Value help for Contact'
define view entity ZRH_I_ContactVH
  as select from ZRH_B_Contact
{
  key ContactId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRH_I_ContactTypeVH', element : 'ContactTypeInt' } }]
      ContactTypeInt,
      case ContactTypeInt
        when 'AD' then concat_with_space( concat( Street, ',' ), Town, 1)
        else concat_with_space(FirstName, LastName, 1)
      end as FullName,
      Town,
      Country
}
