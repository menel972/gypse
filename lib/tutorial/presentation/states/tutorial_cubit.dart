import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';

part 'tutorial_state.dart';

class TutorialCubit extends Cubit<TutorialState> {
  TutorialCubit() : super(const TutorialState.initial());

  static const List<String> tutos = [
    'assets/images/tuto_carousel_1.svg',
    'assets/images/tuto_carousel_2.svg',
    'assets/images/tuto_carousel_3.svg',
    'assets/images/tuto_carousel_4.svg',
    'assets/images/tuto_carousel_5.svg',
  ];

  static const List<String> titles = [
    'Bienvenue sur GYPSE',
    'Teste tes connaissances',
    'Explore la bible',
    'Adapte la difficulté',
    'Observe ta progression',
  ];

  static const List<String> subtitles = [
    'Le quiz sur la bible de Genèse à Apocalypse',
    'Réponds aux questions du livre de ton choix ou joue en mode aléatoire',
    'Découvre le verset associé à chaque question sur ton appli Bible',
    'Modifie le nombre de propositions et le temps imparti',
    'Célèbre chaque victoire et améliore tes points faibles',
  ];

  void setCurrentIndex(int i) {
    emit(state.copyWith(index: i));
  }
}
