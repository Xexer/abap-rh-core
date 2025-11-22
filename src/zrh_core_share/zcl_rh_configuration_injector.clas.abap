CLASS zcl_rh_configuration_injector DEFINITION
  PUBLIC ABSTRACT FINAL
  CREATE PUBLIC
  FOR TESTING.

  PUBLIC SECTION.
    CLASS-METHODS inject_config
      IMPORTING double TYPE REF TO zif_rh_configuration.
ENDCLASS.


CLASS zcl_rh_configuration_injector IMPLEMENTATION.
  METHOD inject_config.
    zcl_rh_configuration_factory=>double_config = double.
  ENDMETHOD.
ENDCLASS.
