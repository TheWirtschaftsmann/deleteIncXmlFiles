*&---------------------------------------------------------------------*
*&  Include: UA_J1UN_DELETE_XML_SEL_SCREEN
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

form main.

  data: ls_selopt type ty_selopts.

  ls_selopt-bukrs = s_bukrs[].
  ls_selopt-gjahr = s_gjahr[].
  ls_selopt-stcd1 = s_stcd1[].
  ls_selopt-xblnr = s_xblnr[].

  create object lo_controller exporting is_selopts = ls_selopt.

endform.
