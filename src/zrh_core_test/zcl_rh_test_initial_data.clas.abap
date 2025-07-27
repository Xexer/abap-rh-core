CLASS zcl_rh_test_initial_data DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_rh_test_initial_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA contacts TYPE STANDARD TABLE OF zrh_contact WITH EMPTY KEY.

    contacts = VALUE #( first_name            = 'Herbert'
                        last_name             = 'Mueller'
                        birthday              = '19800601'
                        street                = 'Test-Street'
                        house_number          = '01'
                        town                  = 'Cologne'
                        zip_code              = '51107'
                        country               = 'DE'
                        telephone             = '0221/1234 56789'
                        email                 = 'herbert.mueller@swh.com'
                        local_created_by      = 'CB9980000024'
                        local_last_changed_by = ''
                        local_last_changed    = '20250726115054.2961870'
                        last_changed          = '20250726115054.2961870'
                        ( contact_id   = 'C1'
                          contact_type = 'CU' )
                        ( contact_id   = 'E1'
                          contact_type = 'EM' ) ).

    DELETE FROM zrh_contact.
    INSERT zrh_contact FROM TABLE @contacts.
  ENDMETHOD.
ENDCLASS.
