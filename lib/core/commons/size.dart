import 'package:flutter/material.dart';

/// Returns screen dimensions as a [Size]
Size screenSize(BuildContext context) => Size(
      MediaQuery.of(context).size.width,
      MediaQuery.of(context).size.height,
    );
