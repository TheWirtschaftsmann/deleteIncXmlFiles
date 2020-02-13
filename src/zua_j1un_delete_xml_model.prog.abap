*&---------------------------------------------------------------------*
*&  Include: Data management routines
*&---------------------------------------------------------------------*

class lcl_xml_files definition.
  public section.
    data:
      at_xml_files type ty_tt_files,
      as_selopts   type ty_selopts.

    methods: constructor  importing is_selopts          type ty_selopts.
    methods: select_files returning value(rt_xml_files) type ty_tt_files.
    methods: delete_files importing it_xml_files        type ty_tt_files.
endclass.

class lcl_xml_files implementation.
  method constructor.
    as_selopts = is_selopts.
  endmethod.

  method select_files.
    select *
      from j_1ufdi_file_tbl
      into corresponding fields of table rt_xml_files
      where bukrs in as_selopts-bukrs
        and gjahr in as_selopts-gjahr
        and xml_seller_inn in as_selopts-stcd1
        and xml_xblnr in as_selopts-xblnr
        and belnr_fi = ''
        and direction = j1udi_dxd_direction_in
        and ( doc_type = j1udi_typ_taxinv
         or doc_type = j1udi_typ_taxcorr ).

    at_xml_files = rt_xml_files.
  endmethod.

  method delete_files.
    field-symbols: <file> like line of it_xml_files.

    loop at it_xml_files assigning <file>.
      delete me->at_xml_files where bukrs = <file>-bukrs and num = <file>-num and gjahr = <file>-gjahr.
    endloop.
  endmethod.
endclass.
