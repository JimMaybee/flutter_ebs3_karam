import 'package:xml/xml.dart';

List loadTestData(
    String sheetID, String tabName, List<List<String>> sheetArray) {
  var sectionType = ""; // Will be Data or XML.

  //Database variables
  var sheetRow = sheetArray[0];
  var database = {};
  var tableRow = {};
  var iRow = 0;
  var tableName = "";
  var attributes = [];

  // XML Template variales
  var xmlTemplate = {}; // Contains all XML templates
  var xmlTemplateName = "";
  var xmlTemplateCellAsArray = [];
  var xmlParsed = {};
  var xmlLine;
  var document;

  while (sheetRow[0].length > 0) {
    if (sheetRow[0].endsWith("ID")) {
      // Data section start
      sectionType = "Data";
      tableName =
          sheetRow[0].substring(0, sheetRow[0].length - 2).toLowerCase() + "s";
      attributes = sheetRow;
      database[tableName] = [];
    } else if (sheetRow[0].endsWith("XML")) {
      // XML section start
      sectionType = "XML";
      xmlTemplateName =
          sheetRow[0].substring(0, sheetRow[0].length - 3).toLowerCase() + "s";
    } else if (sectionType == "Data") {
      // Data row for the database section
      tableRow = {};
      var iSheetCol = 0;
      for (var attr in attributes) {
        tableRow[attr] = sheetRow[iSheetCol++];
      }
      database[tableName].add(new Map.from(tableRow));
    } else if (sectionType == "XML") {
      // Data row for the XML Template
      xmlTemplateCellAsArray = sheetRow[0].split("\n");

      xmlTemplateCellAsArray.forEach((element) {
        //  <MoveDown distance="1" />   ===>  {action:"MoveDown", distance:1}
        // Can we have int value.  String only is okay for now.
        // Test the XML parser against the document.  Suspected fail with multiple MoveDowns.
        // Do we need to only parse single XML directives??
        document = XmlDocument.parse(element);
        xmlLine = document.firstChild; // Replace with parsing

        xmlParsed['action'] = xmlLine.name.local;
        xmlLine.attributes.forEach((element) {
          xmlParsed[element.name.local] = element.value;
        });

        xmlTemplate[xmlTemplateName] = (new Map.from(xmlParsed));
        sectionType = "None";
      });
    } else if (sectionType == "None") {
      // Alert("Missing section start line - Row ignored.");
    }
    if (iRow + 1 < sheetArray.length)
      sheetRow = sheetArray[iRow++];
    else
      break;
  }

  return [database, xmlTemplate];
}
