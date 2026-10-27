import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const KartHouseApp());
}

class KartHouseApp extends StatelessWidget {
  const KartHouseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kart House',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF222222),
        ),
        useMaterial3: true,
      ),
      home: const KartHouseHome(),
    );
  }
}

class KartHouseHome extends StatefulWidget {
  const KartHouseHome({super.key});

  @override
  State<KartHouseHome> createState() => _KartHouseHomeState();
}

class _KartHouseHomeState extends State<KartHouseHome> {
  late final WebViewController controller;
  int progress = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (value) {
            if (mounted) {
              setState(() => progress = value);
            }
          },
          onPageFinished: (_) {
            if (mounted) {
              setState(() => progress = 100);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse('https://kart.house/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (progress < 100)
              LinearProgressIndicator(
                value: progress / 100,
                minHeight: 2,
              ),
            Expanded(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
