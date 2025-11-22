@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Configuration value help'
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZRH_I_ConfigVH
  as select from    DDCDS_CUSTOMER_DOMAIN_VALUE(
                      p_domain_name : 'ZRH_CONFIG_ID') as Values
    left outer join DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                      p_domain_name : 'ZRH_CONFIG_ID') as Texts on  Texts.domain_name    = Values.domain_name
                                                                and Texts.value_position = Values.value_position
                                                                and Texts.language       = $session.system_language
{
      @ObjectModel.text.element: [ 'Description' ]
      @UI.textArrangement: #TEXT_ONLY
  key Values.value_low as ConfigId,

      @UI.hidden: true
      Texts.text       as Description
}
