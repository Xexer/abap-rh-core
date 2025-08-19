INTERFACE zif_rh_contact_constants
  PUBLIC.

  CONSTANTS: BEGIN OF contact_type,
               customer TYPE zrh_contact_type VALUE 'CU',
               address  TYPE zrh_contact_type VALUE 'AD',
               employee TYPE zrh_contact_type VALUE 'EM',
             END OF contact_type.
ENDINTERFACE.
