class ZUA_J1UN_XML_ALV_VIEWER definition inheriting from cl_gui_alv_grid
  public
  final
  create public .

public section.

  class ZUA_J1UN_XML_SELECTOR definition load .
  methods CONSTRUCTOR
    importing
      !IT_DATA type ZUA_J1UN_XML_SELECTOR=>TY_TT_DATA .
  methods DISPLAY_REPORT .
  methods GET_SELECTED_LINES
    returning
      value(RT_LINES) type ZUA_J1UN_XML_SELECTOR=>TY_TT_DATA .
protected section.
private section.

  class ZUA_J1UN_XML_SELECTOR definition load .
  data AT_DATA type ZUA_J1UN_XML_SELECTOR=>TY_TT_DATA .
  data MO_ALV type ref to CL_GUI_ALV_GRID .

  methods BUILD_FIELDCAT
    returning
      value(RT_FIELDCAT) type LVC_T_FCAT .
  methods BUILD_LAYOUT
    returning
      value(RS_LAYOUT) type LVC_S_LAYO .
  methods EXCLUDE_BUTTONS
    returning
      value(RT_EXCLUDING) type UI_FUNCTIONS .
ENDCLASS.



CLASS ZUA_J1UN_XML_ALV_VIEWER IMPLEMENTATION.


method build_fieldcat.

  constants: lc_structure type slis_tabname value 'J_1UFDI_FILE_TBL'.

  data: lt_fieldcat type lvc_t_fcat.

  call function 'LVC_FIELDCATALOG_MERGE'
    exporting
      i_structure_name = lc_structure
    changing
      ct_fieldcat      = lt_fieldcat.

  rt_fieldcat = lt_fieldcat.

endmethod.


method build_layout.

  rs_layout-sel_mode    = 'A'.         " User can select the line
  rs_layout-zebra       = 'X'.         " Zebra display
  rs_layout-cwidth_opt  = 'X'.         " Optimization of columns width
  rs_layout-ctab_fname  = 'COLORCELL'. " Cells coloring

endmethod.


method constructor.
  at_data = it_data.
endmethod.


method display_report.

  data:
    "lo_alv       type ref to cl_gui_alv_grid,
    lt_fieldcat  type lvc_t_fcat,
    ls_layout    type lvc_s_layo,
    lt_excluding type ui_functions.

  " Prepare technical components of ALV-view
  lt_fieldcat  = me->build_fieldcat( ).
  ls_layout    = me->build_layout( ).
  lt_excluding = me->exclude_buttons( ).

  create object mo_alv
    exporting
      i_parent = cl_gui_container=>screen0
    exceptions
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      others            = 5.

  if sy-subrc <> 0.
    " Add error handling here
  endif.

  call method mo_alv->set_table_for_first_display
    exporting
      i_save               = 'A'
      i_default            = 'X'
      is_layout            = ls_layout
      it_toolbar_excluding = lt_excluding
    changing
      it_outtab            = mt_data
      it_fieldcatalog      = lt_fieldcat.

  if sy-subrc <> 0.
    " Add error handling here
  endif.

endmethod.


method exclude_buttons.

  data: ls_excluding like line of rt_excluding.

  define _add_exclude.
    ls_excluding = &1.
    append ls_excluding to rt_excluding.
  end-of-definition.

  _add_exclude cl_gui_alv_grid=>mc_fc_graph.
  _add_exclude cl_gui_alv_grid=>mc_fc_info.
  _add_exclude cl_gui_alv_grid=>mc_fc_loc_copy.
  _add_exclude cl_gui_alv_grid=>mc_fc_loc_copy_row.
  _add_exclude cl_gui_alv_grid=>mc_fc_loc_cut.
  _add_exclude cl_gui_alv_grid=>mc_fc_loc_delete_row.
  _add_exclude cl_gui_alv_grid=>mc_fc_loc_insert_row.
  _add_exclude cl_gui_alv_grid=>mc_fc_loc_move_row.
  _add_exclude cl_gui_alv_grid=>mc_fc_loc_paste.
  _add_exclude cl_gui_alv_grid=>mc_fc_loc_undo.
  _add_exclude cl_gui_alv_grid=>mc_fc_loc_paste_new_row.
  _add_exclude cl_gui_alv_grid=>mc_fc_loc_append_row.
  _add_exclude cl_gui_alv_grid=>mc_fc_check.
  _add_exclude cl_gui_alv_grid=>mc_fc_refresh.

endmethod.


method get_selected_lines.

  data:
    lt_rows type lvc_t_row,
    ls_row  type lvc_s_row,
    ls_line like line of rt_lines.

  field-symbols:
    <xml_files> type standard table,
    <xml_file>  type j_1ufdi_file_tbl.

  call method mo_alv->get_selected_rows
    importing
      et_index_rows = lt_rows.

  if lines( lt_rows ) is initial.
    return. "raise exception type.
  endif.

*  assign mo_alv-> mt_outtab->* to <xml_files>.

*  loop at lt_rows into ls_row.
*    read table <xml_files> assigning <xml_file> index ls_row-index.
*    check sy-subrc is initial.
*    move-corresponding <xml_file> to ls_line.
*    append ls_line to rt_line.
*  endloop.

endmethod.
ENDCLASS.
