@EndUserText.label: 'RH: Configuration'
@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
define view entity ZRH_I_Configuration
  as select from zrh_config
  association              to parent ZRH_R_ConfigurationS as _ConfigAll on $projection.SingletonID = _ConfigAll.SingletonID
  association of exact one to one ZRH_I_ConfigVH          as _ConfigVH  on _ConfigVH.ConfigId = $projection.ConfigId
  association of exact one to one ZRH_I_ProcessVH         as _ProcessVH on _ProcessVH.Process = $projection.Process
{
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRH_I_ConfigVH', element : 'ConfigId' } }]
      @ObjectModel.text.element: [ 'ConfigText' ]
      @UI.textArrangement: #TEXT_ONLY
  key config_id              as ConfigId,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZRH_I_ProcessVH', element : 'Process' } }]
      @ObjectModel.text.element: [ 'ProcessText' ]
      @UI.textArrangement: #TEXT_ONLY
      process                as Process,
      value                  as Value,
      value_high             as ValueHigh,
      _ConfigVH.Description  as ConfigText,
      _ProcessVH.Description as ProcessText,
      @Consumption.hidden: true
      1                      as SingletonID,
      _ConfigAll,
      _ConfigVH,
      _ProcessVH
}
