import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key, required this.url, required this.moduleName})
      : super(key: key);
  final String moduleName;
  final String url;
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  final String url = 'https://example.com'; // Replace with your desired URL

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.white,
        title: Text(
          widget.moduleName,
          style: TextStyle(
              color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_rounded,
            size: 40,
            color: Colors.grey,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted, // Enable JavaScript
      ),
    );
  }
}
