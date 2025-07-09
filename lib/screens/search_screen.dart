import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/card_tile.dart';
import '../widgets/yugi_background.dart';

class CardSearchScreen extends StatefulWidget {
  const CardSearchScreen({super.key});

  @override
  State<CardSearchScreen> createState() => _CardSearchScreenState();
}

class _CardSearchScreenState extends State<CardSearchScreen> {
  final _controller = TextEditingController();

  List<dynamic> _cards = [];
  bool _loading = false;
  String? _error;

  Future<void> _doSearch(String query) async {
    query = query.trim();
    if (query.isEmpty) {
      setState(() {
        _cards = [];
        _error = null;
      });
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final uri = Uri.https('db.ygoprodeck.com', '/api/v7/cardinfo.php', {
        'fname': query,
        'num': '50',
        'offset': '0',
      });
      final res = await http.get(uri);

      if (res.statusCode != 200) {
        throw Exception('Erro ${res.statusCode}');
      }

      final map = jsonDecode(res.body) as Map<String, dynamic>;

      setState(() {
        _cards = map.containsKey('error') ? [] : map['data'] as List<dynamic>;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Digite parte do nome…',
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => _doSearch(_controller.text),
              ),
            ),
            onSubmitted: _doSearch,
          ),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text('Erro: $_error'))
              : _cards.isEmpty
              ? const Center(
              child: Text('Nenhum resultado encontrado.'))
              : ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: _cards.length,
            separatorBuilder: (_, __) =>
            const SizedBox(height: 8),
            itemBuilder: (context, index) => CardTile(
                cardJson:
                _cards[index] as Map<String, dynamic>),
          ),
        ),
      ],
    );
  }
}
