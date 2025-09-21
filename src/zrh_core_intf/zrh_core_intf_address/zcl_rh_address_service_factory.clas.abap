CLASS zcl_rh_address_service_factory DEFINITION
  PUBLIC ABSTRACT FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_rh_address_service_inject.

  PUBLIC SECTION.
    CLASS-METHODS create_address
      RETURNING VALUE(result) TYPE REF TO zif_rh_address_service.

  PRIVATE SECTION.
    CLASS-DATA double_address TYPE REF TO zif_rh_address_service.
ENDCLASS.


CLASS zcl_rh_address_service_factory IMPLEMENTATION.
  METHOD create_address.
    IF double_address IS BOUND.
      RETURN double_address.
    ELSE.
      RETURN NEW zcl_rh_address_service( ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
