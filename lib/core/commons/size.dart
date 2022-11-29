import 'package:flutter/material.dart';

/// Returns screen dimensions as a [Size]
Size screenSize(BuildContext context) => Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );

/// Retuns wether the screen height dimension is taller than 890
bool isLargeScreen(BuildContext context) => screenSize(context).height > 890.0;
