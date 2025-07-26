import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../styles/colors.dart';
import '../styles/typography.dart';
import '../styles/dimensions.dart';
import '../widgets/common/custom_button.dart';

class WelcomePage extends StatelessWidget {
  final Function(Locale) onLanguageChanged;

  const WelcomePage({super.key, required this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Row(
          children: [
            // Left Section - Image and Description
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/hero-banner.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.all(AppDimensions.md),
                        decoration: BoxDecoration(
                          color: AppColors.surface.withAlpha(204), // 80% opacity
                          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Відео-огляди',
                              style: AppTypography.h4.copyWith(color: AppColors.textPrimary),
                            ),
                            const SizedBox(height: AppDimensions.xs),
                            Text(
                              'Переглядайте відео-огляди, як у стрічці соціальних мереж.',
                              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: AppDimensions.xs),
                            Text(
                              'Маркетплейс SHUM',
                              style: AppTypography.caption.copyWith(color: AppColors.textLight),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Right Section - Content
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                          'shum',
                          style: AppTypography.h4.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    
                    // Welcome Content
                    Text(
                      AppLocalizations.of(context)?.welcomeTitle ?? 'Привіт!',
                      style: AppTypography.h1,
                    ),
                    const SizedBox(height: AppDimensions.md),
                    Text(
                      AppLocalizations.of(context)?.welcomeSubtitle ?? 'Отримай безпечний досвід покупок разом з нами',
                      style: AppTypography.bodyLarge,
                    ),
                    const SizedBox(height: AppDimensions.lg),
                    
                    // Action Buttons
                    CustomButton(
                      text: AppLocalizations.of(context)?.registerButton ?? 'Зареєструватись',
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      isPrimary: true,
                      icon: Icons.person_add,
                    ),
                    const SizedBox(height: AppDimensions.md),
                    CustomButton(
                      text: AppLocalizations.of(context)?.loginButton ?? 'Увійти',
                      onPressed: () => Navigator.pushNamed(context, '/login'),
                      isPrimary: false,
                      icon: Icons.login,
                    ),
                    const SizedBox(height: AppDimensions.lg),
                    
                    // Skip Option
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement skip functionality
                        },
                        child: Text(
                          AppLocalizations.of(context)?.skipButton ?? 'Пропустити цей крок',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.textLight,
                          ),
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Language Selector
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () => onLanguageChanged(const Locale('uk')),
                            child: Text(
                              'UA',
                              style: AppTypography.label.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(' | '),
                          TextButton(
                            onPressed: () => onLanguageChanged(const Locale('en')),
                            child: Text(
                              'ENG',
                              style: AppTypography.label.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 