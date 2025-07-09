import 'package:flutter/material.dart';
import 'screens/list_screen.dart';
import 'screens/search_screen.dart';
import 'theme.dart';
import 'widgets/yugi_background.dart';

void main() => runApp(const YGOApp());

class YGOApp extends StatelessWidget {
  const YGOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YGOPRODeck Browser',
      theme: YugiTheme.light(),
      home: const HomeTabs(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('YGOPRO Cards'),
          bottom: const TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 4, color: YugiTheme.scarlet),
            ),
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'Listagem'),
              Tab(icon: Icon(Icons.search), text: 'Busca'),
            ],
          ),
        ),
        body: YugiBackground(
          child: const TabBarView(
            children: [
              CardListScreen(),
              CardSearchScreen(),
            ],
          ),
        ),
      ),
    );
  }
}