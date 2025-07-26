# 🎨 Детальний гід: Верстка з Figma у Flutter

## 📋 Покроковий процес з практичними прикладами

### 1. Підготовка макету в Figma

#### ✅ Експорт ресурсів:

**Іконки:**
- **SVG** - для векторних іконок (масштабуються без втрат якості)
- **PNG** - для растрових іконок (2x, 3x для різних розмірів екрану)
- **Приклад експорту:**
  ```
  assets/icons/
  ├── home.svg
  ├── profile.svg
  ├── cart.svg
  └── search.svg
  ```

**Зображення:**
- **PNG/JPG** - для фотографій та скріншотів
- **WebP** - для кращої оптимізації
- **Приклад структури:**
  ```
  assets/images/
  ├── products/
  │   ├── product1.jpg
  │   └── product2.jpg
  ├── banners/
  │   └── hero-banner.jpg
  └── avatars/
      └── default-avatar.png
  ```

**Шрифти:**
- **Google Fonts** - для веб-шрифтів
- **Локальні шрифти** - для кастомних типографік
- **Приклад налаштування:**
  ```yaml
  # pubspec.yaml
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
  ```

**Кольори:**
- **Hex коди** - скопіювати з Figma
- **RGB/HSL** - для прозорості
- **Приклад експорту:**
  ```
  Primary: #FF6B35
  Secondary: #333333
  Background: #FFFFFF
  Text Primary: #333333
  Text Secondary: #666666
  ```

#### ✅ Аналіз структури:

**Layout аналіз:**
1. **Header** - навігація, логотип, пошук
2. **Body** - основний контент
3. **Footer** - додаткова інформація
4. **Sidebar** - додаткова навігація (для desktop)

**Компонентний аналіз:**
- **Повторювані елементи** - кнопки, картки, форми
- **Унікальні елементи** - специфічні для сторінки
- **Інтерактивні елементи** - hover, focus, active стани

**Responsive аналіз:**
- **Mobile** (320px - 768px)
- **Tablet** (768px - 1024px)
- **Desktop** (1024px+)

### 2. Налаштування проекту Flutter

#### 📁 Структура папок:

```
lib/
├── assets/
│   ├── images/
│   │   ├── products/
│   │   ├── banners/
│   │   └── avatars/
│   ├── icons/
│   │   ├── navigation/
│   │   ├── actions/
│   │   └── status/
│   └── fonts/
├── widgets/
│   ├── common/
│   │   ├── custom_button.dart
│   │   ├── custom_input.dart
│   │   ├── custom_card.dart
│   │   └── loading_indicator.dart
│   ├── navigation/
│   │   ├── app_bar.dart
│   │   ├── bottom_nav.dart
│   │   └── sidebar.dart
│   └── forms/
│       ├── text_field.dart
│       ├── dropdown.dart
│       └── checkbox.dart
├── pages/
│   ├── welcome_page.dart
│   ├── login_page.dart
│   ├── signup_page.dart
│   └── home_page.dart
├── styles/
│   ├── colors.dart
│   ├── typography.dart
│   ├── dimensions.dart
│   └── themes.dart
├── utils/
│   ├── responsive.dart
│   ├── validators.dart
│   └── helpers.dart
└── services/
    ├── api_service.dart
    └── storage_service.dart
```

#### 🎨 Створення стилів:

**colors.dart - детальний приклад:**
```dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary brand colors
  static const Color primary = Color(0xFFFF6B35);
  static const Color primaryLight = Color(0xFFFF8A65);
  static const Color primaryDark = Color(0xFFE64A19);
  
  // Secondary colors
  static const Color secondary = Color(0xFF333333);
  static const Color secondaryLight = Color(0xFF666666);
  static const Color secondaryDark = Color(0xFF000000);
  
  // Background colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color surfaceDark = Color(0xFFEEEEEE);
  
  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  static const Color textDisabled = Color(0xFFCCCCCC);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  
  // Border colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderLight = Color(0xFFF0F0F0);
  static const Color borderDark = Color(0xFFBDBDBD);
  
  // Shadow colors
  static const Color shadow = Color(0x1A000000); // 10% opacity
  static const Color shadowLight = Color(0x0A000000); // 4% opacity
  static const Color shadowDark = Color(0x33000000); // 20% opacity
  
  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [background, surfaceLight],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
```

