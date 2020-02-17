# Deletion of unnecessary incoming XML-files

### Synopsis

This program is supplementing standard functionalities of Ukrainian VAT add-on in SAP. The purpose behind this program is to delete unnecessary XML-files for incoming tax documents i.e. *tax invoice* and *tax correction invoice*. 

XML-files for above mentioned tax documents are being uploaded to SAP as part of electronic VAT administration process. The idea is as follows: 

- XML-files for tax documents should be uploaded via t-code *J1UFDIPROCIN* and automatically linked to respective accounting documents updating their references (i.e. *BKPF-XBLNR*);
- If the system fails to link XML-files against accounting documents automatically, the user is supposed to match these entities manually in t-code *J1UFMATCHING*.

However not all XML-files are necessary for matching e.g. XML-files for zero tax correction invoices. The number of these unnecessary XML-files increases as times passes by, cluttering the system and distracting the users.

### Technical notes

Some technical notes:

- The program is selecting XML-files from table *J_1UFDI_FILE_TBL*, which have no link to accounting documents and deletes them;
- The files are deleted via standard static method *J_1UCL_DI_FILES=>DELETE_FILE()* from Ukrainian localization;
- T-code ZUA_J1UN_DELETE_XML can be used to display the report.

### Selection screen

Selection screen allows filtering of values based on company code, fiscal year and tax payer number i.e. tax number 1 (*INN*) of vendor *LFA1-STCD1*. Additionally, you can filter the values based on tax document number.

![](https://github.com/TheWirtschaftsmann/deleteIncXmlFiles/blob/master/screens/00_selection_screen.jpg)

### Display of report values

The report displays all attributes of XML-files from table *J_1UFDI_FILE_TBL*. You can select several XML-files and delete them:

![](C:\GIT\deleteIncXmlFiles\screens\01_report_values.jpg)
