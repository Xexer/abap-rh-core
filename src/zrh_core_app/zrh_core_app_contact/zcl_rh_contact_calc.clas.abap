CLASS zcl_rh_contact_calc DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_sadl_exit.
    INTERFACES if_sadl_exit_calc_element_read.
ENDCLASS.


CLASS zcl_rh_contact_calc IMPLEMENTATION.
  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA original_data TYPE STANDARD TABLE OF ZRH_C_ContactTP WITH EMPTY KEY.

    original_data = CORRESPONDING #( it_original_data ).

    LOOP AT original_data REFERENCE INTO DATA(original).
      original->ContactTypeIcon = SWITCH #( original->ContactTypeInt
                                            WHEN zif_rh_contact_constants=>contact_type-address THEN
                                              `sap-icon://addresses`
                                            WHEN zif_rh_contact_constants=>contact_type-customer THEN
                                              `sap-icon://customer-and-supplier`
                                            WHEN zif_rh_contact_constants=>contact_type-employee THEN
                                              `sap-icon://employee` ).

      CASE original->ContactTypeInt.
        WHEN zif_rh_contact_constants=>contact_type-address.
          original->isHiddenBirthday     = abap_true.
          original->isHiddenEmail        = abap_true.
          original->isHiddenTelephone    = abap_true.
          original->isHiddenContactFacet = abap_true.
        WHEN zif_rh_contact_constants=>contact_type-customer.
          original->isHiddenBirthday = abap_true.
      ENDCASE.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( original_data ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    IF iv_entity <> 'ZRH_C_CONTACTTP'.
      RETURN.
    ENDIF.

    et_requested_orig_elements = VALUE #( ( `CONTACTTYPEINT` ) ).
  ENDMETHOD.
ENDCLASS.
