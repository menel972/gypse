import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:gypse/core/bloc/bloc_provider.dart' as blocs;
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
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameAnswers extends HookConsumerWidget {
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
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> updateUser(GypseUser user) => ref
        .read(UsersDomainProvider().updateUserUsecaseProvider)
        .updateUser(user);
    final bloc = blocs.BlocProvider.of<AnswersBloc>(context);

    Future<void> nextQuestion(AnsweredQuestion newQuestion) async {
      user.questions.add(newQuestion);
      bloc.slideView(false);
      await Future.delayed(const Duration(milliseconds: 900));
      await updateUser(user);
      addQuestion(newQuestion);
      bloc.slideView(true);
      bloc.selectAnswer(null);
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
                    (state.animate ? 0 : 0.7)),
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
                    bottom: screenSize(context).height * 0.07,
                    left: screenSize(context).width * 0.05,
                    right: screenSize(context).width * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: ListView.builder(
                          itemCount: answers.length > 4 ? 4 : answers.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, i) {
                            Answer answer = answers[i];

                            return AnswerCard(
                              context,
                              enabled: state.index == null,
                              answer: answer,
                              selectCard: () => bloc.selectAnswer(i),
                              index: i,
                              // enabled: state.index == null,
                              selected: answer.isRightAnswer
                                  ? state.index != null
                                  : state.index == i,
                            );
                          }),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        flex: 1,
                        child: Visibility(
                          visible: state.index != null,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: PrimaryButton(
                                  context,
                                  text: words(context).btn_verset,
                                  onPressed: () => VerseModal.showVerset(
                                      context,
                                      answers.firstWhere(
                                          (answer) => answer.isRightAnswer)),
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
                                  AnsweredQuestion newQuestion =
                                      AnsweredQuestion(
                                    id: questionId,
                                    level: user.settings.level,
                                    isRightAnswer:
                                        answers[state.index!].isRightAnswer,
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
