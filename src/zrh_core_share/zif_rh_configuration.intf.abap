INTERFACE zif_rh_configuration
  PUBLIC.

  TYPES config_id    TYPE zrh_config_id.
  TYPES process_type TYPE zrh_process.
  TYPES value_type   TYPE zrh_config_value.

  TYPES config       TYPE ZRH_I_Configuration.
  TYPES configs      TYPE STANDARD TABLE OF config WITH EMPTY KEY.
  TYPES value_range  TYPE RANGE OF value_type.

  CONSTANTS: BEGIN OF configuration,
               location_api         TYPE config_id VALUE 'LOCA_API',
               price_api            TYPE config_id VALUE 'PRICE_API',
               pickup_date_modifier TYPE config_id VALUE 'PICK_MODI',
               default_capacity     TYPE config_id VALUE 'DEF_CAPA',
             END OF configuration.

  CONSTANTS: BEGIN OF Process,
               core      TYPE process_type VALUE 'CORE',
               employee  TYPE process_type VALUE 'EMPLOYEE',
               material  TYPE process_type VALUE 'MATERIAL',
               recycling TYPE process_type VALUE 'RECYCLING',
               financial TYPE process_type VALUE 'FINANCIAL',
             END OF process.

  METHODS get_value
    IMPORTING config_id     TYPE config_id
    RETURNING VALUE(result) TYPE value_type.

  METHODS get_values
    IMPORTING config_id     TYPE config_id
    RETURNING VALUE(result) TYPE value_range.

  METHODS is_active
    IMPORTING config_id     TYPE config_id
    RETURNING VALUE(result) TYPE abap_boolean.
ENDINTERFACE.