**typography.dart - детальний приклад:**
```dart
import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  // Font family
  static const String fontFamily = 'Inter';
  
  // Headings
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
    letterSpacing: -0.25,
  );
  
  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0,
  );
  
  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0,
  );
  
  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0,
  );
  
  static const TextStyle h6 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0,
  );
  
  // Body text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
    letterSpacing: 0,
  );
  
  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
    letterSpacing: 0,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
    letterSpacing: 0,
  );
  
  // Caption and labels
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textLight,
    height: 1.4,
    letterSpacing: 0.4,
  );
  
  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
    letterSpacing: 0.1,
  );
  
  // Button text
  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.1,
  );
  
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.1,
  );
  
  // Link text
  static const TextStyle link = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
    height: 1.4,
    letterSpacing: 0,
    decoration: TextDecoration.underline,
  );
  
  // Overline text
  static const TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textLight,
    height: 1.4,
    letterSpacing: 1.5,
    textBaseline: TextBaseline.alphabetic,
  );
}
```

### 3. Верстка компонентів

#### 🧩 Створення базових компонентів:

**custom_input.dart:**
```dart
import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import '../../styles/typography.dart';
import '../../styles/dimensions.dart';

class CustomInput extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? error;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int? maxLength;
  
  const CustomInput({
    super.key,
    this.label,
    this.hint,
    this.error,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = false;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppTypography.label,
          ),
          const SizedBox(height: AppDimensions.xs),
        ],
        Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              _hasFocus = hasFocus;
            });
          },
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: _obscureText,
            enabled: widget.enabled,
            onTap: widget.onTap,
            onChanged: widget.onChanged,
            validator: widget.validator,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            style: AppTypography.body,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTypography.body.copyWith(
                color: AppColors.textLight,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textLight,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.suffixIcon,
              filled: true,
              fillColor: widget.enabled ? AppColors.background : AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                borderSide: BorderSide(
                  color: _hasFocus ? AppColors.primary : AppColors.border,
                  width: _hasFocus ? 2 : 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                borderSide: const BorderSide(
                  color: AppColors.error,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                borderSide: const BorderSide(
                  color: AppColors.error,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.md,
                vertical: AppDimensions.sm,
              ),
            ),
          ),
        ),
        if (widget.error != null) ...[
          const SizedBox(height: AppDimensions.xs),
          Text(
            widget.error!,
            style: AppTypography.caption.copyWith(
              color: AppColors.error,
            ),
          ),
        ],
      ],
    );
  }
}
```

**custom_card.dart:**
```dart
import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import '../../styles/dimensions.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final double? borderRadius;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final bool isLoading;
  
  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.borderRadius,
    this.backgroundColor,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin ?? const EdgeInsets.all(AppDimensions.md),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.surface,
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppDimensions.radiusLg,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: elevation ?? 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: padding ?? const EdgeInsets.all(AppDimensions.md),
              child: child,
            ),
            if (isLoading)
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(
                    borderRadius ?? AppDimensions.radiusLg,
                  ),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
```

### 4. Верстка сторінок

#### 📱 Responsive дизайн:

