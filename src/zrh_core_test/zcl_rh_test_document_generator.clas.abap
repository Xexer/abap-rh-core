CLASS zcl_rh_test_document_generator DEFINITION
  PUBLIC
  INHERITING FROM cl_xco_cp_adt_simple_classrun FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

  PROTECTED SECTION.
    METHODS
      main REDEFINITION.

  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_rh_test_document_generator IMPLEMENTATION.
  METHOD main.
    DATA generator_config TYPE zif_gen_objects=>ddic_configuration.

    DATA(config) = NEW zcl_tdc_github_config( `https://raw.githubusercontent.com/Xexer/abap-rh-core/refs/heads/main/data/generator_document.json` ).
    DATA(container) = zcl_test_container_factory=>create( config ).
    container->get_json_data( CHANGING generic = generator_config ).

    DATA(generator) = zcl_gen_objects_factory=>create_generator( sy-repid ).
    DATA(result) = generator->generate_ddic( generator_config ).

    out->write( result ).
  ENDMETHOD.
ENDCLASS.
