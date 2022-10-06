import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/core/l10n/localizations.dart';
import 'package:gypse/core/themes/theme.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/providers/users_domain_provider.dart';
import 'package:gypse/presenation/components/buttons.dart';
import 'package:gypse/presenation/components/cards.dart';
import 'package:gypse/presenation/game/bloc/answers_cubit.dart';
import 'package:gypse/presenation/game/bloc/answers_state.dart';
import 'package:gypse/presenation/game/components/verse_modal.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameAnswers extends HookConsumerWidget {
  final List<Answer> answers;
  final GypseUser user;
  final String questionId;
  const GameAnswers({
    super.key,
    required this.answers,
    required this.user,
    required this.questionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> updateUser(GypseUser user) => ref
        .read(UsersDomainProvider().updateUserUsecaseProvider)
        .updateUser(user);

    return BlocProvider(
        create: (_) => AnswersCubit(),
        child: BlocConsumer<AnswersCubit, AnswersState>(
            listener: (context, state) {},
            builder: (context, state) => AnimatedContainer(
                  duration: const Duration(milliseconds: 900),
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
                              itemCount:
                                  answers.length > 4 ? 4 : answers.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: ((context, index) {
                                Answer answer = answers[index];

                                return AnswerCard(
                                  context,
                                  answer: answer,
                                  selectCard: () => context
                                      .read<AnswersCubit>()
                                      .selectAnswer(index),
                                  index: index,
                                  enabled: state.index == null,
                                  selected: answer.isRightAnswer
                                      ? state.index != null
                                      : state.index == index,
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
                                          answers.firstWhere((answer) =>
                                              answer.isRightAnswer)),
                                      color: Couleur.primarySurface
                                          .withOpacity(0.2),
                                      textColor: Couleur.primary,
                                    ),
                                  ),
                                  SizedBox(
                                      width: screenSize(context).width * 0.08),
                                  FabButton(
                                    context,
                                    icon: Icons.keyboard_arrow_right,
                                    iconColor: Couleur.text,
                                    color: Couleur.primary,
                                    function: () async {
                                      AnsweredQuestion currentQuestion =
                                          AnsweredQuestion(
                                        id: questionId,
                                        level: user.settings.level,
                                        isRightAnswer: answers
                                            .elementAt(state.index!)
                                            .isRightAnswer,
                                      );
                                      List<AnsweredQuestion> answeredQuestions =
                                          user.questions;
                                      print(answers
                                          .elementAt(state.index!)
                                          .isRightAnswer);

                                      answeredQuestions.add(currentQuestion);

                                      GypseUser newUser = user;
                                      newUser.questions = answeredQuestions;
                                      await updateUser(newUser);
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
                )));
  }
}
