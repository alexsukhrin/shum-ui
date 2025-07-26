import 'package:flutter/material.dart';
import '../styles/dimensions.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint;
      
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.mobileBreakpoint &&
      MediaQuery.of(context).size.width < AppDimensions.tabletBreakpoint;
      
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.desktopBreakpoint;
      
  static bool isLargeDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.desktopBreakpoint;
      
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
      
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
      
  static double getPadding(BuildContext context) {
    if (isMobile(context)) return AppDimensions.md;
    if (isTablet(context)) return AppDimensions.lg;
    return AppDimensions.xl;
  }
  
  static double getMaxWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 768;
    if (isDesktop(context)) return 1024;
    return 1200;
  }
  
  static EdgeInsets getScreenPadding(BuildContext context) {
    final padding = getPadding(context);
    return EdgeInsets.all(padding);
  }
  
  static EdgeInsets getHorizontalPadding(BuildContext context) {
    final padding = getPadding(context);
    return EdgeInsets.symmetric(horizontal: padding);
  }
  
  static EdgeInsets getVerticalPadding(BuildContext context) {
    final padding = getPadding(context);
    return EdgeInsets.symmetric(vertical: padding);
  }
} 