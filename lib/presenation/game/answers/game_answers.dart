import 'package:blur/blur.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/bloc/bloc_provider.dart' as blocs;
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/is_answered_menu.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/providers/users_domain_provider.dart';
import 'package:gypse/presenation/components/buttons.dart';
import 'package:gypse/presenation/components/cards.dart';
import 'package:gypse/presenation/game/bloc/answers_bloc.dart';
import 'package:gypse/presenation/game/bloc/answers_state.dart';
import 'package:gypse/presenation/game/components/verse_modal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

class GameAnswers extends riverpod.HookConsumerWidget {
  final VoidCallback pause;
  final VoidCallback restart;
  final List<Answer> answers;
  final GypseUser user;
  final String questionId;
  final Function(AnsweredQuestion) addQuestion;
  const GameAnswers({
    super.key,
    required this.answers,
    required this.user,
    required this.questionId,
    required this.addQuestion,
    required this.pause,
    required this.restart,
  });

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    Future<void> updateSqliteUser(GypseUser user) => ref
        .read(UsersDomainProvider().updateUserUsecaseProvider)
        .updateUser(user);

    void updateCurrentUser(GypseUser user) =>
        Provider.of<CurrentUser>(context, listen: false).setCurrentUser(user);

    void setAnswered(bool boolean) =>
        Provider.of<IsAnsweredMenu>(context, listen: false)
            .setAnswered(boolean);

    bool isAnswered = Provider.of<IsAnsweredMenu>(context).isAnswered;

    final bloc = blocs.BlocProvider.of<AnswersBloc>(context);

    Future<void> nextQuestion(AnsweredQuestion newQuestion) async {
      user.questions.add(newQuestion);
      bloc.slideView(false);
      await Future.delayed(const Duration(milliseconds: 900));
      await updateSqliteUser(user);
      updateCurrentUser(user);
      setAnswered(false);
      addQuestion(newQuestion);
      bloc.slideView(true);
      bloc.selectAnswer(null);
      restart();
    }

    return StreamBuilder<AnswersState>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          AnswersState state = snapshot.data!;
          return AnimatedPadding(
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            padding: EdgeInsets.only(
                top: (screenSize(context).height - 30) *
                    (state.animate ? 0 : 0.65)),
            child: Container(
              width: screenSize(context).width,
              height: (screenSize(context).height - 30) * 0.75,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Blur(
                blur: 3,
                blurColor: Couleur.primarySurface,
                colorOpacity: 0.5,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                overlay: Padding(
                  padding: EdgeInsets.only(
                    top: screenSize(context).height * 0.01,
                    bottom: screenSize(context).height * 0.075,
                    left: screenSize(context).width * 0.05,
                    right: screenSize(context).width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: answers.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, i) {
                            Answer answer = answers[i];

                            return AnswerCard(
                              context,
                              enabled: state.index == null,
                              answer: answer,
                              selectCard: () {
                                bloc.selectAnswer(i);
                                pause();
                                setAnswered(true);
                              },
                              index: i,
                              selected: (answer.isRightAnswer
                                      ? state.index != null
                                      : state.index == i) ||
                                  (state.index == null && isAnswered),
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: screenSize(context).height * 0.1),
                        child: Visibility(
                          visible: isAnswered,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: PrimaryButton(
                                  context,
                                  text: words(context).btn_verset,
                                  onPressed: () {
                                    FirebaseAnalytics.instance.logEvent(
                                        name: words(context).btn_verset);
                                    VerseModal.showVerset(
                                        context,
                                        answers.firstWhere(
                                            (answer) => answer.isRightAnswer));
                                  },
                                  color:
                                      Couleur.primarySurface.withOpacity(0.2),
                                  textColor: Couleur.primary,
                                ),
                              ),
                              SizedBox(width: screenSize(context).width * 0.08),
                              FabButton(
                                context,
                                icon: Icons.keyboard_arrow_right,
                                iconColor: Couleur.text,
                                color: Couleur.primary,
                                function: () async {
                                  FirebaseAnalytics.instance
                                      .logLevelEnd(levelName: '');
                                  FirebaseAnalytics.instance
                                      .logLevelStart(levelName: '');
                                  AnsweredQuestion newQuestion =
                                      AnsweredQuestion(
                                    id: questionId,
                                    level: user.settings.level,
                                    isRightAnswer: state.index == null
                                        ? false
                                        : answers[state.index!].isRightAnswer,
                                  );

                                  nextQuestion(newQuestion);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                child: Container(),
              ),
            ),
          );
        });
  }
}