**responsive.dart - детальний приклад:**
```dart
import 'package:flutter/material.dart';
import '../styles/dimensions.dart';

class Responsive {
  // Breakpoint checks
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint;
      
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.mobileBreakpoint &&
      MediaQuery.of(context).size.width < AppDimensions.tabletBreakpoint;
      
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.desktopBreakpoint;
      
  static bool isLargeDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppDimensions.desktopBreakpoint;
      
  // Screen dimensions
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
      
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
      
  // Responsive padding
  static double getPadding(BuildContext context) {
    if (isMobile(context)) return AppDimensions.md;
    if (isTablet(context)) return AppDimensions.lg;
    return AppDimensions.xl;
  }
  
  // Responsive margins
  static double getMargin(BuildContext context) {
    if (isMobile(context)) return AppDimensions.sm;
    if (isTablet(context)) return AppDimensions.md;
    return AppDimensions.lg;
  }
  
  // Max content width
  static double getMaxWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 768;
    if (isDesktop(context)) return 1024;
    return 1200;
  }
  
  // Responsive edge insets
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
  
  // Responsive grid columns
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    if (isDesktop(context)) return 3;
    return 4;
  }
  
  // Responsive font sizes
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    if (isMobile(context)) return baseSize;
    if (isTablet(context)) return baseSize * 1.1;
    return baseSize * 1.2;
  }
  
  // Responsive spacing
  static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
    if (isMobile(context)) return baseSpacing;
    if (isTablet(context)) return baseSpacing * 1.2;
    return baseSpacing * 1.5;
  }
}
```

#### 🎯 Приклад верстки сторінки:

**home_page.dart:**
```dart
import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../styles/typography.dart';
import '../styles/dimensions.dart';
import '../utils/responsive.dart';
import '../widgets/common/custom_button.dart';
import '../widgets/common/custom_card.dart';
import '../widgets/common/custom_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Responsive.isMobile(context)
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context),
    );
  }
  
  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeader(context),
          _buildSearchSection(context),
          _buildFeaturedProducts(context),
          _buildCategories(context),
          _buildFooter(context),
        ],
      ),
    );
  }
  
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: _buildSidebar(context)),
        Expanded(flex: 3, child: _buildMainContent(context)),
      ],
    );
  }
  
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: Responsive.getScreenPadding(context),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: AppDimensions.iconLg,
                height: AppDimensions.iconLg,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
                ),
                child: const Icon(
                  Icons.shopping_bag,
                  color: Colors.white,
                  size: AppDimensions.iconMd,
                ),
              ),
              const SizedBox(width: AppDimensions.sm),
              Text(
                'Shum',
                style: AppTypography.h4,
              ),
            ],
          ),
          const Spacer(),
          
          // Navigation
          if (!Responsive.isMobile(context))
            Row(
              children: [
                _buildNavItem('Home', Icons.home, true),
                _buildNavItem('Products', Icons.inventory),
                _buildNavItem('About', Icons.info),
                _buildNavItem('Contact', Icons.contact_support),
              ],
            ),
          
          // User actions
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(String title, IconData icon, [bool isActive = false]) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.sm),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.md,
        vertical: AppDimensions.sm,
      ),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: AppDimensions.iconSm,
            color: isActive ? Colors.white : AppColors.textSecondary,
          ),
          const SizedBox(width: AppDimensions.xs),
          Text(
            title,
            style: AppTypography.label.copyWith(
              color: isActive ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSearchSection(BuildContext context) {
    return Container(
      padding: Responsive.getScreenPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find what you need',
            style: AppTypography.h2,
          ),
          const SizedBox(height: AppDimensions.md),
          CustomInput(
            controller: _searchController,
            hint: 'Search products...',
            prefixIcon: const Icon(Icons.search),
            onChanged: (value) {
              // Handle search
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildFeaturedProducts(BuildContext context) {
    return Container(
      padding: Responsive.getScreenPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Products',
            style: AppTypography.h3,
          ),
          const SizedBox(height: AppDimensions.lg),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.getGridColumns(context),
              crossAxisSpacing: AppDimensions.md,
              mainAxisSpacing: AppDimensions.md,
              childAspectRatio: 0.75,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return _buildProductCard(context, index);
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildProductCard(BuildContext context, int index) {
    return CustomCard(
      onTap: () {
        // Navigate to product details
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              ),
              child: const Icon(
                Icons.image,
                size: AppDimensions.iconXl,
                color: AppColors.textLight,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.sm),
          
          // Product info
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product ${index + 1}',
                  style: AppTypography.h6,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.xs),
                Text(
                  '\$${(index + 1) * 10}.99',
                  style: AppTypography.body.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                CustomButton(
                  text: 'Add to Cart',
                  onPressed: () {},
                  isPrimary: false,
                  height: AppDimensions.buttonHeightSm,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategories(BuildContext context) {
    return Container(
      padding: Responsive.getScreenPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: AppTypography.h3,
          ),
          const SizedBox(height: AppDimensions.lg),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return _buildCategoryCard(context, index);
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryCard(BuildContext context, int index) {
    final categories = ['Electronics', 'Clothing', 'Books', 'Home', 'Sports'];
    final icons = [Icons.phone, Icons.checkroom, Icons.book, Icons.home, Icons.sports_soccer];
    
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: AppDimensions.md),
      child: CustomCard(
        onTap: () {
          // Navigate to category
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icons[index],
              size: AppDimensions.iconLg,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppDimensions.sm),
            Text(
              categories[index],
              style: AppTypography.label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSidebar(BuildContext context) {
    return Container(
      color: AppColors.surface,
      padding: const EdgeInsets.all(AppDimensions.md),
      child: Column(
        children: [
          // Sidebar content
          Text(
            'Categories',
            style: AppTypography.h4,
          ),
          const SizedBox(height: AppDimensions.lg),
          // Add category list here
        ],
      ),
    );
  }
  
  Widget _buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildSearchSection(context),
          _buildFeaturedProducts(context),
        ],
      ),
    );
  }
  
  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: Responsive.getScreenPadding(context),
      color: AppColors.surface,
      child: Column(
        children: [
          Text(
            '© 2024 Shum. All rights reserved.',
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
```

