import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  final Function(Locale) onLanguageChanged;

  const WelcomePage({super.key, required this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEFEFE),
      body: SafeArea(
        child: Row(
          children: [
            // Left Section - Illustration
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6B35),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'shum',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    
                    // Illustration
                    Center(
                      child: CustomPaint(
                        size: const Size(300, 300),
                        painter: WelcomeIllustrationPainter(),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            
            // Right Section - Content
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Language Selector
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () => onLanguageChanged(const Locale('uk')),
                            child: const Text(
                              'UA',
                              style: TextStyle(
                                color: Color(0xFFFF6B35),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Text(' | '),
                          TextButton(
                            onPressed: () => onLanguageChanged(const Locale('en')),
                            child: const Text(
                              'ENG',
                              style: TextStyle(
                                color: Color(0xFF666666),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const Spacer(),
                    
                                         // Welcome Content
                     Text(
                       AppLocalizations.of(context)?.welcomeTitle ?? 'Привіт!',
                       style: const TextStyle(
                         fontSize: 48,
                         fontWeight: FontWeight.bold,
                         color: Color(0xFF333333),
                       ),
                     ),
                     const SizedBox(height: 16),
                     Text(
                       AppLocalizations.of(context)?.welcomeSubtitle ?? 'Отримай безпечний досвід покупок разом з нами',
                       style: const TextStyle(
                         fontSize: 18,
                         color: Color(0xFF666666),
                         height: 1.5,
                       ),
                     ),
                    const SizedBox(height: 40),
                    
                    // Action Buttons
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/signup'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6B35),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                                                 child: Text(AppLocalizations.of(context)?.registerButton ?? 'Зареєструватись'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFFF6B35),
                          side: const BorderSide(color: Color(0xFFFF6B35)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                                                 child: Text(AppLocalizations.of(context)?.loginButton ?? 'Увійти'),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Skip Option
                    Center(
                      child: TextButton(
                        onPressed: () {
                          // TODO: Implement skip functionality
                        },
                                                 child: Text(
                           AppLocalizations.of(context)?.skipButton ?? 'Пропустити цей крок',
                           style: const TextStyle(
                             color: Color(0xFF999999),
                             fontSize: 14,
                           ),
                         ),
                      ),
                    ),
                    
                    const Spacer(),
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

// Custom painter for the welcome illustration
class WelcomeIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF6B35)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;



    // Person figure
    final personPath = Path();
    personPath.moveTo(size.width * 0.5, size.height * 0.3);
    personPath.lineTo(size.width * 0.4, size.height * 0.6);
    personPath.lineTo(size.width * 0.6, size.height * 0.6);
    personPath.close();
    
    // Head
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.25),
      15,
      paint,
    );
    
    // Hat
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width * 0.5, size.height * 0.2),
        width: 30,
        height: 20,
      ),
      0,
      3.14,
      false,
      paint,
    );
    
    // Body
    canvas.drawPath(personPath, paint);
    
    // Hand raised
    canvas.drawLine(
      Offset(size.width * 0.45, size.height * 0.4),
      Offset(size.width * 0.35, size.height * 0.25),
      paint,
    );
    
    // Signpost
    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.4),
      Offset(size.width * 0.3, size.height * 0.7),
      paint,
    );
    
    // Signpost arrows
    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.5),
      Offset(size.width * 0.2, size.height * 0.45),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.3, size.height * 0.6),
      Offset(size.width * 0.4, size.height * 0.55),
      paint,
    );
    
    // Checkmark on top arrow
    canvas.drawLine(
      Offset(size.width * 0.18, size.height * 0.47),
      Offset(size.width * 0.2, size.height * 0.45),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.18, size.height * 0.47),
      Offset(size.width * 0.16, size.height * 0.43),
      paint,
    );
    
    // X on bottom arrow
    canvas.drawLine(
      Offset(size.width * 0.38, size.height * 0.53),
      Offset(size.width * 0.42, size.height * 0.57),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 0.42, size.height * 0.53),
      Offset(size.width * 0.38, size.height * 0.57),
      paint,
    );
    
    // Shopping bags
    final bag1Path = Path();
    bag1Path.moveTo(size.width * 0.2, size.height * 0.75);
    bag1Path.lineTo(size.width * 0.25, size.height * 0.75);
    bag1Path.lineTo(size.width * 0.27, size.height * 0.85);
    bag1Path.lineTo(size.width * 0.18, size.height * 0.85);
    bag1Path.close();
    canvas.drawPath(bag1Path, paint);
    
    final bag2Path = Path();
    bag2Path.moveTo(size.width * 0.3, size.height * 0.75);
    bag2Path.lineTo(size.width * 0.35, size.height * 0.75);
    bag2Path.lineTo(size.width * 0.37, size.height * 0.85);
    bag2Path.lineTo(size.width * 0.28, size.height * 0.85);
    bag2Path.close();
    canvas.drawPath(bag2Path, paint);
    
    // Background elements
    for (int i = 0; i < 5; i++) {
      canvas.drawCircle(
        Offset(
          size.width * (0.1 + i * 0.2),
          size.height * (0.1 + (i % 2) * 0.1),
        ),
        3,
        paint,
      );
    }
    
    // Large circle outline
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.4,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 