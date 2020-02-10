*&---------------------------------------------------------------------*
*&  Include: ZUA_J1UN_DELETE_XML_CONTROLLER
*&---------------------------------------------------------------------*

data: ok_code type sy-ucomm.

class lcl_app definition final.
  public section.

    types:
      ty_bukrs_range type range of bukrs,
      ty_gjahr_range type range of gjahr,
      ty_stcd1_range type range of stcd1,
      ty_xblnr_range type range of j_1ufdi_taxdoc_num.

    types:
      begin of ty_selopts,
        bukrs type ty_bukrs_range,
        gjahr type ty_gjahr_range,
        stcd1 type ty_stcd1_range,
        xblnr type ty_xblnr_range,
      end of ty_selopts.

    methods run
      importing
        is_selopts type ty_selopts.

endclass.                    "lcl_app definition

*----------------------------------------------------------------------*
*       CLASS lcl_app IMPLEMENTATION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class lcl_app implementation.

  method run.

    data:
      lo_view type ref to zua_j1un_xml_alv_viewer,
      lt_data type zua_j1un_xml_selector=>ty_tt_data.

    lt_data = zua_j1un_xml_selector=>select_xml_files(
      ir_bukrs = is_selopts-bukrs
      ir_gjahr = is_selopts-gjahr
      ir_stcd1 = is_selopts-stcd1
      ir_xblnr = is_selopts-xblnr ).

    create object lo_view
      exporting
        it_data = lt_data.

    lo_view->display_report( ).

  endmethod.

  endclass.                    "lcl_app implementation
*&---------------------------------------------------------------------*
*&      Module  HANDLE_PAI  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*

class lcl_controller definition.
  " Delete
  public section.

    methods: set_gui_status.

    methods: process_before_output
                importing
                  i_container type ref to cl_gui_custom_container.

    methods: user_command
                importing
                  i_ucomm type sy-ucomm.

endclass.

class lcl_controller implementation.

  method set_gui_status.
    set titlebar  'GUI_TITLE' with text-100.
    set pf-status 'MAIN_STATUS'.
  endmethod.

  method process_before_output.

  endmethod.

  method user_command.

  endmethod.
endclass.

module handle_pai input.
" Refactoring: adjust command codes, once new container will be ready

  case ok_code.
    when 'E' or 'ECAN'.   " Adjust to 'BACK' or 'EXIT'
      leave to screen 0.
    when 'ENDE'.          " Adjust to 'CANCEL'
      leave program .
  endcase.

endmodule.                " handle_pai  input
