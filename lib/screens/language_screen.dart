import 'package:flutter/material.dart';

class LanguageScreen extends StatelessWidget {
  final Function(String) onLanguageSelected;

  const LanguageScreen({super.key, required this.onLanguageSelected});

  @override
  Widget build(BuildContext context) {
    final List<String> languages = ['English', 'Spanish', 'French', 'German', 'Chinese'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Language'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(languages[index]),
            onTap: () {
              onLanguageSelected(languages[index]);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}