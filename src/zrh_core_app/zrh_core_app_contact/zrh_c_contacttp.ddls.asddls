@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RH: Contact (Consumption)'
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: [ 'ContactId' ]
define root view entity ZRH_C_ContactTP
  provider contract transactional_query
  as projection on ZRH_R_ContactTP
{
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRH_I_ContactVH', element : 'ContactId' } }]
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 1.0
  key     ContactId,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRH_I_ContactTypeVH', element : 'ContactTypeInt' } }]
          @ObjectModel.text.element: [ 'ContactTypeDescription' ]
          @UI.textArrangement: #TEXT_FIRST
          ContactTypeInt,
          _ContactTypeInternal.Description as ContactTypeDescription,
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          FirstName,
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          LastName,
          _ContactInfo.FullName,
          Birthday,
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          Street,
          HouseNumber,
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          Town,
          ZipCode,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CountryVH', element : 'Country' } }]
          @ObjectModel.text.element: [ 'CountryName' ]
          @UI.textArrangement: #TEXT_FIRST
          Country,
          _Country.Description             as CountryName,
          Telephone,
          Email,
          @ObjectModel.text.element: [ 'CreatedName' ]
          @UI.textArrangement: #TEXT_ONLY
          LocalCreatedBy,
          _UserCreated.PersonFullName      as CreatedName,
          @ObjectModel.text.element: [ 'ChangedName' ]
          @UI.textArrangement: #TEXT_ONLY
          LocalLastChangedBy,
          _UserChanged.PersonFullName      as ChangedName,
          LocalLastChanged,
          LastChanged,

          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_RH_CONTACT_CALC'
  virtual ContactTypeIcon      : abap.string,

          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_RH_CONTACT_CALC'
  virtual isHiddenTelephone    : abap_boolean,

          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_RH_CONTACT_CALC'
  virtual isHiddenEmail        : abap_boolean,

          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_RH_CONTACT_CALC'
  virtual isHiddenBirthday     : abap_boolean,

          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_RH_CONTACT_CALC'
  virtual isHiddenContactFacet : abap_boolean,

          _ContactTypeInternal,
          _ContactInfo,
          _Country,
          _UserCreated,
          _UserChanged
}
