*&---------------------------------------------------------------------*
*&  Include: ZUA_J1UN_DELETE_XML_CONTROLLER
*&---------------------------------------------------------------------*

class lcl_app definition final.
  public section.

    types:
      ty_bukrs_range type range of bukrs,
      ty_gjahr_range type range of gjahr,
      ty_stcd1_range type range of stcd1.

    types:
      begin of ty_selopts,
        bukrs type ty_bukrs_range,
        gjahr type ty_gjahr_range,
        stcd1 type ty_stcd1_range,
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
      ir_stcd1 = is_selopts-stcd1 ).

    create object lo_view
      exporting
        it_data = lt_data.

    lo_view->display_report( ).

  endmethod.

  endclass.                    "lcl_app implementation
