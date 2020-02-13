*&---------------------------------------------------------------------*
*& Program: ZUA_J1UN_DELETE_XML_FILES
*& Purpose: Delete unnecessary XML-files for incoming tax invoices
*&---------------------------------------------------------------------*

report zua_j1un_delete_xml_files.

include zua_j1un_delete_xml_top.
include zua_j1un_delete_xml_sel_screen.
include zua_j1un_delete_xml_model.
include zua_j1un_delete_xml_alv.
include zua_j1un_delete_xml_controller.

start-of-selection.

  data: ls_selopt type ty_selopts.

  ls_selopt-bukrs = s_bukrs[].
  ls_selopt-gjahr = s_gjahr[].
  ls_selopt-stcd1 = s_stcd1[].
  ls_selopt-xblnr = s_xblnr[].

  create object go_controller exporting is_selopts = ls_selopt.
  call screen 100.

  include zua_j1un_delete_xml_sel_events.
