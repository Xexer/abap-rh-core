CLASS zcl_rh_contact_behavior DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC
  FOR BEHAVIOR OF ZRH_R_ContactTP.

  PUBLIC SECTION.
    TYPES create_mapped TYPE RESPONSE FOR MAPPED EARLY zrh_r_contacttp.

    TYPES: BEGIN OF number_result,
             new_number TYPE zrh_contact_id,
             log        TYPE REF TO zif_aml_log,
           END OF number_result.

    TYPES imported_keys TYPE TABLE FOR VALIDATION zrh_r_contacttp\\contact~checkcontactforcustomer.

    TYPES read_result   TYPE TABLE FOR READ RESULT zrh_r_contacttp\\contact.

    TYPES activity_base TYPE c LENGTH 2.

    TYPES:
      BEGIN OF result_auth_create,
        address  TYPE abap_boolean,
        customer TYPE abap_boolean,
        employee TYPE abap_boolean,
      END OF result_auth_create.

    TYPES:
      BEGIN OF result_auth_actions,
        create  TYPE abap_boolean,
        change  TYPE abap_boolean,
        display TYPE abap_boolean,
        delete  TYPE abap_boolean,
      END OF result_auth_actions.

    CONSTANTS:
      BEGIN OF activities,
        create  TYPE activity_base VALUE '01',
        change  TYPE activity_base VALUE '02',
        display TYPE activity_base VALUE '03',
        delete  TYPE activity_base VALUE '06',
      END OF activities.

    METHODS get_selected_entries
      IMPORTING !keys         TYPE imported_keys
      RETURNING VALUE(result) TYPE read_result.

    METHODS create_new_contact
      IMPORTING !cid          TYPE abp_behv_cid
                is_draft      TYPE abp_behv_flag
                contact_type  TYPE zrh_contact_type
      RETURNING VALUE(result) TYPE create_mapped.

    METHODS get_new_number
      IMPORTING pid           TYPE abp_behv_pid
      RETURNING VALUE(result) TYPE number_result.

    METHODS has_authority
      IMPORTING activity      TYPE activity_base
                contact_type  TYPE zrh_contact_type
      RETURNING VALUE(result) TYPE abap_boolean.

    METHODS get_auth_create
      RETURNING VALUE(result) TYPE result_auth_create.

    METHODS get_auth_actions
      IMPORTING contact_type  TYPE zrh_contact_type
      RETURNING VALUE(result) TYPE result_auth_actions.
ENDCLASS.


CLASS zcl_rh_contact_behavior IMPLEMENTATION.
  METHOD has_authority.
    AUTHORITY-CHECK OBJECT 'ZRHCONTACT'
                    ID 'ACTVT' FIELD activity
                    ID 'ZRH_CTYPE' FIELD contact_type.

    RETURN xsdbool( sy-subrc = 0 ).
  ENDMETHOD.


  METHOD get_auth_create.
    result-address  = has_authority( activity     = activities-create
                                     contact_type = zif_rh_contact_constants=>contact_type-address ).

    result-customer = has_authority( activity     = activities-create
                                     contact_type = zif_rh_contact_constants=>contact_type-customer ).

    result-employee = has_authority( activity     = activities-create
                                     contact_type = zif_rh_contact_constants=>contact_type-employee ).
  ENDMETHOD.


  METHOD get_auth_actions.
    result-create  = has_authority( activity     = activities-create
                                    contact_type = contact_type ).

    result-change  = has_authority( activity     = activities-change
                                    contact_type = contact_type ).

    result-display = has_authority( activity     = activities-display
                                    contact_type = contact_type ).

    result-delete  = has_authority( activity     = activities-delete
                                    contact_type = contact_type ).
  ENDMETHOD.


  METHOD create_new_contact.
    MODIFY ENTITIES OF ZRH_R_ContactTP IN LOCAL MODE
           ENTITY Contact
           CREATE FROM VALUE #( ( %cid                    = cid
                                  %is_draft               = is_draft
                                  ContactTypeInt          = contact_type
                                  %control-ContactTypeInt = if_abap_behv=>mk-on ) )
           MAPPED result.
  ENDMETHOD.


  METHOD get_new_number.
    DATA number_range    TYPE cl_numberrange_runtime=>nr_interval.
    DATA external_number TYPE n LENGTH 9.

    result-log = zcl_aml_log_factory=>create( ).

    READ ENTITIES OF ZRH_R_ContactTP IN LOCAL MODE
         ENTITY Contact
         FIELDS ( ContactTypeInt ) WITH VALUE #( ( %pid = pid ) )
         RESULT DATA(new_entries).

    TRY.
        DATA(new_entry) = new_entries[ 1 ].
      CATCH cx_sy_itab_line_not_found INTO DATA(error_not_found).
        result-log->add_message_exception( error_not_found ).
        RETURN.
    ENDTRY.

    CASE new_entry-ContactTypeInt.
      WHEN zif_rh_contact_constants=>contact_type-address.
        number_range = '09'.
      WHEN zif_rh_contact_constants=>contact_type-customer.
        number_range = '05'.
      WHEN zif_rh_contact_constants=>contact_type-employee.
        number_range = '01'.
    ENDCASE.

    TRY.
        cl_numberrange_runtime=>number_get( EXPORTING nr_range_nr = number_range
                                                      object      = 'ZRHCONTACT'
                                            IMPORTING number      = DATA(new_number)
                                                      returncode  = DATA(return_code) ).

        IF return_code <> abap_false.
          result-log->add_message( class  = 'ZRH_CORE'
                                   type   = 'E'
                                   number = '001'
                                   v1     = 'ZRHCONTACT'
                                   v2     = return_code ).
        ENDIF.

      CATCH cx_nr_object_not_found INTO DATA(error_object).
        result-log->add_message_exception( error_object ).
      CATCH cx_number_ranges INTO DATA(error_range).
        result-log->add_message_exception( error_range ).
    ENDTRY.

    external_number = new_number.
    result-new_number = substring( val = new_entry-ContactTypeInt
                                   off = 0
                                   len = 1 ) && external_number.
  ENDMETHOD.


  METHOD get_selected_entries.
    READ ENTITIES OF ZRH_R_ContactTP IN LOCAL MODE
         ENTITY Contact ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT result.
  ENDMETHOD.
ENDCLASS.
