import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class HistoryItem {
  final String title;
  final String preview;
  final String timestamp;
  final String modelUsed;
  final bool isFavorite;

  HistoryItem({
    required this.title,
    required this.preview,
    required this.timestamp,
    required this.modelUsed,
    this.isFavorite = false,
  });
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _filter = 'All';
  final List<String> _filters = ['All', 'Chats', 'Comparisons', 'Routing'];

  List<HistoryItem> _history = [
    HistoryItem(
      title: 'Flutter Login UI Design',
      preview: 'Created a beautiful login screen with validation...',
      timestamp: 'Yesterday',
      modelUsed: 'Claude 4',
      isFavorite: true,
    ),
    HistoryItem(
      title: 'State Management Guide',
      preview: 'Comparison of Provider, Riverpod, and Bloc...',
      timestamp: 'Today',
      modelUsed: 'GPT-5',
      isFavorite: false,
    ),
    HistoryItem(
      title: 'AI Comparison Test',
      preview: 'Compared 4 different AI models for code generation...',
      timestamp: '2 hours ago',
      modelUsed: 'Multiple',
      isFavorite: true,
    ),
    HistoryItem(
      title: 'Offline Session: DeepSeek',
      preview: 'Used offline AI for content generation...',
      timestamp: '5 hours ago',
      modelUsed: 'DeepSeek',
      isFavorite: false,
    ),
    HistoryItem(
      title: 'Smart Routing Analysis',
      preview: 'AI routed query to optimal model with 96% confidence...',
      timestamp: '1 day ago',
      modelUsed: 'Gemini',
      isFavorite: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('History', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'View your past conversations and activities',
            style: TextStyle(color: Colors.grey[400]),
          ),
          const SizedBox(height: 24),
          GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search history...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list),
                        style: IconButton.styleFrom(
                          backgroundColor: AppTheme.surfaceColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _filters.map((filter) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(filter),
                            selected: _filter == filter,
                            onSelected: (selected) {
                              setState(() {
                                _filter = filter;
                              });
                            },
                            backgroundColor: AppTheme.surfaceColor,
                            selectedColor: AppTheme.primaryColor,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ..._history.map((item) => _buildHistoryItem(item)),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(HistoryItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppTheme.surfaceColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item.isFavorite
              ? Colors.yellow.withOpacity(0.2)
              : AppTheme.primaryColor.withOpacity(0.2),
          child: Icon(
            item.isFavorite ? Icons.star : Icons.chat_bubble_outline,
            color: item.isFavorite ? Colors.yellow : AppTheme.primaryColor,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.preview, style: TextStyle(color: Colors.grey[400])),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.modelUsed,
                    style: TextStyle(color: AppTheme.accentColor, fontSize: 10),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  item.timestamp,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton(
          icon: const Icon(Icons.more_vert),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'favorite',
              child: Text('Add to Favorites'),
            ),
            const PopupMenuItem(value: 'delete', child: Text('Delete')),
            const PopupMenuItem(value: 'share', child: Text('Share')),
          ],
        ),
        onTap: () {
          // Show dialog with full conversation
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: AppTheme.surfaceColor,
              title: Text(item.title),
              content: Text(item.preview),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
