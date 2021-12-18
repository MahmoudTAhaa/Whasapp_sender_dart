import 'package:gsheets/gsheets.dart';
import 'package:puppeteer/puppeteer.dart';
///Get Credentials for Google Spreadsheet by visiting "https://console.cloud.google.com/apis/credentials" and create one.
//Todo: add credentials
const _credentials = r'''
{
  "type": "",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": ""
}
''';
/// the spreadsheetId where the number is existed(you put it by yourself using GoogleSheer).
/// Todo: add the spreadsheetId
const _spreadsheetId = 'add your spreadsheet id';
/// launching the browser and make open page(from here you won't let the automation complete your work).
Future<List<Page>> launchTheBrowser() async {
  var browser = await puppeteer.launch(
    headless: false,
    slowMo: Duration(milliseconds: 8),
    devTools: false,
    defaultViewport: null,
  );
  List<Page> pages = await browser.pages;
  return pages;
}
/// get the numbers from GoogleSheet( which you already insert its ID).
Future<List<String>> getNumbers() async {
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  var sheet = ss.worksheetByTitle('numbers');
  sheet ??= await ss.addWorksheet('numbers');
  ///Note: it takes the numbers from the second column
  List<String> numbers = await sheet.values.column(2);
  return numbers;
}
/// get the message from GoogleSheet( which you already insert its ID).
Future<List<String>> getMessages() async {
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  var sheet = ss.worksheetByTitle('numbers');
  sheet ??= await ss.addWorksheet('numbers');
  List<String> messages = await sheet.values.column(3);
  return messages;
}
///After signing to whatsapp the program will search about 'the search box' to search about the number that you will use then press the enter button.
Future<void> searchForTheNumber(Page page, String number) async {
  //Constants:
  String searchSelector =
      "#side > div.uwk68 > div > label > div > div._13NKt.copyable-text.selectable-text";
  //The Function Body
  await page.waitForSelector(searchSelector, timeout: Duration(minutes: 15));
  await page.click(searchSelector);
  await page.type(searchSelector, number);
  await Future<dynamic>.delayed(Duration(seconds: 3));
  await page.keyboard.press(Key.enter);
  print('I clicked the chat!');
}
///After searching about the number then it will select the message box selector and then will write the messge and send it.
Future<void> wrigingTheMessageAndSendIt(Page page, String message) async {
  //Constants
  String messageBoxSelector =
      "#main > footer > div._2BU3P.tm2tP.copyable-area > div > span:nth-child(2) > div > div._2lMWa > div.p3_M1 > div > div._13NKt.copyable-text.selectable-text";
  //The function body
  await page.waitForSelector(messageBoxSelector);
  await page.click(messageBoxSelector);
  await page.type(messageBoxSelector, message);
  await page.keyboard.press(Key.enter);
}