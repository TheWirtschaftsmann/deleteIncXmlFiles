*&---------------------------------------------------------------------*
*&  Definition of common types
*&---------------------------------------------------------------------*
  class lcl_controller definition deferred.

  data: ok_code       type sy-ucomm,
        go_controller type ref to lcl_controller.

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

   types: ty_tt_files type standard table of j_1ufdi_file_tbl with default key.
