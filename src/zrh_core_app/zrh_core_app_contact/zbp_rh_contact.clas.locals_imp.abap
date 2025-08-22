

CLASS lhc_Contact DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Contact RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Contact RESULT result.

    METHODS createAddress FOR MODIFY
      IMPORTING keys FOR ACTION Contact~createAddress.

    METHODS createCustomer FOR MODIFY
      IMPORTING keys FOR ACTION Contact~createCustomer.

    METHODS createEmployee FOR MODIFY
      IMPORTING keys FOR ACTION Contact~createEmployee.
ENDCLASS.


CLASS lhc_Contact IMPLEMENTATION.
  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD createAddress.
    DATA(helper) = NEW zcl_rh_contact_behavior( ).

    LOOP AT keys INTO DATA(key).
      DATA(created) = helper->create_new_contact( cid          = key-%cid
                                                  is_draft     = key-%param-%is_draft
                                                  contact_type = zif_rh_contact_constants=>contact_type-address ).
      INSERT LINES OF created-contact INTO TABLE mapped-contact.
    ENDLOOP.
  ENDMETHOD.


  METHOD createCustomer.
    DATA(helper) = NEW zcl_rh_contact_behavior( ).

    LOOP AT keys INTO DATA(key).
      DATA(created) = helper->create_new_contact( cid          = key-%cid
                                                  is_draft     = key-%param-%is_draft
                                                  contact_type = zif_rh_contact_constants=>contact_type-customer ).
      INSERT LINES OF created-contact INTO TABLE mapped-contact.
    ENDLOOP.
  ENDMETHOD.


  METHOD createEmployee.
    DATA(helper) = NEW zcl_rh_contact_behavior( ).

    LOOP AT keys INTO DATA(key).
      DATA(created) = helper->create_new_contact( cid          = key-%cid
                                                  is_draft     = key-%param-%is_draft
                                                  contact_type = zif_rh_contact_constants=>contact_type-employee ).
      INSERT LINES OF created-contact INTO TABLE mapped-contact.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.


CLASS lsc_zrh_r_contacttp DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS
      adjust_numbers REDEFINITION.

ENDCLASS.


CLASS lsc_zrh_r_contacttp IMPLEMENTATION.
  METHOD adjust_numbers.
    DATA(helper) = NEW zcl_rh_contact_behavior( ).

    LOOP AT mapped-contact REFERENCE INTO DATA(new_contact).
      DATA(number_result) = helper->get_new_number( new_contact->%pid ).

      new_contact->ContactId = number_result-new_number.

      INSERT LINES OF number_result-log->get_messages_rap( ) INTO TABLE reported-%other.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
