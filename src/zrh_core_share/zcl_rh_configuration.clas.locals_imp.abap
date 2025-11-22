CLASS ltc_config DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    METHODS get_first_value FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltc_config IMPLEMENTATION.
  METHOD get_first_value.
    DATA(config) = zcl_rh_configuration_factory=>create_config( ).

    DATA(result) = config->get_value( config->configuration-default_capacity ).

    cl_abap_unit_assert=>assert_not_initial( result ).
  ENDMETHOD.
ENDCLASS.
