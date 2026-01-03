CLASS zcl_rh_configuration DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_rh_configuration_factory.

  PUBLIC SECTION.
    INTERFACES zif_rh_configuration.

  PRIVATE SECTION.
    METHODS select_configs
      IMPORTING config_id     TYPE zrh_config_id
      RETURNING VALUE(result) TYPE zif_rh_configuration=>configs.
ENDCLASS.


CLASS zcl_rh_configuration IMPLEMENTATION.
  METHOD zif_rh_configuration~get_value.
    DATA(found_configurations) = zif_rh_configuration~get_values( config_id ).
    DATA(found_entry) = VALUE #( found_configurations[ 1 ] OPTIONAL ).
    RETURN found_entry-low.
  ENDMETHOD.


  METHOD zif_rh_configuration~get_values.
    DATA(found_configurations) = select_configs( config_id ).

    LOOP AT found_configurations INTO DATA(config) WHERE Value IS NOT INITIAL OR ValueHigh IS NOT INITIAL.
      INSERT VALUE #( sign = 'I' ) INTO TABLE result REFERENCE INTO DATA(new_line).

      IF config-Value IS NOT INITIAL AND config-ValueHigh IS NOT INITIAL.
        new_line->option = 'BT'.
        new_line->low    = config-Value.
        new_line->high   = config-ValueHigh.

      ELSEIF config-Value IS NOT INITIAL.
        new_line->option = 'EQ'.
        new_line->low    = config-Value.

      ELSEIF config-ValueHigh IS NOT INITIAL.
        new_line->option = 'EQ'.
        new_line->low    = config-ValueHigh.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD zif_rh_configuration~is_active.
    DATA(found_value) = zif_rh_configuration~get_value( config_id ).
    RETURN xsdbool( to_upper( found_value ) = abap_true ).
  ENDMETHOD.


  METHOD select_configs.
    SELECT FROM ZRH_I_Configuration
      FIELDS *
      WHERE ConfigId = @config_id
      INTO TABLE @result
      PRIVILEGED ACCESS.
  ENDMETHOD.
ENDCLASS.
