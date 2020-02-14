*&---------------------------------------------------------------------*
*&  Include for selection screen events
*&---------------------------------------------------------------------*
form auth_check.
  constants: lc_display type char40 value '03'.

  data:
    lv_auth_is_ok type abap_bool,
    lv_bukrs      type char40,
    lv_message    type string,
    lt_bukrs      type table of bukrs,
    ls_bukrs      like line of lt_bukrs.

  " User is authorized by default
  lv_auth_is_ok = abap_true.

  " Check authorization for all company codes in range
  select bukrs
    from t001
    into table lt_bukrs
    where bukrs in gs_selopt-bukrs.

  loop at lt_bukrs into ls_bukrs.
    clear: lv_bukrs.
    lv_bukrs = ls_bukrs.

    call function 'AUTHORITY_CHECK'
      exporting
        user                = sy-uname
        object              = 'F_BKPF_BUK'
        field1              = 'BUKRS'
        value1              = lv_bukrs
        field2              = 'ACTVT'
        value2              = lc_display
      exceptions
        user_dont_exist     = 1
        user_is_authorized  = 2
        user_not_authorized = 3
        user_is_locked      = 4
        others              = 5.

    if sy-subrc <> 2.
      lv_auth_is_ok = abap_false.
      exit.
    endif.
  endloop.

  if lv_auth_is_ok = abap_false.
    lv_message = text-101.
    message lv_message type 'I' display like 'E'.
    leave list-processing.
  else.
    " Continue
  endif.
endform.

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

  case ok_code.
      when 'BACK' or 'EXIT'.
        leave to screen 0.
      when 'CANCEL'.
        leave program .
    endcase.
endmodule.
