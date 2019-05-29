*&---------------------------------------------------------------------*
*& Program: ZUA_J1UN_DELETE_XML_FILES
*& Purpose: Delete unnecessary XML-files for incoming tax invoices
*&---------------------------------------------------------------------*

report zua_j1un_delete_xml_files.

include zua_j1un_delete_xml_controller.
include zua_j1un_delete_xml_sel_screen.
include zua_j1un_delete_xml_sel_events.

form main.
  data:
    lo_app    type ref to lcl_app,
    ls_selopt type lcl_app=>ty_selopts.

  ls_selopt-bukrs = s_bukrs[].
  ls_selopt-gjahr = s_gjahr[].
  ls_selopt-stcd1 = s_stcd1[].

  create object lo_app.
  lo_app->run( is_selopts = ls_selopt ).

endform.

start-of-selection.
  perform main.

  call screen 100.
