import 'package:flutter/foundation.dart';

class AppConfig {
  static const String _localApiUrl = 'http://localhost:8000/';
  static const String _productionApiUrl = 'http://ec2-18-153-92-5.eu-central-1.compute.amazonaws.com:8032/';
  
  // API Configuration
  static String get apiBaseUrl {
    if (kDebugMode) {
      // Development environment - use local API
      return _localApiUrl;
    } else {
      // Production environment - use production API
      return _productionApiUrl;
    }
  }
  
  // Environment detection
  static bool get isDevelopment => kDebugMode;
  static bool get isProduction => !kDebugMode;
  
  // API Endpoints
  static String get authEndpoint => '${apiBaseUrl}auth/';
  static String get usersEndpoint => '${apiBaseUrl}users/';
  static String get productsEndpoint => '${apiBaseUrl}products/';
  static String get ordersEndpoint => '${apiBaseUrl}orders/';
  
  // WebSocket endpoints
  static String get wsUrl {
    final baseUrl = apiBaseUrl.replaceFirst('http://', 'ws://').replaceFirst('https://', 'wss://');
    return baseUrl.replaceFirst('/api/', '/ws/');
  }
  
  // Timeout configurations
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds
  
  // Retry configuration
  static const int maxRetries = 3;
  static const int retryDelay = 1000; // 1 second
  
  // Cache configuration
  static const Duration cacheTimeout = Duration(minutes: 15);
  
  // Logging
  static bool get enableLogging => isDevelopment;
  
  // Feature flags
  static bool get enableAnalytics => isProduction;
  static bool get enableCrashReporting => isProduction;
} 