CLASS zcl_rh_address_service DEFINITION
  PUBLIC FINAL
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_rh_address_service_factory.

  PUBLIC SECTION.
    INTERFACES zif_rh_address_service.
ENDCLASS.


CLASS zcl_rh_address_service IMPLEMENTATION.
  METHOD zif_rh_address_service~determine_address.
    result = contact.

    CASE contact-ZipCode.
      WHEN '51107'.
        result-Town    = 'Cologne'.
        result-Country = 'DE'.
      WHEN '10245'.
        result-Town    = 'Berlin'.
        result-Country = 'DE'.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
