CLASS zcl_rh_test_initial_data DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    CONSTANTS github_path TYPE string VALUE `https://raw.githubusercontent.com/Xexer/abap-rh-core/refs/heads/main/data/`.

    METHODS load_contacts
      IMPORTING !out TYPE REF TO if_oo_adt_classrun_out.

    METHODS get_container_for_file
      IMPORTING file_name     TYPE string
      RETURNING VALUE(result) TYPE REF TO zif_test_container.

    METHODS load_tags
      IMPORTING !out TYPE REF TO if_oo_adt_classrun_out.

    METHODS load_document_types
      IMPORTING !out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.


CLASS zcl_rh_test_initial_data IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*    DELETE FROM zrh_contact.
    DELETE FROM zrh_tag.
    DELETE FROM zrh_doc_type.
    COMMIT WORK.

*    load_contacts( out ).
    load_tags( out ).
    load_document_types( out ).
  ENDMETHOD.


  METHOD load_document_types.
    DATA new_doc_types TYPE TABLE FOR CREATE ZRH_I_DocumentTypeS\_DocumentType.

    INSERT VALUE #( SingletonID = 1 ) INTO TABLE new_doc_types REFERENCE INTO DATA(new_type).
    get_container_for_file( `document_types.json` )->get_json_data( CHANGING generic = new_type->%target ).

    MODIFY ENTITIES OF ZRH_I_DocumentTypeS
           ENTITY DocumentTypeAll
           CREATE BY \_DocumentType FIELDS ( DocumentType Description Process )
           AUTO FILL CID WITH new_doc_types
           FAILED DATA(failed)
           MAPPED DATA(mapped)
           REPORTED DATA(reported).

    COMMIT ENTITIES.

    out->write( failed-DocumentType ).
    out->write( mapped-DocumentType ).
    out->write( reported-DocumentType ).
  ENDMETHOD.


  METHOD load_tags.
    DATA new_tags TYPE TABLE FOR CREATE ZRH_R_TagsS\_Tags.

    INSERT VALUE #( SingletonID = 1 ) INTO TABLE new_tags REFERENCE INTO DATA(new_tag).
    get_container_for_file( `tags.json` )->get_json_data( CHANGING generic = new_tag->%target ).

    MODIFY ENTITIES OF ZRH_R_TagsS
           ENTITY TagsAll
           CREATE BY \_Tags FIELDS ( Description )
           AUTO FILL CID WITH new_tags
           FAILED DATA(failed)
           MAPPED DATA(mapped)
           REPORTED DATA(reported).

    COMMIT ENTITIES.

    out->write( failed-tags ).
    out->write( mapped-tags ).
    out->write( reported-tags ).
  ENDMETHOD.


  METHOD load_contacts.
    DATA new_contacts TYPE TABLE FOR CREATE ZRH_R_ContactTP.

    get_container_for_file( `contacts.json` )->get_json_data( CHANGING generic = new_contacts ).

    MODIFY ENTITIES OF ZRH_R_ContactTP
           ENTITY Contact
           CREATE FIELDS ( ContactTypeInt FirstName LastName Birthday Street HouseNumber Town ZipCode Country Telephone Email )
           AUTO FILL CID WITH new_contacts
           FAILED DATA(failed)
           MAPPED DATA(mapped)
           REPORTED DATA(reported).

    COMMIT ENTITIES.

    out->write( failed-contact ).
    out->write( mapped-contact ).
    out->write( reported-contact ).
  ENDMETHOD.


  METHOD get_container_for_file.
    DATA(config) = NEW zcl_tdc_github_config( github_path && file_name ).
    RETURN zcl_test_container_factory=>create( config ).
  ENDMETHOD.
ENDCLASS.
