import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/yugi_background.dart';
import 'fullscreen_image_screen.dart';

class CardDetailScreen extends StatelessWidget {
  final Map<String, dynamic> cardJson;
  const CardDetailScreen({super.key, required this.cardJson});

  @override
  Widget build(BuildContext context) {
    final img = cardJson['card_images'][0];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: YugiBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 16, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FullscreenImageScreen(
                        imageUrl: img['image_url'],
                        heroTag: cardJson['id'],
                      ),
                    ),
                  ),
                  child: Hero(
                    tag: cardJson['id'],
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: YugiTheme.gold, width: 3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.network(img['image_url_small'],
                          width: 180, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(cardJson['type'],
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text(cardJson['desc']),
              const Divider(height: 32),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  if (cardJson.containsKey('atk'))
                    _StatChip(label: 'ATK', value: '${cardJson['atk']}'),
                  if (cardJson.containsKey('def'))
                    _StatChip(label: 'DEF', value: '${cardJson['def']}'),
                  if (cardJson.containsKey('level'))
                    _StatChip(label: 'Nível', value: '${cardJson['level']}'),
                  if (cardJson.containsKey('attribute'))
                    _StatChip(label: 'Atributo', value: cardJson['attribute']),
                  _StatChip(label: 'Raça', value: cardJson['race']),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  const _StatChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('$label: $value'),
    );
  }
}
