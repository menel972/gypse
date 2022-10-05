import 'package:flutter/material.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';

/// Search bar
///
/// SearchBarView allows user to filter books
class SearchBarView extends StatelessWidget {
  final Function(String) setFilter;
  const SearchBarView(this.setFilter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: screenSize(context).height * 0.01),
      child: TextFormField(
        style: const TextL(Couleur.text),
        decoration: InputDecoration(
          labelText: '${words(context).title_book}...',
          suffixIcon: const Icon(Icons.search_outlined, color: Couleur.text),
        ),
        onChanged: (value) => setFilter(value),
      ),
    );
  }
}
