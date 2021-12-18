import 'package:puppeteer/puppeteer.dart';
import 'package:dart/functions.dart';
void main(List<String> args) async {
  List<String> numbers = await getNumbers();
  List<String> messages = await getMessages();
  List<Page> pages = await launchTheBrowser();
  Page page = pages[0];
  await page.goto('https://web.whatsapp.com/');
  await Future<dynamic>.delayed(Duration(seconds: 20));
  for (var i = 0; i < numbers.length; i++) {
    await searchForTheNumber(page, numbers[i]);
    Future<dynamic>.delayed(Duration(seconds: 1));
    await wrigingTheMessageAndSendIt(page, messages[i]);
  }
}

//©️ copyright saved for: Mahmoud Taha
// 01146249247