CLASS zcl_rh_address_service_inject DEFINITION
  PUBLIC ABSTRACT FINAL
  CREATE PUBLIC
  FOR TESTING.

  PUBLIC SECTION.
    CLASS-METHODS inject_address
      IMPORTING double TYPE REF TO zif_rh_address_service OPTIONAL.
ENDCLASS.


CLASS zcl_rh_address_service_inject IMPLEMENTATION.
  METHOD inject_address.
    zcl_rh_address_service_factory=>double_address = double.
  ENDMETHOD.
ENDCLASS.
