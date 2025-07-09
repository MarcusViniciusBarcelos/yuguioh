import 'package:ap2/firebase_options.dart';
import 'package:ap2/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'screens/list_screen.dart';
import 'screens/search_screen.dart';
import 'theme.dart';
import 'widgets/yugi_background.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const YGOApp());
}

class YGOApp extends StatelessWidget {
  const YGOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YGOPRODeck Browser',
      theme: YugiTheme.light(),
      home: const _AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return snapshot.hasData ? const HomeTabs() : const LoginPage();
      },
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
          actions: [
            IconButton(
              tooltip: 'Logout',
              icon: const Icon(Icons.logout),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
          ],
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