part of '../recap_multi_screen.dart';

class RecapMultiScores extends StatelessWidget {
  const RecapMultiScores({super.key});

  @override
  Widget build(BuildContext context) {
    return GypseContainer(
      context,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text(
                  '3',
                  style: GypseFont.xs(bold: true),
                ),
                Dimensions.xxxs(context).spaceH(),
                const Text(
                  'Victoires',
                  style: GypseFont.xs(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  '1',
                  style: GypseFont.xs(bold: true),
                ),
                Dimensions.xxxs(context).spaceH(),
                const Text(
                  'Egalités',
                  style: GypseFont.xs(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  '2',
                  style: GypseFont.xs(bold: true),
                ),
                Dimensions.xxxs(context).spaceH(),
                const Text(
                  'Défaites',
                  style: GypseFont.xs(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
