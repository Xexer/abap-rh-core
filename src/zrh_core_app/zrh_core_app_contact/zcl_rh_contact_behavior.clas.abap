CLASS zcl_rh_contact_behavior DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC
  FOR BEHAVIOR OF ZRH_R_ContactTP.

  PUBLIC SECTION.
    TYPES create_mapped TYPE RESPONSE FOR MAPPED EARLY zrh_r_contacttp.

    TYPES:
      BEGIN OF number_result,
        new_number TYPE zrh_contact_id,
        log        TYPE REF TO zif_aml_log,
      END OF number_result.

    METHODS create_new_contact
      IMPORTING !cid          TYPE abp_behv_cid
                is_draft      TYPE abp_behv_flag
                contact_type  TYPE zrh_contact_type
      RETURNING VALUE(result) TYPE create_mapped.

    METHODS get_new_number
      IMPORTING pid           TYPE abp_behv_pid
      RETURNING VALUE(result) TYPE number_result.
ENDCLASS.


CLASS zcl_rh_contact_behavior IMPLEMENTATION.
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
ENDCLASS.
