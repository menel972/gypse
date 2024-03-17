// ignore_for_file: must_be_immutable

part of '../home_screen.dart';

/// A navigation bar at the bottom of [HomeScreen]
///
/// HomeNavigationBar allows user to navigate between [HomeView], [ChartsView] and [AccountView]
class HomeNavigationBar extends HookConsumerWidget {
  final WidgetRef ref;
  HomeNavigationBar(this.ref, {super.key});

  late int navigationIndex;
  late bool anonymous;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    navigationIndex = ref.watch(homeNavigationStateProvider);
    anonymous = ref.watch(userProvider)?.isAnonymous ?? false;

    updatePage(int index) =>
        ref.read(homeNavigationStateProvider.notifier).updatePage(index);

    return Material(
      child: BottomNavigationBar(
        currentIndex: navigationIndex,
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                icon: SvgPicture.asset(
                  GypseIcon.home.path,
                  semanticsLabel: "Séléctionner Accueil onglet 1 sur 3",
                  colorFilter: ColorFilter.mode(
                      navigationIndex != 0
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      BlendMode.srcIn),
                  height: navigationIndex != 0
                      ? Dimensions.iconS(context).height
                      : Dimensions.iconM(context).height,
                ),
                onPressed: () {
                  ref.read(logNavigationUseCaseProvider).invoke(
                        from: Screen.homeView.path,
                        to: Screen.homeView.path,
                        details: 'Accueil',
                      );
                  updatePage(0);
                },
                splashRadius: 20,
                splashColor: Theme.of(context).colorScheme.secondary,
              ),
              label: 'Accueil'),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: SvgPicture.asset(
                  GypseIcon.stats.path,
                  semanticsLabel: "Séléctionner Scores onglet 2 sur 3",
                  colorFilter: ColorFilter.mode(
                      navigationIndex != 1
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      BlendMode.srcIn),
                  height: navigationIndex != 1
                      ? Dimensions.iconS(context).height
                      : Dimensions.iconM(context).height,
                ),
                onPressed: () {
                  if (anonymous) {
                    GypseDialog(
                      context,
                      child: const AnonymousDenied('L\'affichage des scores'),
                    );
                    return;
                  }

                  ref.read(logNavigationUseCaseProvider).invoke(
                        from: Screen.homeView.path,
                        to: Screen.homeView.path,
                        details: 'scores',
                      );
                  updatePage(1);
                },
                splashRadius: 20,
                splashColor: Theme.of(context).colorScheme.secondary,
              ),
              label: 'Scores'),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: SvgPicture.asset(
                  GypseIcon.trophy.path,
                  semanticsLabel: "Récompenses onglet 3 sur 3",
                  colorFilter: ColorFilter.mode(
                      navigationIndex != 2
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                      BlendMode.srcIn),
                  height: navigationIndex != 2
                      ? Dimensions.iconS(context).height
                      : Dimensions.iconM(context).height,
                ),
                onPressed: () {
                  ref.read(logNavigationUseCaseProvider).invoke(
                        from: Screen.homeView.path,
                        to: Screen.homeView.path,
                        details: 'awards',
                      );
                  Achievements.showAchievements();
                },
                splashRadius: 20,
                splashColor: Theme.of(context).colorScheme.secondary,
              ),
              label: 'Récompenses'),
        ],
      ),
    );
  }
}
