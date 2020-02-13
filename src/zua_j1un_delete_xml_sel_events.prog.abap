*&---------------------------------------------------------------------*
*&  Include: ZUA_J1UN_DELETE_XML_SEL_EVENTS
*&---------------------------------------------------------------------*
module status_100 output.
  data:
    lv_cont_name type scrfname value 'MAINCONTAINER',
    lv_cust_cont type ref to cl_gui_custom_container.

    go_controller->set_gui_status( ).

    if lv_cust_cont is initial.
      create object lv_cust_cont exporting container_name = lv_cont_name.
      go_controller->process_before_output( iv_container = lv_cust_cont ).
    endif.
endmodule.

module handle_pai input.
  data: lt_files type zua_j1un_xml_selector=>ty_tt_data. " TODO - refactor

  case ok_code.
    when 'BACK' or 'EXIT'.
      leave to screen 0.
    when 'DELETE'.
*      lt_files = lo_controller->mo_view->get_selected_lines( ).
    when 'CANCEL'.
      leave program .
  endcase.
endmodule.
