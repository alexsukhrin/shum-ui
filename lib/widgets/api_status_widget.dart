import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../services/api_service.dart';

class ApiStatusWidget extends StatefulWidget {
  const ApiStatusWidget({super.key});

  @override
  State<ApiStatusWidget> createState() => _ApiStatusWidgetState();
}

class _ApiStatusWidgetState extends State<ApiStatusWidget> {
  bool _isLoading = false;
  bool _isConnected = false;
  String _statusMessage = '';

  @override
  void initState() {
    super.initState();
    _checkApiStatus();
  }

  Future<void> _checkApiStatus() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final isHealthy = await ApiService().healthCheck();
      setState(() {
        _isConnected = isHealthy;
        _statusMessage = isHealthy ? 'Connected' : 'Not connected';
      });
    } catch (e) {
      setState(() {
        _isConnected = false;
        _statusMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.api,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 8),
                Text(
                  'API Configuration',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRowText('Environment', AppConfig.isDevelopment ? 'Development' : 'Production'),
            _buildInfoRowText('API URL', AppConfig.apiBaseUrl),
            _buildInfoRow('Status', _buildStatusWidget()),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _isLoading ? null : _checkApiStatus,
                  icon: _isLoading 
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh),
                  label: Text(_isLoading ? 'Checking...' : 'Refresh'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => _buildDetailsDialog(),
                    );
                  },
                  child: const Text('Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, Widget value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: value),
        ],
      ),
    );
  }

  Widget _buildInfoRowText(String label, String value) {
    return _buildInfoRow(
      label,
      Text(
        value,
        style: const TextStyle(fontFamily: 'monospace'),
      ),
    );
  }

  Widget _buildStatusWidget() {
    if (_isLoading) {
      return const Row(
        children: [
          SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 8),
          Text('Checking...'),
        ],
      );
    }

    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _isConnected ? Colors.green : Colors.red,
          ),
        ),
        const SizedBox(width: 8),
        Text(_statusMessage),
      ],
    );
  }

  Widget _buildDetailsDialog() {
    return AlertDialog(
      title: const Text('API Configuration Details'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailItem('Environment', AppConfig.isDevelopment ? 'Development' : 'Production'),
            _buildDetailItem('API Base URL', AppConfig.apiBaseUrl),
            _buildDetailItem('Auth Endpoint', AppConfig.authEndpoint),
            _buildDetailItem('Users Endpoint', AppConfig.usersEndpoint),
            _buildDetailItem('Products Endpoint', AppConfig.productsEndpoint),
            _buildDetailItem('Orders Endpoint', AppConfig.ordersEndpoint),
            _buildDetailItem('WebSocket URL', AppConfig.wsUrl),
            _buildDetailItem('Connection Timeout', '${AppConfig.connectionTimeout}ms'),
            _buildDetailItem('Receive Timeout', '${AppConfig.receiveTimeout}ms'),
            _buildDetailItem('Max Retries', AppConfig.maxRetries.toString()),
            _buildDetailItem('Cache Timeout', '${AppConfig.cacheTimeout.inMinutes} minutes'),
            _buildDetailItem('Logging Enabled', AppConfig.enableLogging.toString()),
            _buildDetailItem('Analytics Enabled', AppConfig.enableAnalytics.toString()),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
} 