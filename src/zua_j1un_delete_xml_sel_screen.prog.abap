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
