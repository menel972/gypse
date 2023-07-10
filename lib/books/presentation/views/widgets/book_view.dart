import 'package:flutter/material.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BookView extends HookConsumerWidget {
  const BookView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.s(context).height,
        left: Dimensions.xs(context).width,
        right: Dimensions.xs(context).width,
      ),
      child: Column(
        children: [
          SearchBar(
            hintText: 'Livre...',
            trailing: [
              Icon(Icons.search_outlined,
                  color: Theme.of(context).colorScheme.onPrimary)
            ],
          ),
        ],
      ),
    );
  }
}
