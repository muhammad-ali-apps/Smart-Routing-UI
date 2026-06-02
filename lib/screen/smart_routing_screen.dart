import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class RoutingResult {
  final String prompt;
  final String selectedModel;
  final double confidence;
  final String reason;
  final DateTime timestamp;

  RoutingResult({
    required this.prompt,
    required this.selectedModel,
    required this.confidence,
    required this.reason,
    required this.timestamp,
  });
}

class SmartRoutingScreen extends StatefulWidget {
  const SmartRoutingScreen({super.key});

  @override
  State<SmartRoutingScreen> createState() => _SmartRoutingScreenState();
}

class _SmartRoutingScreenState extends State<SmartRoutingScreen> {
  final TextEditingController _promptController = TextEditingController();
  final List<RoutingResult> _routingHistory = [
    RoutingResult(
      prompt: 'Create Flutter Login UI',
      selectedModel: 'Claude 4',
      confidence: 0.96,
      reason: 'Best model for coding tasks with excellent UI generation',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    RoutingResult(
      prompt: 'Explain quantum computing',
      selectedModel: 'GPT-5',
      confidence: 0.94,
      reason: 'Superior at explaining complex scientific concepts',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
    RoutingResult(
      prompt: 'Generate creative story',
      selectedModel: 'DeepSeek',
      confidence: 0.89,
      reason: 'Excellent creative writing capabilities',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
    ),
    RoutingResult(
      prompt: 'Analyze market trends',
      selectedModel: 'Gemini',
      confidence: 0.91,
      reason: 'Strong analytical and reasoning abilities',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  RoutingResult? _currentRouting;

  void _performRouting() {
    if (_promptController.text.isEmpty) return;

    final mockResult = RoutingResult(
      prompt: _promptController.text,
      selectedModel: 'Claude 4',
      confidence: 0.96,
      reason: 'Optimal for code generation and technical tasks',
      timestamp: DateTime.now(),
    );

    setState(() {
      _currentRouting = mockResult;
      _routingHistory.insert(0, mockResult);
      _promptController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Smart Routing',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Let AI intelligently route your query to the best model',
            style: TextStyle(color: Colors.grey[400]),
          ),
          const SizedBox(height: 32),
          GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  TextField(
                    controller: _promptController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Enter your prompt here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _performRouting,
                          icon: const Icon(Icons.route),
                          label: const Text('Smart Route'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_currentRouting != null) ...[
            const SizedBox(height: 24),
            _buildRoutingResult(_currentRouting!),
          ],
          const SizedBox(height: 32),
          Text(
            'Recent Routing History',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _routingHistory.length,
            itemBuilder: (context, index) {
              return _buildRoutingHistoryItem(_routingHistory[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoutingResult(RoutingResult result) {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'RECOMMENDED',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  'Confidence: ${(result.confidence * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    color: AppTheme.accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Selected Model: ${result.selectedModel}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Reason: ${result.reason}',
              style: TextStyle(color: Colors.grey[300]),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: result.confidence,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF00D4FF),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoutingHistoryItem(RoutingResult result) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppTheme.surfaceColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
          child: const Icon(Icons.route, color: AppTheme.primaryColor),
        ),
        title: Text(result.prompt, style: const TextStyle(color: Colors.white)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '→ ${result.selectedModel}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              result.reason,
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${(result.confidence * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                color: Color(0xFF00D4FF),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _formatTime(result.timestamp),
              style: TextStyle(fontSize: 10, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
