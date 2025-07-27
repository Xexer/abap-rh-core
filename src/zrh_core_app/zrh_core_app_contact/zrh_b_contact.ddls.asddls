@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RH: Contact (Base)'
define view entity ZRH_B_Contact
  as select from zrh_contact
{
  key contact_id            as ContactId,
      contact_type          as ContactTypeInt,
      first_name            as FirstName,
      last_name             as LastName,
      birthday              as Birthday,
      street                as Street,
      house_number          as HouseNumber,
      town                  as Town,
      zip_code              as ZipCode,
      country               as Country,
      telephone             as Telephone,
      email                 as Email,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.user.localInstanceLastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed    as LocalLastChanged,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed          as LastChanged
}
