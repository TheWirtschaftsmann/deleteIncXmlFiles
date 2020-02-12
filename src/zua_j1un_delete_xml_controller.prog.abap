*&---------------------------------------------------------------------*
*&  Include: ZUA_J1UN_DELETE_XML_CONTROLLER
*&---------------------------------------------------------------------*
class lcl_controller definition.
  public section.
    methods: constructor           importing is_selopts type ty_selopts.
    methods: process_before_output importing iv_container type ref to cl_gui_custom_container.
    methods: handle_user_action    importing iv_ucomm     type sy-ucomm.
    methods: set_gui_status.

  private section.
    data:
          o_view       type ref to lcl_view,
          as_selopts   type ty_selopts,
          at_xml_files type zua_j1un_xml_selector=>ty_tt_data.
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
    data: lt_files type zua_j1un_xml_selector=>ty_tt_data.

    case iv_ucomm.
      when 'DELETE'.
        "lt_files = mo_view->get_selected_lines( ).
      when others.
        " Do nothing. Add handling of other user actions here
    endcase.
  endmethod.

endclass.
