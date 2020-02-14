*&---------------------------------------------------------------------*
*&  Include for selection screen elements
*&---------------------------------------------------------------------*
tables: j_1ufdi_match_xml_document.

selection-screen begin of block b1 with frame title text-001.
select-options:
  s_bukrs for j_1ufdi_match_xml_document-bukrs obligatory,
  s_gjahr for j_1ufdi_match_xml_document-gjahr obligatory,
  s_stcd1 for j_1ufdi_match_xml_document-xml_seller_inn.
selection-screen end of block b1.

selection-screen begin of block b2 with frame title text-002.
select-options:
  s_xblnr for j_1ufdi_match_xml_document-xml_xblnr.
selection-screen end of block b2.

form check_auth.

    constants: lc_display type char40 value '03'.

    data:
      lt_bukrs   type table of bukrs,
      ls_bukrs   like line of lt_bukrs,
      lv_bukrs   type char40.

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

      if sy-subrc = 2. "if sy-subrc <> 2.
        message 'User is not authorized' type 'I' display like 'E'.
      endif.
    endloop.

endform.
