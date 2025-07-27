CLASS lhc_Contact DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Contact RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Contact RESULT result.

ENDCLASS.


CLASS lhc_Contact IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD get_global_authorizations.
  ENDMETHOD.
ENDCLASS.
