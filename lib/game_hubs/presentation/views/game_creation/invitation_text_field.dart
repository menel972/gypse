import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gypse/common/style/autocomplete_options.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/game_hubs/presentation/states/game_creation_cubit.dart';

class InvitationTextField extends StatelessWidget {
  const InvitationTextField({super.key});

  static const List<String> _kOptions = ['menelick', 'maman', 'mami'];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCreationCubit, GameCreationState>(
      builder: (context, state) {
        return Autocomplete(
          onSelected: (value) {
            context.read<GameCreationCubit>().onTextChange(value);
            FocusScope.of(context).unfocus();
          },
          optionsViewBuilder: (context, onSelected, options) {
            return AutocompleteOptions(onSelected, options);
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextFormField(
              controller: textEditingController..text = state.pseudoP2,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                helperText: state.inputError,
                helperStyle: const GypseFont.xs(),
                suffixIcon: SvgPicture.asset(
                  GypseIcon.user.path,
                  fit: BoxFit.scaleDown,
                ),
              ),
              onChanged: (value) {
                context.read<GameCreationCubit>().onTextChange(value);
              },
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            );
          },
          optionsBuilder: (value) {
            if (value.text == '') {
              return const Iterable<String>.empty();
            }
            // TODO : Fetch options from user
            return _kOptions.where((String option) {
              return option.toLowerCase().startsWith(value.text.toLowerCase());
            });
          },
        );
      },
    );
  }
}
