import 'package:flutter/material.dart';
import '../screens/detail_screen.dart';
import '../theme.dart';

class CardTile extends StatelessWidget {
  final Map<String, dynamic> cardJson;
  const CardTile({super.key, required this.cardJson});

  @override
  Widget build(BuildContext context) {
    final imgUrl = cardJson['card_images'][0]['image_url_small'];
    return Card(
      elevation: 3,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Theme.of(context).cardTheme.color,
        leading: Hero(
          tag: cardJson['id'],
          child: Image.network(imgUrl, width: 60, fit: BoxFit.cover),
        ),
        title: Text(cardJson['name'],
            style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(cardJson['type']),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CardDetailScreen(cardJson: cardJson),
          ),
        ),
      ),
    );
  }
}