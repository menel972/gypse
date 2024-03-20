import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/game_hubs/presentation/states/game_creation_cubit.dart';

class InvitationTextField extends StatelessWidget {
  const InvitationTextField({super.key});

  static const List<String> _kOptions = ['menelick', 'maman', 'mami'];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCreationCubit, GameCreationState>(
      builder: (context, state) {
        return Autocomplete(
          displayStringForOption: (option) => option,
          onSelected: (value) {
            FocusScope.of(context).unfocus();
          },
          optionsViewBuilder: (context, onSelected, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: Dimensions.screen(context).height * 0.14,
                  width: Dimensions.screen(context).width * 0.92,
                  child: Blur(
                    blur: 3,
                    blurColor: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                    overlay: ListView.separated(
                      padding: Dimensions.xxs(context).pad(),
                      itemCount: options.length,
                      separatorBuilder: (_, __) =>
                          Dimensions.xxs(context).spaceH(),
                      itemBuilder: (BuildContext context, int index) {
                        final option = options.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: Text(
                            option,
                            style: GypseFont.s(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        );
                      },
                    ),
                    child: Container(),
                  ),
                ),
              ),
            );
          },
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextFormField(
              controller: textEditingController,
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                suffixIcon: SvgPicture.asset(
                  GypseIcon.user.path,
                  fit: BoxFit.scaleDown,
                ),
              ),
              onChanged: (value) {},
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            );
          },
          optionsBuilder: (value) {
            if (value.text == '') {
              return const Iterable<String>.empty();
            }
            return _kOptions.where((String option) {
              return option.toLowerCase().startsWith(value.text.toLowerCase());
            });
          },
        );
      },
    );
  }
}
