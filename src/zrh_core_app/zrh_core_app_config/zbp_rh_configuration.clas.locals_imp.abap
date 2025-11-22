CLASS lhc_zrh_r_configurations DEFINITION INHERITING FROM cl_abap_behavior_handler FINAL.
  PUBLIC SECTION.
    CONSTANTS co_entity               TYPE abp_entity_name                        VALUE `ZRH_R_CONFIGURATIONS`.
    CONSTANTS co_transport_object     TYPE mbc_cp_api=>indiv_transaction_obj_name VALUE `ZRH_CONFIGURATION`.
    CONSTANTS co_authorization_entity TYPE abp_entity_name                        VALUE `ZRH_I_CONFIGURATION`.

  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
              IMPORTING
                keys REQUEST requested_features FOR ConfigAll
              RESULT result.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
              IMPORTING
                 REQUEST requested_authorizations FOR ConfigAll
              RESULT result.
ENDCLASS.


CLASS lhc_zrh_r_configurations IMPLEMENTATION.
  METHOD get_instance_features.
    mbc_cp_api=>rap_bc_api( )->get_instance_features( transport_object   = co_transport_object
                                                      entity             = co_entity
                                                      keys               = REF #( keys )
                                                      requested_features = REF #( requested_features )
                                                      result             = REF #( result )
                                                      failed             = REF #( failed )
                                                      reported           = REF #( reported ) ).
  ENDMETHOD.


  METHOD get_global_authorizations.
    mbc_cp_api=>rap_bc_api( )->get_global_authorizations( entity                   = co_authorization_entity
                                                          requested_authorizations = REF #( requested_authorizations )
                                                          result                   = REF #( result )
                                                          reported                 = REF #( reported ) ).
  ENDMETHOD.
ENDCLASS.


CLASS lsc_zrh_r_configurations DEFINITION INHERITING FROM cl_abap_behavior_saver FINAL.
  PROTECTED SECTION.
    METHODS
      save_modified REDEFINITION.
ENDCLASS.


CLASS lsc_zrh_r_configurations IMPLEMENTATION.
  METHOD save_modified.
    mbc_cp_api=>rap_bc_api( )->record_changes( transport_object = lhc_ZRH_R_ConfigurationS=>co_transport_object
                                               entity           = lhc_ZRH_R_ConfigurationS=>co_entity
                                               create           = REF #( create )
                                               update           = REF #( update )
                                               delete           = REF #( delete )
                                               reported         = REF #( reported ) ).
    mbc_cp_api=>rap_bc_api( )->update_last_changed_date_time(
        maintenance_object = 'ZRH_CONFIGURATION'
        entity             = lhc_ZRH_R_ConfigurationS=>co_authorization_entity
        create             = REF #( create )
        update             = REF #( update )
        delete             = REF #( delete )
        reported           = REF #( reported ) ).
  ENDMETHOD.
ENDCLASS.


CLASS lhc_zrh_i_configuration DEFINITION INHERITING FROM cl_abap_behavior_handler FINAL.
  PUBLIC SECTION.
    CONSTANTS co_entity TYPE abp_entity_name VALUE `ZRH_I_CONFIGURATION`.

  PRIVATE SECTION.
    METHODS get_global_features FOR GLOBAL FEATURES
              IMPORTING
                REQUEST requested_features FOR Config
              RESULT result.
ENDCLASS.


CLASS lhc_zrh_i_configuration IMPLEMENTATION.
  METHOD get_global_features.
    mbc_cp_api=>rap_bc_api( )->get_global_features( transport_object   = lhc_ZRH_R_ConfigurationS=>co_transport_object
                                                    entity             = co_entity
                                                    requested_features = REF #( requested_features )
                                                    result             = REF #( result )
                                                    reported           = REF #( reported ) ).
  ENDMETHOD.
ENDCLASS.
