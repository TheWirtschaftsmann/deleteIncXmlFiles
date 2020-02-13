*&---------------------------------------------------------------------*
*&  Include for controller
*&---------------------------------------------------------------------*
class lcl_controller definition.
  public section.
    methods: constructor           importing is_selopts   type ty_selopts.
    methods: process_before_output importing iv_container type ref to cl_gui_custom_container.
    methods: handle_user_action    importing iv_ucomm     type sy-ucomm.
    methods: set_gui_status.

  private section.
    data:
          o_view       type ref to lcl_view,
          as_selopts   type ty_selopts,
          at_xml_files type zua_j1un_xml_selector=>ty_tt_data.
    methods: delete_xml_files.
endclass.

class lcl_controller implementation.
  method constructor.
    as_selopts = is_selopts.
  endmethod.

  method set_gui_status.
    set titlebar  'GUI_TITLE' with text-100.
    set pf-status 'MAIN_STATUS'.
  endmethod.

  method process_before_output.
    at_xml_files = zua_j1un_xml_selector=>select_xml_files(
      ir_bukrs = as_selopts-bukrs
      ir_gjahr = as_selopts-gjahr
      ir_stcd1 = as_selopts-stcd1
      ir_xblnr = as_selopts-xblnr ).

    create object me->o_view
      exporting
        iv_parent = iv_container.

    me->o_view->setup_alv( changing ct_data = at_xml_files ).
  endmethod.

  method handle_user_action.
    case ok_code.
      when 'BACK' or 'EXIT'.
        leave to screen 0.
      when 'DELETE'.
        delete_xml_files( ).
      when 'CANCEL'.
        leave program .
    endcase.
  endmethod.

  method delete_xml_files.
    data:
        lo_exception type ref to j_1ucx_di_processing_error,
        lv_err_msg   type string,
        lt_xml_files type zua_j1un_xml_selector=>ty_tt_data,
        ls_file_key  type j_1ufdi_file_key.

    field-symbols: <file> type j_1ufdi_file_tbl.

    lt_xml_files = me->o_view->get_selected_lines( ).

    if lines( lt_xml_files ) > 0.
      loop at lt_xml_files assigning <file>.
        clear: ls_file_key.

        ls_file_key-bukrs = <file>-bukrs.
        ls_file_key-num   = <file>-num.
        ls_file_key-gjahr = <file>-gjahr.

        try.
          j_1ucl_di_files=>delete_file( ls_file_key ).
          catch j_1ucx_di_processing_error into lo_exception.
            lv_err_msg = lo_exception->get_text( ).
            exit.
            " Issue a message
        endtry.
      endloop.
    else.
      " Issue warning message
    endif.

  endmethod.
endclass.
