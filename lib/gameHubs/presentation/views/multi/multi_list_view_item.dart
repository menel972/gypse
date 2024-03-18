import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/cards.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game/presentation/models/ui_game_mode.dart';
import 'package:gypse/gameHubs/presentation/models/ui_multi_game.dart';

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  const SliverAppBarDelegate({
    required this.child,
    this.maxHeight = 50,
    this.minHeight = 50,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;
}

List<Widget> multiListViewItem(
  BuildContext context, {
  required String title,
  required List<UiMultiGame>? list,
  required StateStatus status,
}) {
  return [
    SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Text(
            title,
            style: const GypseFont.m(bold: true),
          ),
        ),
      ),
    ),
    SliverList.separated(
      separatorBuilder: (context, index) => Dimensions.xxxs(context).spaceH(),
      itemBuilder: (context, index) {
        if (status != StateStatus.success) {
          return const MultiGameCardSkeleton();
        }

        final UiMultiGame game = list![index];

        return MultiGameCard(
          mode: game.mode,
          player: game.players[1],
          onTap: () {
            if (game.hasToPlay == 'player1') {
              context.go(Screen.gameView.path,
                  extra: UiGameMode(mode: game.mode));
            } else {
              // Finish screen
            }
          },
        );
      },
      itemCount: list?.length ?? 2,
    ),
  ];
}
