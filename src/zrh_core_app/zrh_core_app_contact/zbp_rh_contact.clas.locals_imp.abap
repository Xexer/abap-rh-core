

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

    METHODS fillAddressInformation FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Contact~fillAddressInformation.

    METHODS checkContactForCustomer FOR VALIDATE ON SAVE
      IMPORTING keys FOR Contact~checkContactForCustomer.

    METHODS checkMailForEmployee FOR VALIDATE ON SAVE
      IMPORTING keys FOR Contact~checkMailForEmployee.

    METHODS checkNameIsFilled FOR VALIDATE ON SAVE
      IMPORTING keys FOR Contact~checkNameIsFilled.
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


  METHOD fillAddressInformation.
    DATA(address) = zcl_rh_address_service_factory=>create_address( ).

    DATA(helper) = NEW zcl_rh_contact_behavior( ).
    DATA(selected_entries) = helper->get_selected_entries( CORRESPONDING #( keys ) ).

    LOOP AT selected_entries INTO DATA(entry) WHERE ZipCode IS NOT INITIAL AND ( Town IS INITIAL OR Country IS INITIAL ).
      DATA(new_address) = address->determine_address( CORRESPONDING #( entry ) ).

      MODIFY ENTITIES OF ZRH_R_ContactTP IN LOCAL MODE
             ENTITY Contact
             UPDATE FROM VALUE #( ( %tky             = entry-%tky
                                    Town             = new_address-Town
                                    Country          = new_address-Country
                                    %control-Town    = if_abap_behv=>mk-on
                                    %control-Country = if_abap_behv=>mk-on ) ).
    ENDLOOP.
  ENDMETHOD.


  METHOD checkContactForCustomer.
    DATA(helper) = NEW zcl_rh_contact_behavior( ).
    DATA(selected_entries) = helper->get_selected_entries( keys ).

    LOOP AT selected_entries INTO DATA(entry) WHERE Email IS INITIAL AND Telephone IS INITIAL AND ContactTypeInt = zif_rh_contact_constants=>contact_type-customer.
      INSERT VALUE #( %tky = entry-%tky ) INTO TABLE failed-contact.
      INSERT VALUE #( %tky               = entry-%tky
                      %element-Email     = if_abap_behv=>mk-on
                      %element-Telephone = if_abap_behv=>mk-on
                      %msg               = new_message( id       = 'ZRH_CORE'
                                                        number   = '002'
                                                        severity = if_abap_behv_message=>severity-error ) )
             INTO TABLE reported-contact.
    ENDLOOP.
  ENDMETHOD.


  METHOD checkMailForEmployee.
    DATA(helper) = NEW zcl_rh_contact_behavior( ).
    DATA(selected_entries) = helper->get_selected_entries( CORRESPONDING #( keys ) ).

    LOOP AT selected_entries INTO DATA(entry) WHERE Email IS INITIAL AND ContactTypeInt = zif_rh_contact_constants=>contact_type-employee.
      INSERT VALUE #( %tky = entry-%tky ) INTO TABLE failed-contact.
      INSERT VALUE #( %tky           = entry-%tky
                      %element-Email = if_abap_behv=>mk-on
                      %msg           = new_message( id       = 'ZRH_CORE'
                                                    number   = '003'
                                                    severity = if_abap_behv_message=>severity-error ) )
             INTO TABLE reported-contact.
    ENDLOOP.
  ENDMETHOD.


  METHOD checkNameIsFilled.
    DATA(helper) = NEW zcl_rh_contact_behavior( ).
    DATA(selected_entries) = helper->get_selected_entries( CORRESPONDING #( keys ) ).

    LOOP AT selected_entries INTO DATA(entry) WHERE     FirstName IS INITIAL AND LastName IS INITIAL
                                                    AND (    ContactTypeInt = zif_rh_contact_constants=>contact_type-employee
                                                          OR ContactTypeInt = zif_rh_contact_constants=>contact_type-customer ).
      INSERT VALUE #( %tky = entry-%tky ) INTO TABLE failed-contact.
      INSERT VALUE #( %tky               = entry-%tky
                      %element-FirstName = if_abap_behv=>mk-on
                      %element-LastName  = if_abap_behv=>mk-on
                      %msg               = new_message( id       = 'ZRH_CORE'
                                                        number   = '004'
                                                        severity = if_abap_behv_message=>severity-error ) )
             INTO TABLE reported-contact.
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
