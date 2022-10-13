import 'package:flutter/material.dart';
import 'package:gypse/core/bloc/bloc_provider.dart' as blocs;
import 'package:gypse/core/builders/content_buider.dart';
import 'package:gypse/core/commons/current_user.dart';
import 'package:gypse/core/commons/size.dart';
import 'package:gypse/domain/entities/answer_entity.dart';
import 'package:gypse/domain/entities/question_entity.dart';
import 'package:gypse/domain/entities/user_entity.dart';
import 'package:gypse/domain/providers/answers_domain_provider.dart';
import 'package:gypse/domain/providers/questions_domain_provider.dart';
import 'package:gypse/presenation/game/answers/game_answers.dart';
import 'package:gypse/presenation/game/bloc/user_bloc.dart';
import 'package:gypse/presenation/game/components/game_app_bar.dart';
import 'package:gypse/presenation/game/question/game_question.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart' as riverpod;
import 'package:provider/provider.dart';

import 'bloc/answers_bloc.dart';

/// Game view
///
/// GameScreen allows users to respond to quiz
class GameScreen extends riverpod.HookConsumerWidget {
  final String filter;
  const GameScreen(this.filter, {super.key});

  @override
  Widget build(BuildContext context, riverpod.WidgetRef ref) {
    GypseUser user = Provider.of<CurrentUser>(context).currentUser;

    Future<Question> question(List<AnsweredQuestion> questions) => ref
        .read(QuestionsDomainProvider().fetchNextQuestionUsecaseProvider)
        .fetchNextQuestion(context,
            book: filter != '_' ? filter : null, userQuestions: questions);

    Future<List<Answer>?> answers(String questionId) => ref
        .read(AnswersDomainProvider().fetchAnswersUsecaseProvider)
        .fetchQuestionAnswers(context, questionId);

    final bloc = blocs.BlocProvider.of<UserBloc>(context);

    return StreamBuilder<List<AnsweredQuestion>>(
        stream: bloc.stream,
        builder: (context, state) {
          return FutureBuilder<Question>(
              future: question(state.data!),
              builder: (context, snapshot) => ContentBuilder(
                    hasData: snapshot.hasData,
                    hasError: snapshot.hasError,
                    message: '${snapshot.error}',
                    child: FutureBuilder<List<Answer>?>(
                        future: answers(snapshot.data!.id),
                        builder: (context, snap) => ContentBuilder(
                              hasData: snap.hasData,
                              hasError: snap.hasError,
                              message: '${snap.error}',
                              child: Scaffold(
                                extendBodyBehindAppBar: true,
                                appBar:
                                    GameAppBar(context, snapshot.data!.book),
                                body: Container(
                                  padding: const EdgeInsets.only(top: 30),
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/game_bkg.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    itemBuilder: (context, index) => [
                                      SizedBox(
                                          height: (screenSize(context).height -
                                                  30) *
                                              0.25,
                                          child: GameQuestion(
                                            question: snapshot.data!,
                                            settings: user.settings,
                                          )),
                                      blocs.BlocProvider<AnswersBloc>(
                                          bloc: AnswersBloc(),
                                          child: GameAnswers(
                                            answers: snap.data!,
                                            user: user,
                                            questionId: snapshot.data!.id,
                                            addQuestion: bloc.addQuestion,
                                          ))
                                    ][index],
                                  ),
                                ),
                              ),
                            )),
                  ));
        });
  }
}
