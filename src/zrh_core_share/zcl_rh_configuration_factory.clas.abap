CLASS zcl_rh_configuration_factory DEFINITION
  PUBLIC ABSTRACT FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_rh_configuration_injector.

  PUBLIC SECTION.
    CLASS-METHODS create_config
      RETURNING VALUE(result) TYPE REF TO zif_rh_configuration.

  PRIVATE SECTION.
    CLASS-DATA double_config TYPE REF TO zif_rh_configuration.
ENDCLASS.


CLASS zcl_rh_configuration_factory IMPLEMENTATION.
  METHOD create_config.
    IF double_config IS BOUND.
      RETURN double_config.
    ELSE.
      RETURN NEW zcl_rh_configuration( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
