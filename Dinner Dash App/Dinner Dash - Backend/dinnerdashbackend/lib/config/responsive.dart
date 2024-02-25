import 'package:flutter/material.dart';
//Set screen sizes for mobile, tablet, desktop and wide desktop
class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 690;
  
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 850 &&
      MediaQuery.of(context).size.width >= 690;
  
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1500 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isWideDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 1500;

}