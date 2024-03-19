import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gypse/common/style/buttons.dart';
import 'package:gypse/common/style/fonts.dart';
import 'package:gypse/common/utils/dimensions.dart';
import 'package:gypse/common/utils/enums/assets_enum.dart';
import 'package:gypse/common/utils/enums/path_enum.dart';
import 'package:gypse/common/utils/enums/settings_enum.dart';
import 'package:gypse/common/utils/enums/state_enum.dart';
import 'package:gypse/common/utils/extensions.dart';
import 'package:gypse/common/utils/gypse_scaffold.dart';
import 'package:gypse/game_hubs/presentation/states/multi_game_cubit.dart';
import 'package:gypse/game_hubs/presentation/views/multi/multi_list_view_item.dart';

part 'multi/multi_app_bar.dart';
part 'multi/multi_list_view.dart';

/// A screen that displays the list of UiMultiGame.
class MultiScreen extends StatelessWidget {
  const MultiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GypseScaffold(
      noBackground: true,
      bottomArea: false,
      appBar: const MultiAppBar(),
      body: Dimensions.xs(context).padding(const MultiListView()),
    );
  }
}
