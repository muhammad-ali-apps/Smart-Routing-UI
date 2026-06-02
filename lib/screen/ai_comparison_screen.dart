import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class ComparisonModel {
  final String name;
  final String response;
  final double qualityScore;
  final double speedScore;
  final double costScore;

  ComparisonModel({
    required this.name,
    required this.response,
    required this.qualityScore,
    required this.speedScore,
    required this.costScore,
  });
}

class AIComparisonScreen extends StatefulWidget {
  const AIComparisonScreen({super.key});

  @override
  State<AIComparisonScreen> createState() => _AIComparisonScreenState();
}

class _AIComparisonScreenState extends State<AIComparisonScreen> {
  final TextEditingController _promptController = TextEditingController();
  List<ComparisonModel> _comparisonResults = [];
  bool _isComparing = false;

  final List<String> _samplePrompts = [
    'Write a Flutter widget for a button',
    'Explain recursion in simple terms',
    'Create a workout plan for beginners',
  ];

  void _performComparison() {
    if (_promptController.text.isEmpty) return;

    setState(() => _isComparing = true);

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _comparisonResults = [
          ComparisonModel(
            name: 'GPT-5',
            response:
                'Here\'s an elegant Flutter button widget with gradient background and smooth animations. The button includes loading states and ripple effects for better UX...',
            qualityScore: 9.5,
            speedScore: 8.5,
            costScore: 7.0,
          ),
          ComparisonModel(
            name: 'Claude 4',
            response:
                'I\'ll create a customizable Flutter button with Material 3 design principles. The button supports different variants, sizes, and interactive states...',
            qualityScore: 9.2,
            speedScore: 9.0,
            costScore: 8.5,
          ),
          ComparisonModel(
            name: 'DeepSeek',
            response:
                'Creating a Flutter button with animated gradient and press effects. The widget uses AnimatedContainer for smooth transitions...',
            qualityScore: 8.8,
            speedScore: 9.2,
            costScore: 9.0,
          ),
          ComparisonModel(
            name: 'Gemini',
            response:
                'Here\'s a production-ready Flutter button component with comprehensive styling options and accessibility features...',
            qualityScore: 8.5,
            speedScore: 8.0,
            costScore: 8.0,
          ),
        ];
        _isComparing = false;
      });
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
            'AI Model Comparison',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Compare responses from different AI models side by side',
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
                      hintText: 'Enter your prompt for comparison...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _samplePrompts.map((prompt) {
                      return ActionChip(
                        label: Text(prompt),
                        onPressed: () {
                          setState(() {
                            _promptController.text = prompt;
                          });
                        },
                        backgroundColor: AppTheme.surfaceColor,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _isComparing ? null : _performComparison,
                    icon: _isComparing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.compare),
                    label: Text(
                      _isComparing ? 'Comparing...' : 'Compare Models',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_comparisonResults.isNotEmpty) ...[
            const SizedBox(height: 32),
            ..._comparisonResults.map((model) => _buildComparisonCard(model)),
          ],
        ],
      ),
    );
  }

  Widget _buildComparisonCard(ComparisonModel model) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: AppTheme.surfaceColor,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
          child: Text(
            model.name[0],
            style: const TextStyle(color: AppTheme.primaryColor),
          ),
        ),
        title: Text(
          model.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Row(
          children: [
            _buildScoreChip('Quality', model.qualityScore, Colors.green),
            const SizedBox(width: 8),
            _buildScoreChip('Speed', model.speedScore, Colors.blue),
            const SizedBox(width: 8),
            _buildScoreChip('Cost', model.costScore, Colors.orange),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Response:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(model.response, style: TextStyle(color: Colors.grey[300])),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: model.qualityScore / 10,
                  backgroundColor: Colors.grey[800],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Overall Score: ${((model.qualityScore + model.speedScore + model.costScore) / 3).toStringAsFixed(1)}/10',
                      style: const TextStyle(
                        color: AppTheme.accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                      ),
                      child: const Text('Select Model'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreChip(String label, double score, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        '$label: $score/10',
        style: TextStyle(color: color, fontSize: 12),
      ),
    );
  }
}
