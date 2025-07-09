import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/card_tile.dart';
import '../widgets/yugi_background.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  late Future<List<dynamic>> _cards;

  @override
  void initState() {
    super.initState();
    _cards = fetchCards();
  }

  Future<List<dynamic>> fetchCards() async {
    final uri = Uri.parse(
        'https://db.ygoprodeck.com/api/v7/cardinfo.php?num=50&offset=0');
    final res = await http.get(uri);
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    return json['data'] as List<dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _cards,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final cards = snapshot.data!;
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: cards.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) => CardTile(
              cardJson: cards[index] as Map<String, dynamic>),
        );
      },
    );
  }
}
