INTERFACE zif_rh_address_service
  PUBLIC.

  METHODS determine_address
    IMPORTING contact       TYPE ZRH_R_ContactTP
    RETURNING VALUE(result) TYPE ZRH_R_ContactTP.
ENDINTERFACE.
