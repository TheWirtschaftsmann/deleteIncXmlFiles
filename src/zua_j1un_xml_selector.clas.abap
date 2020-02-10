*----------------------------------------------------------------------*
*       CLASS ZUA_J1UN_XML_SELECTOR DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class ZUA_J1UN_XML_SELECTOR definition
  public
  final
  create public .

public section.

  types:
    r_bukrs type range of bukrs .
  types:
    r_gjahr type range of gjahr .
  types:
    r_stcd1 type range of stcd1 .
  types:
    r_xblnr type range of j_1ufdi_taxdoc_num .
  types:
    ty_tt_data type standard table of j_1ufdi_file_tbl with default key .

  class-methods SELECT_XML_FILES
    importing
      !IR_BUKRS type R_BUKRS
      !IR_GJAHR type R_GJAHR
      !IR_STCD1 type R_STCD1
      !IR_XBLNR type R_XBLNR
    returning
      value(RT_DATA) type ty_tt_data .
  protected section.
  private section.
ENDCLASS.



CLASS ZUA_J1UN_XML_SELECTOR IMPLEMENTATION.


method select_xml_files.

  select *
    from j_1ufdi_file_tbl
    into corresponding fields of table rt_data
    where bukrs in ir_bukrs
      and gjahr in ir_gjahr
      and xml_seller_inn in ir_stcd1
      and xml_xblnr in ir_xblnr
      and belnr_fi = ''
      and direction = j1udi_dxd_direction_in
      and ( doc_type = j1udi_typ_taxinv
       or doc_type = j1udi_typ_taxcorr ).

endmethod.                    "select_xml_files
ENDCLASS.
