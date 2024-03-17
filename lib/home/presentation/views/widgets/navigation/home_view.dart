part of '../../home_screen.dart';

class HomeView extends HookConsumerWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(logDisplayUseCaseProvider)
        .invoke(screen: Screen.homeView.path, details: 'Home');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: CarouselView()),
        Dimensions.xs(context).paddingW(
          GypseButton.orange(
            context,
            onPressed: () {
              context.go('${Screen.hubView.path}/${GameMode.solo.name}');
            },
            label: 'Solo',
          ),
        ),
        Dimensions.xxs(context).spaceH(),
        Dimensions.xs(context).paddingW(
          GypseButton.outlined(
            context,
            onPressed: () {
              context.go('${Screen.hubView.path}/${GameMode.multi.name}');
            },
            label: 'Multijoueur',
          ),
        ),
        Dimensions.xs(context).spaceH(),
      ],
    );
  }
}
