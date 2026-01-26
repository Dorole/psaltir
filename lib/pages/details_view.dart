import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:psaltir/providers/reading_provider.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: SingleChildScrollView(child: _detailsText()),
    );
  }

  Widget _detailsText() {
    return Consumer<ReadingProvider>(
      builder: (_, reading, _) {
        return FutureBuilder<String>(
          future: reading.detailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError || snapshot.data!.isEmpty) {
              return const Text(
                "Nema detalja, a trebalo bi biti.",
                style: TextStyle(color: Colors.red),
              );
            }
            return Text(snapshot.data!, textAlign: TextAlign.justify);
          },
        );
      },
    );
  }
}
