import 'package:flutter/material.dart';

///## Responsive [Size]
///
/// Returns a percentage of the screen dimensions.
class Dimensions extends Size {
  final BuildContext context;

  ///## Responsive [Size]
  ///
  /// Returns **1% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.xxxs(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.01,
          MediaQuery.of(context).size.height * 0.01,
        );

  ///## Responsive [Size]
  ///
  /// Returns **2% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.xxs(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.02,
          MediaQuery.of(context).size.height * 0.02,
        );

  ///## Responsive [Size]
  ///
  /// Returns **5% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.xs(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.055,
          MediaQuery.of(context).size.height * 0.05,
        );

  ///## Responsive [Size]
  ///
  /// Returns **5% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.iconXS(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.055,
          MediaQuery.of(context).size.height * 0.055,
        );

  ///## Responsive [Size]
  ///
  /// Returns **6,5% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.iconS(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.065,
          MediaQuery.of(context).size.width * 0.065,
        );

  ///## Responsive [Size]
  ///
  /// Returns **7,7% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.iconM(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.077,
          MediaQuery.of(context).size.width * 0.077,
        );

  ///## Responsive [Size]
  ///
  /// Returns **8,9% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.iconL(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.089,
          MediaQuery.of(context).size.width * 0.089,
        );

  ///## Responsive [Size]
  ///
  /// Returns **10% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.s(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.1,
          MediaQuery.of(context).size.height * 0.1,
        );

  ///## Responsive [Size]
  ///
  /// Returns **20% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.m(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.2,
          MediaQuery.of(context).size.height * 0.2,
        );

  ///## Responsive [Size]
  ///
  /// Returns **30% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.l(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.3,
          MediaQuery.of(context).size.height * 0.3,
        );

  ///## Responsive [Size]
  ///
  /// Returns **40% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.xl(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.4,
          MediaQuery.of(context).size.height * 0.4,
        );

  ///## Responsive [Size]
  ///
  /// Returns **50% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.xxl(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.5,
          MediaQuery.of(context).size.height * 0.5,
        );

  ///## Responsive [Size]
  ///
  /// Returns **80% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.xxxl(this.context)
      : super(
          MediaQuery.of(context).size.width * 0.8,
          MediaQuery.of(context).size.height * 0.8,
        );

  ///## Responsive [Size]
  ///
  /// Returns **100% of the screen dimensions**.
  /// ```
  /// final BuildContext context;
  /// ```
  Dimensions.screen(this.context)
      : super(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        );
}
