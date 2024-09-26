import 'package:flutter/material.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SubscriptionPaymentWebView extends StatelessWidget {
  final String url;

  SubscriptionPaymentWebView({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: 'Payment'),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
