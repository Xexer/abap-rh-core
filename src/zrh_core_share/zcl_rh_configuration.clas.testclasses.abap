CLASS ltc_public_configuration DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    CLASS-DATA cds_environment TYPE REF TO if_cds_test_environment.

    DATA cut TYPE REF TO zif_rh_configuration.

    CLASS-METHODS class_setup.
    CLASS-METHODS class_teardown.

    METHODS setup.
    METHODS prepare_first_dataset.
    METHODS prepare_second_dataset.

    METHODS is_price_api_active    FOR TESTING RAISING cx_static_check.
    METHODS is_location_api_active FOR TESTING RAISING cx_static_check.
    METHODS default_capacity_value FOR TESTING RAISING cx_static_check.
    METHODS get_range_pickup_date  FOR TESTING RAISING cx_static_check.
    METHODS price_api_disabled     FOR TESTING RAISING cx_static_check.
    METHODS high_value_filled      FOR TESTING RAISING cx_static_check.
    METHODS date_range             FOR TESTING RAISING cx_static_check.
ENDCLASS.


CLASS ltc_public_configuration IMPLEMENTATION.
  METHOD class_setup.
    cds_environment = cl_cds_test_environment=>create( i_for_entity = 'ZRH_I_CONFIGURATION' ).
    cds_environment->enable_double_redirection( ).
  ENDMETHOD.


  METHOD class_teardown.
    cds_environment->destroy( ).
  ENDMETHOD.


  METHOD prepare_first_dataset.
    DATA configs TYPE STANDARD TABLE OF zrh_config WITH EMPTY KEY.

    cds_environment->clear_doubles( ).

    configs = VALUE #( ( config_id = zif_rh_configuration=>configuration-location_api value = abap_true )
                       ( config_id = zif_rh_configuration=>configuration-price_api value = abap_true )
                       ( config_id = zif_rh_configuration=>configuration-default_capacity value = '120' )
                       ( config_id = zif_rh_configuration=>configuration-pickup_date_modifier value = '2' ) ).

    cds_environment->insert_test_data( configs ).
  ENDMETHOD.


  METHOD prepare_second_dataset.
    DATA configs TYPE STANDARD TABLE OF zrh_config WITH EMPTY KEY.

    cds_environment->clear_doubles( ).

    configs = VALUE #(
        ( config_id = zif_rh_configuration=>configuration-price_api value = abap_false )
        ( config_id = zif_rh_configuration=>configuration-default_capacity value_high = '150' )
        ( config_id = zif_rh_configuration=>configuration-pickup_date_modifier value = '2' value_high = '5' ) ).

    cds_environment->insert_test_data( configs ).
  ENDMETHOD.


  METHOD setup.
    cut = zcl_rh_configuration_factory=>create_config( ).
  ENDMETHOD.


  METHOD date_range.
    prepare_second_dataset( ).
    DATA(result) = cut->get_values( cut->configuration-pickup_date_modifier ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE zif_rh_configuration=>value_range( ( sign   = 'I'
                                                                                         option = 'BT'
                                                                                         low    = '2'
                                                                                         high   = '5' ) )
                                        act = result ).
  ENDMETHOD.


  METHOD high_value_filled.
    prepare_second_dataset( ).
    DATA(result) = cut->get_value( cut->configuration-default_capacity ).

    cl_abap_unit_assert=>assert_equals( exp = '150'
                                        act = result ).
  ENDMETHOD.


  METHOD price_api_disabled.
    prepare_second_dataset( ).
    DATA(result) = cut->is_active( cut->configuration-price_api ).

    cl_abap_unit_assert=>assert_false( result ).
  ENDMETHOD.


  METHOD get_range_pickup_date.
    prepare_first_dataset( ).
    DATA(result) = cut->get_values( cut->configuration-pickup_date_modifier ).

    cl_abap_unit_assert=>assert_equals( exp = VALUE zif_rh_configuration=>value_range( ( sign   = 'I'
                                                                                         option = 'EQ'
                                                                                         low    = '2' ) )
                                        act = result ).
  ENDMETHOD.


  METHOD is_price_api_active.
    prepare_first_dataset( ).
    DATA(result) = cut->is_active( cut->configuration-price_api ).

    cl_abap_unit_assert=>assert_true( result ).
  ENDMETHOD.


  METHOD default_capacity_value.
    prepare_first_dataset( ).
    DATA(result) = cut->get_value( cut->configuration-default_capacity ).

    cl_abap_unit_assert=>assert_equals( exp = '120'
                                        act = result ).
  ENDMETHOD.


  METHOD is_location_api_active.
    prepare_first_dataset( ).
    DATA(result) = cut->is_active( cut->configuration-location_api ).

    cl_abap_unit_assert=>assert_true( result ).
  ENDMETHOD.
ENDCLASS.
