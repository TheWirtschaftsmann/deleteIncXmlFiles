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
  go_controller->handle_user_action( ok_code ).
endmodule.
