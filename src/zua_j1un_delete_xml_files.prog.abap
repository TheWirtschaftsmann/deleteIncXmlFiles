*&---------------------------------------------------------------------*
*& Program: ZUA_J1UN_DELETE_XML_FILES
*& Purpose: Delete unnecessary XML-files for incoming tax invoices
*&---------------------------------------------------------------------*

report zua_j1un_delete_xml_files.

include zua_j1un_delete_xml_top.
include zua_j1un_delete_xml_controller.
include zua_j1un_delete_xml_sel_screen.
include zua_j1un_delete_xml_sel_events.
include zua_j1un_delete_xml_alv.

start-of-selection.

  perform main.
  set screen 100.
