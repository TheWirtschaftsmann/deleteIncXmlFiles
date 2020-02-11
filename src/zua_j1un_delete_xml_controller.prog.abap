*&---------------------------------------------------------------------*
*&  Include: ZUA_J1UN_DELETE_XML_CONTROLLER
*&---------------------------------------------------------------------*
class lcl_controller definition.
  public section.
    methods: constructor importing is_selopts type ty_selopts.
    methods: set_gui_status.
    methods: process_before_output
                importing
                  i_container type ref to cl_gui_custom_container.
  private section.
    data: as_selopts   type ty_selopts,
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
   data: lo_view type ref to zua_j1un_xml_alv_viewer.

    at_xml_files = zua_j1un_xml_selector=>select_xml_files(
      ir_bukrs = as_selopts-bukrs
      ir_gjahr = as_selopts-gjahr
      ir_stcd1 = as_selopts-stcd1
      ir_xblnr = as_selopts-xblnr ).

    create object lo_view
      exporting
        it_data = at_xml_files.

    lo_view->display_report( ).

  endmethod.

endclass.
