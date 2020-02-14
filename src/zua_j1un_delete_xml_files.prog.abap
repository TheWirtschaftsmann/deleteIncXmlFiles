*&---------------------------------------------------------------------*
*& Purpose: deletion of unnecessary XML-files for incoming tax docs.
*& Developed by: Bohdan Petrushchak, 2020
*&---------------------------------------------------------------------*

report zua_j1un_delete_xml_files.

include zua_j1un_delete_xml_top.
include zua_j1un_delete_xml_sel_screen.
include zua_j1un_delete_xml_model.
include zua_j1un_delete_xml_alv.
include zua_j1un_delete_xml_controller.

start-of-selection.

  gs_selopt-bukrs = s_bukrs[].
  gs_selopt-gjahr = s_gjahr[].
  gs_selopt-stcd1 = s_stcd1[].
  gs_selopt-xblnr = s_xblnr[].

  perform auth_check.

  create object go_controller exporting is_selopts = gs_selopt.
  call screen 100.

  include zua_j1un_delete_xml_sel_events.
