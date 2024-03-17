part of '../tutorial_screen.dart';

class TutorialView extends StatelessWidget {
  const TutorialView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TutorialCubit, TutorialState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Dimensions.m(context).spaceH(),
            Expanded(
              child: SvgPicture.asset(
                alignment: Alignment.topCenter,
                TutorialCubit.tutos[state.index],
                width: Dimensions.screen(context).width,
              ),
            ),
            Dimensions.xs(context).paddingW(
              Text(
                TutorialCubit.titles[state.index],
                style: const GypseFont.xxl(bold: true),
              ),
            ),
            Dimensions.xxxs(context).spaceH(),
            Dimensions.xs(context).paddingW(
              Text(
                TutorialCubit.subtitles[state.index],
                style: const GypseFont.m(),
              ),
            ),
            SizedBox(
              height: Dimensions.screen(context).height * 0.13,
            ),
          ],
        );
      },
    );
  }
}
