# 🎨 Гід: Верстка з Figma у Flutter

## 📋 Покроковий процес

### 1. Підготовка макету в Figma

#### ✅ Експорт ресурсів:
- **Іконки**: SVG або PNG (2x, 3x для різних розмірів)
- **Зображення**: PNG/JPG з правильними розмірами
- **Шрифти**: Встановити шрифти локально або використовувати Google Fonts
- **Кольори**: Скопіювати hex коди кольорів

#### ✅ Аналіз структури:
- **Layout**: Визначити основні секції (header, body, footer)
- **Компоненти**: Знайти повторювані елементи
- **Responsive**: Перевірити як макет виглядає на різних екранах

### 2. Налаштування проекту Flutter

#### 📁 Структура папок:
```
lib/
├── assets/
│   ├── images/
│   ├── icons/
│   └── fonts/
├── widgets/
│   ├── common/
│   └── custom/
├── pages/
├── styles/
│   ├── colors.dart
│   ├── typography.dart
│   └── dimensions.dart
└── utils/
    └── responsive.dart
```

#### 🎨 Створення стилів:

**colors.dart:**
```dart
import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xFFFF6B35);
  static const Color secondary = Color(0xFF333333);
  
  // Background colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF5F5F5);
  
  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textLight = Color(0xFF999999);
  
  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
}
```

**typography.dart:**
```dart
import 'package:flutter/material.dart';
import 'colors.dart';

class AppTypography {
  static const TextStyle h1 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle h2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.textSecondary,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 14,
    color: AppColors.textLight,
  );
}
```

**dimensions.dart:**
```dart
class AppDimensions {
  // Spacing
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  // Border radius
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  
  // Button heights
  static const double buttonHeight = 48.0;
  static const double buttonHeightSm = 36.0;
}
```

### 3. Верстка компонентів

#### 🧩 Створення базових компонентів:

**custom_button.dart:**
```dart
import 'package:flutter/material.dart';
import '../styles/colors.dart';
import '../styles/dimensions.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isLoading;
  
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isPrimary = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.buttonHeight,
      child: isPrimary
          ? ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(text),
            )
          : OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: AppColors.primary)
                  : Text(text),
            ),
    );
  }
}
```

### 4. Верстка сторінок

#### 📱 Responsive дизайн:

**responsive.dart:**
```dart
import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;
      
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1024;
      
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;
      
  static double getWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
      
  static double getHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
```

#### 🎯 Приклад верстки сторінки:

```dart
class HomePage extends StatelessWidget {
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
          _buildHeader(),
          _buildContent(),
          _buildFooter(),
        ],
      ),
    );
  }
  
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: _buildSidebar()),
        Expanded(flex: 3, child: _buildMainContent()),
      ],
    );
  }
}
```

### 5. Інструменти для верстки

#### 🔧 Корисні пакети:

**pubspec.yaml:**
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # UI Components
  google_fonts: ^6.1.0
  cached_network_image: ^3.3.0
  
  # Responsive
  flutter_screenutil: ^5.9.0
  
  # Icons
  flutter_svg: ^2.0.9
  
  # Animations
  lottie: ^2.7.0
```

#### 📐 Figma плагіни:
- **Figma to Flutter**: Автоматична генерація коду
- **Figma Tokens**: Експорт дизайн-токенів
- **Figma Dev Mode**: Детальна інформація про елементи

### 6. Практичні поради

#### ✅ Best Practices:
1. **Починайте з мобільної версії** - Mobile-first approach
2. **Використовуйте Flex** - Для адаптивного дизайну
3. **Групуйте стилі** - Централізоване управління дизайном
4. **Тестуйте на різних екранах** - Перевіряйте responsive
5. **Оптимізуйте зображення** - Використовуйте правильні формати

#### 🚀 Workflow:
1. **Аналіз макету** → Визначення структури
2. **Створення стилів** → Кольори, шрифти, розміри
3. **Верстка компонентів** → Базові UI елементи
4. **Верстка сторінок** → Композиція компонентів
5. **Responsive адаптація** → Адаптація під різні екрани
6. **Тестування** → Перевірка на різних пристроях

### 7. Корисні команди

```bash
# Генерація assets
flutter pub get

# Hot reload під час розробки
flutter run -d web-server --web-port 8080

# Аналіз коду
flutter analyze

# Форматування коду
dart format lib/

# Тестування
flutter test
```

### 8. Приклади верстки

#### 🎨 Card компонент:
```dart
class ProductCard extends StatelessWidget {
  final String title;
  final String image;
  final double price;
  
  const ProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppDimensions.radiusLg),
            ),
            child: Image.network(image, height: 200, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.h2),
                const SizedBox(height: AppDimensions.sm),
                Text('\$${price.toStringAsFixed(2)}', 
                     style: AppTypography.body.copyWith(
                       color: AppColors.primary,
                       fontWeight: FontWeight.bold,
                     )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

Цей гід допоможе вам ефективно перенести дизайн з Figma у Flutter! 