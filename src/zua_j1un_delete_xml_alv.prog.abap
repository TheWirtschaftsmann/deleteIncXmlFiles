*&---------------------------------------------------------------------*
*&  Include for ALV-based routines
*&---------------------------------------------------------------------*
define add_exclude.
  ls_excluding = &1.
  append ls_excluding to rt_excluding.
end-of-definition.

class lcl_view definition inheriting from cl_gui_alv_grid.
  public section.
    methods: constructor importing iv_parent type ref to cl_gui_container.
    methods: setup_alv   changing  ct_data   type zua_j1un_xml_selector=>ty_tt_data.
    methods: get_selected_lines returning value(rt_lines) type zua_j1un_xml_selector=>ty_tt_data.
  private section.
    methods: build_fieldcatalog returning value(rt_fieldcat)  type lvc_t_fcat.
    methods: build_layout       returning value(rs_layout)    type lvc_s_layo.
    methods: exclude_buttons    returning value(rt_excluding) type ui_functions.
endclass.

class lcl_view implementation.
  method constructor.
    call method super->constructor
      exporting
        i_parent = iv_parent.
  endmethod.

  method setup_alv.
    data:
      lt_fieldcat  type lvc_t_fcat,
      ls_layout    type lvc_s_layo,
      lt_excluding type ui_functions.

    " Prepare technical components of ALV-view
    lt_fieldcat  = me->build_fieldcatalog( ).
    ls_layout    = me->build_layout( ).
    lt_excluding = me->exclude_buttons( ).

    " Pass data for ALV-display
    call method me->set_table_for_first_display
      exporting
        i_save               = 'A'
        i_default            = 'X'
        is_layout            = ls_layout
        it_toolbar_excluding = lt_excluding
      changing
        it_outtab            = ct_data
        it_fieldcatalog      = lt_fieldcat.

  endmethod.

  method build_fieldcatalog.
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
    rs_layout-sel_mode    = 'A'.         " User can select the lines
    rs_layout-zebra       = 'X'.         " Zebra display
    rs_layout-cwidth_opt  = 'X'.         " Optimization of columns width
    rs_layout-ctab_fname  = 'COLORCELL'. " Cells coloring
  endmethod.

  method exclude_buttons.
    data: ls_excluding like line of rt_excluding.

    add_exclude cl_gui_alv_grid=>mc_fc_graph.
    add_exclude cl_gui_alv_grid=>mc_fc_info.
    add_exclude cl_gui_alv_grid=>mc_fc_loc_copy.
    add_exclude cl_gui_alv_grid=>mc_fc_loc_copy_row.
    add_exclude cl_gui_alv_grid=>mc_fc_loc_cut.
    add_exclude cl_gui_alv_grid=>mc_fc_loc_delete_row.
    add_exclude cl_gui_alv_grid=>mc_fc_loc_insert_row.
    add_exclude cl_gui_alv_grid=>mc_fc_loc_move_row.
    add_exclude cl_gui_alv_grid=>mc_fc_loc_paste.
    add_exclude cl_gui_alv_grid=>mc_fc_loc_undo.
    add_exclude cl_gui_alv_grid=>mc_fc_loc_paste_new_row.
    add_exclude cl_gui_alv_grid=>mc_fc_loc_append_row.
    add_exclude cl_gui_alv_grid=>mc_fc_check.
    add_exclude cl_gui_alv_grid=>mc_fc_refresh.
  endmethod.

  method get_selected_lines.
    data:
      lt_rows type lvc_t_row,
      ls_row  type lvc_s_row,
      ls_line like line of rt_lines.

    field-symbols:
      <xml_files> type standard table,
      <xml_file>  type j_1ufdi_file_tbl.

    call method me->get_selected_rows
      importing
        et_index_rows = lt_rows.

    if lines( lt_rows ) is initial.
      return.
    endif.

    assign me->mt_outtab->* to <xml_files>.

    loop at lt_rows into ls_row.
      read table <xml_files> assigning <xml_file> index ls_row-index.
      check sy-subrc is initial.
      move-corresponding <xml_file> to ls_line.
      append ls_line to rt_lines.
    endloop.
  endmethod.
endclass.
