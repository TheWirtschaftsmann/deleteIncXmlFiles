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
          o_files      type ref to lcl_xml_files,
          as_selopts   type ty_selopts,
          at_xml_files type ty_tt_files.
    methods: delete_xml_files.
    methods: update_list_of_xml_files.
    methods: validate_selected_lines_delete returning value(rv_yes) type abap_bool.
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

    create object me->o_files
      exporting is_selopts = as_selopts.

    at_xml_files = me->o_files->select_files( ).

    create object me->o_view
      exporting
        iv_parent = iv_container.

    me->o_view->setup_alv( changing ct_data = at_xml_files ).
  endmethod.

  method handle_user_action.
    case ok_code.
      when 'DELETE'.
        me->delete_xml_files( ).
      when others.
        " Do nothing, reserved for future use
    endcase.
  endmethod.

  method delete_xml_files.
    data:
        lo_exception type ref to j_1ucx_di_processing_error,
        lv_err_msg   type string,
        lt_xml_files type ty_tt_files,
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

      " Validate deletion of XML-files
      if me->validate_selected_lines_delete( ) = abap_false.
        return.
      else.
        me->o_files->delete_files( lt_xml_files ).
        me->update_list_of_xml_files( ).
        me->o_view->refresh_alv( ).
      endif.
    else.
      " Issue warning message
    endif.

  endmethod.

  method update_list_of_xml_files.

    data: ls_xml_file like line of at_xml_files.
    clear: me->at_xml_files.

    loop at o_files->at_xml_files[] into ls_xml_file.
      append ls_xml_file to me->at_xml_files.
    endloop.
  endmethod.

  method validate_selected_lines_delete.
    data:
      lv_answer  type char1,
      lv_message type string.

    rv_yes     = abap_true.
    lv_message = text-201.

    call function 'POPUP_TO_CONFIRM'
      exporting
        titlebar              = text-200
        text_question         = lv_message
        text_button_1         = text-202
        text_button_2         = text-203
        default_button        = '1'
        display_cancel_button = ''
        start_row             = 5
      importing
        answer                = lv_answer
      exceptions
        others                = 1.

    if lv_answer <> '1'.
      rv_yes = abap_false.
    endif.
  endmethod.
endclass.
