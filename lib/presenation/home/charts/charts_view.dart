import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/enums.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/text_themes.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/gauge_datas_entity.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/presenation/home/charts/widgets/gauge_border.dart';
import 'package:gypse/presenation/home/charts/widgets/line_border.dart';
import 'package:provider/provider.dart';

/// User statistics view
///
/// ChartsView allows users to access to his personal statistics
class ChartsView extends StatelessWidget {
  const ChartsView({super.key});

  @override
  Widget build(BuildContext context) {
    GypseUser user = Provider.of<CurrentUser>(context).currentUser;

    List<AnsweredQuestion> userQuestions = user.questions.toSet().toList();

    int goodAnswers =
        userQuestions.where((question) => question.isRightAnswer).length;

    int badAnswers = userQuestions.length - goodAnswers;

    List<Map<String, dynamic>> dataTotal = [
      {'domain': 'G', 'measure': goodAnswers},
      {'domain': 'B', 'measure': badAnswers},
    ];

    // data Level 1
    int goodAnswersLvl1 = userQuestions
        .where((q) => q.isRightAnswer)
        .where((q) => q.level == Level.easy)
        .length;

    int badAnswersLvl1 = userQuestions
        .where((q) => !q.isRightAnswer)
        .where((q) => q.level == Level.easy)
        .length;

    int notLvl1 = userQuestions.length - (goodAnswersLvl1 + badAnswersLvl1);

    List<Map<String, dynamic>> dataLvl1 = [
      {'domain': 'G', 'measure': goodAnswersLvl1},
      {'domain': 'B', 'measure': badAnswersLvl1},
      {'domain': 'N', 'measure': notLvl1},
    ];

    // data Level 2
    int goodAnswersLvl2 = userQuestions
        .where((q) => q.isRightAnswer)
        .where((q) => q.level == Level.medium)
        .length;

    int badAnswersLvl2 = userQuestions
        .where((q) => !q.isRightAnswer)
        .where((q) => q.level == Level.medium)
        .length;

    int notLvl2 = userQuestions.length - (goodAnswersLvl2 + badAnswersLvl2);

    List<Map<String, dynamic>> dataLvl2 = [
      {'domain': 'G', 'measure': goodAnswersLvl2},
      {'domain': 'B', 'measure': badAnswersLvl2},
      {'domain': 'N', 'measure': notLvl2},
    ];

    // data Level 3
    int goodAnswersLvl3 = userQuestions
        .where((q) => q.isRightAnswer)
        .where((q) => q.level == Level.hard)
        .length;

    int badAnswersLvl3 = userQuestions
        .where((q) => !q.isRightAnswer)
        .where((q) => q.level == Level.hard)
        .length;

    int notLvl3 = userQuestions.length - (goodAnswersLvl3 + badAnswersLvl3);

    List<Map<String, dynamic>> dataLvl3 = [
      {'domain': 'G', 'measure': goodAnswersLvl3},
      {'domain': 'B', 'measure': badAnswersLvl3},
      {'domain': 'N', 'measure': notLvl3},
    ];

    List<GaugeDatasEntity> gaugeDatas = [
      GaugeDatasEntity(
          data: dataTotal,
          legende: '${words(context).txt_total} : ${userQuestions.length}',
          goodAnswers: goodAnswers,
          badAnswers: badAnswers),
      GaugeDatasEntity(
          data: dataLvl3,
          legende:
              '${words(context).label_hard} : ${goodAnswersLvl3 + badAnswersLvl3}',
          goodAnswers: goodAnswersLvl3,
          badAnswers: badAnswersLvl3),
      GaugeDatasEntity(
          data: dataLvl2,
          legende:
              '${words(context).label_medium} : ${goodAnswersLvl2 + badAnswersLvl2}',
          goodAnswers: goodAnswersLvl2,
          badAnswers: badAnswersLvl2),
      GaugeDatasEntity(
          data: dataLvl1,
          legende:
              '${words(context).label_easy} : ${goodAnswersLvl1 + badAnswersLvl1}',
          goodAnswers: goodAnswersLvl1,
          badAnswers: badAnswersLvl1),
    ];

    // data globale
    List<Map<String, dynamic>> evo() {
      List<Map<String, dynamic>> data = [];
      int i = 0;
      for (var q in userQuestions) {
        q.isRightAnswer ? i++ : i--;
        data.add({'domain': userQuestions.indexOf(q), 'measure': i});
      }
      return data;
    }

    List<Map<String, dynamic>> dataGlobale = [
      {
        'id': 'Line',
        'data': evo(),
      }
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSize(context).height * 0.03,
          horizontal: screenSize(context).width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AutoSizeText(
            '${userQuestions.length} ${words(context).txt_que_rep} :',
            style: const TextM(Couleur.text),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: screenSize(context).height * 0.02),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: gaugeDatas.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(width: screenSize(context).width * 0.05),
                    itemBuilder: (context, index) => gaugeDatas
                        .map(
                          (gaugeData) => GaugeBorder(
                            data: gaugeData.data,
                            fillColor: (pieData, i) {
                              switch (pieData['domain']) {
                                case 'G':
                                  return Couleur.secondary;
                                case 'B':
                                  return Couleur.error;
                                default:
                                  return Colors.grey;
                              }
                            },
                            legende: gaugeData.legende,
                            goodAnswers: gaugeData.goodAnswers,
                            badAnswers: gaugeData.badAnswers,
                          ),
                        )
                        .toList()[index],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: screenSize(context).height * 0.05),
          Expanded(
            flex: 3,
            child: LineBorder(
              data: dataGlobale,
            ),
          )
        ],
      ),
    );
  }
}