### 5. Практичні поради

#### ✅ Best Practices:

1. **Mobile-first approach:**
   - Починайте з мобільної версії
   - Додавайте функціональність для більших екранів
   - Використовуйте прогресивне покращення

2. **Компонентний підхід:**
   - Створюйте перевикористовувані компоненти
   - Використовуйте композицію замість наслідування
   - Дотримуйтесь принципу єдиної відповідальності

3. **Performance оптимізація:**
   - Використовуйте `const` конструктори
   - Мінімізуйте перебудови віджетів
   - Оптимізуйте зображення та анімації

4. **Accessibility:**
   - Додавайте семантичні лейбли
   - Використовуйте правильні контрасти кольорів
   - Підтримуйте навігацію з клавіатури

#### 🚀 Workflow:

1. **Аналіз макету** (30 хв)
   - Визначення структури
   - Ідентифікація компонентів
   - Планування responsive поведінки

2. **Створення стилів** (1 година)
   - Налаштування кольорів
   - Визначення типографіки
   - Створення системи розмірів

3. **Верстка компонентів** (2-3 години)
   - Базові UI елементи
   - Форми та інтерактивні елементи
   - Навігаційні компоненти

4. **Верстка сторінок** (3-4 години)
   - Композиція компонентів
   - Responsive адаптація
   - Інтеграція з навігацією

5. **Тестування** (1 година)
   - Перевірка на різних екранах
   - Тестування інтерактивності
   - Performance тестування

### 6. Корисні інструменти

#### 🔧 Flutter DevTools:
- **Widget Inspector** - аналіз структури віджетів
- **Performance** - моніторинг продуктивності
- **Memory** - аналіз використання пам'яті

#### 📐 Figma плагіни:
- **Figma to Flutter** - автоматична генерація коду
- **Figma Tokens** - експорт дизайн-токенів
- **Figma Dev Mode** - детальна інформація про елементи

#### 🎨 Корисні пакети:
```yaml
dependencies:
  # UI Components
  google_fonts: ^6.1.0
  cached_network_image: ^3.3.0
  flutter_svg: ^2.0.9
  
  # Responsive
  flutter_screenutil: ^5.9.0
  
  # Animations
  lottie: ^2.7.0
  flutter_animate: ^4.2.0
  
  # State Management
  provider: ^6.1.1
  riverpod: ^2.4.9
  
  # Navigation
  go_router: ^12.1.3
  
  # Forms
  form_builder_validators: ^9.1.0
```

Цей детальний гід допоможе вам ефективно перенести будь-який дизайн з Figma у Flutter! 