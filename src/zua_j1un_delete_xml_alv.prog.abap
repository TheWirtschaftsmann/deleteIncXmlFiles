*&---------------------------------------------------------------------*
*&  Include for ALV-based routines
*&---------------------------------------------------------------------*
module status_100 output.
  data:
    lv_cont_name type scrfname value 'MAINCONTAINER',
    lv_cust_cont type ref to cl_gui_custom_container.

  lo_controller->set_gui_status( ).

  if lv_cust_cont is initial.
    create object lv_cust_cont exporting container_name = lv_cont_name.
    lo_controller->process_before_output( i_container = lv_cust_cont ).
  endif.
endmodule.

module handle_pai input.
  case ok_code.
    when 'BACK' or 'EXIT'.
      leave to screen 0.
    when 'CANCEL'.
      leave program .
  endcase.
endmodule.
