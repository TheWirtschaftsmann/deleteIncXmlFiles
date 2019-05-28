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
