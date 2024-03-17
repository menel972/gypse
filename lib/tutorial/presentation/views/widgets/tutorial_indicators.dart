// ignore_for_file: must_be_immutable

part of '../tutorial_screen.dart';

class TutorialIndicators extends HookConsumerWidget {
  TutorialIndicators({super.key});
  late bool newAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    newAccount = ref.watch(initStateNotifierProvider);

    return BlocBuilder<TutorialCubit, TutorialState>(
      builder: (context, state) {
        return SafeArea(
          child: Dimensions.xs(context).padding(
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  splashColor: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(5),
                  onTap: () {
                    if (newAccount) {
                      ref
                          .read(initStateNotifierProvider.notifier)
                          .switchLoginMethod();
                      context.go(Screen.homeView.path);
                    } else {
                      context.go(Screen.homeView.path);
                    }
                  },
                  child: Text(
                    'Passer',
                    style: GypseFont.m(
                      bold: true,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: Dimensions.xxxs(context).width,
                  children: [
                    if (state.index == TutorialCubit.tutos.length - 1)
                      ElevatedButton(
                        onPressed: () {
                          if (newAccount) {
                            ref
                                .read(initStateNotifierProvider.notifier)
                                .switchLoginMethod();
                            Future(() => context.go(Screen.homeView.path));
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  Theme.of(context).colorScheme.secondary),
                          side: MaterialStateBorderSide.resolveWith((states) =>
                              BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary)),
                          shape: MaterialStateProperty.resolveWith(
                            (_) => RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        child: Text(
                          newAccount ? 'Commencer' : 'Retour',
                          style: const GypseFont.s(),
                        ),
                      )
                    else
                      for (int i = 0; i < TutorialCubit.tutos.length; i++)
                        Container(
                          height: Dimensions.xxs(context).width,
                          width: i == state.index
                              ? Dimensions.xs(context).width
                              : Dimensions.xxs(context).width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: i == state.index
                                ? Theme.of(context).colorScheme.secondary
                                : Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
