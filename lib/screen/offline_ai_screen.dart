import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class OfflineModel {
  final String name;
  final String size;
  final String status;
  final double downloadProgress;

  OfflineModel({
    required this.name,
    required this.size,
    required this.status,
    this.downloadProgress = 0,
  });
}

class OfflineAIScreen extends StatefulWidget {
  const OfflineAIScreen({super.key});

  @override
  State<OfflineAIScreen> createState() => _OfflineAIScreenState();
}

class _OfflineAIScreenState extends State<OfflineAIScreen> {
  List<OfflineModel> _models = [
    OfflineModel(name: 'DeepSeek Local', size: '2.4 GB', status: 'Installed'),
    OfflineModel(
      name: 'Llama 3',
      size: '3.8 GB',
      status: 'Downloading',
      downloadProgress: 0.65,
    ),
    OfflineModel(name: 'Phi-3', size: '1.2 GB', status: 'Available'),
    OfflineModel(name: 'Mistral 7B', size: '4.1 GB', status: 'Available'),
  ];

  double _usedStorage = 12.5;
  double _totalStorage = 64.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Offline AI Models',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Download and use AI models without internet connection',
            style: TextStyle(color: Colors.grey[400]),
          ),
          const SizedBox(height: 32),
          GlassCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.storage, color: AppTheme.accentColor),
                      SizedBox(width: 8),
                      Text(
                        'Storage Usage',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: _usedStorage / _totalStorage,
                    backgroundColor: Colors.grey[800],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppTheme.accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${_usedStorage.toStringAsFixed(1)} GB used',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Text(
                        '${_totalStorage.toStringAsFixed(0)} GB total',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Available Models',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ..._models.map((model) => _buildModelCard(model)),
        ],
      ),
    );
  }

  Widget _buildModelCard(OfflineModel model) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppTheme.surfaceColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    model.status == 'Installed'
                        ? Icons.check_circle
                        : Icons.cloud_download,
                    color: model.status == 'Installed'
                        ? Colors.green
                        : AppTheme.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${model.size} • ${model.status}',
                        style: TextStyle(color: Colors.grey[500], fontSize: 12),
                      ),
                    ],
                  ),
                ),
                if (model.status == 'Installed')
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Use Offline'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                    ),
                  )
                else if (model.status == 'Downloading')
                  SizedBox(
                    width: 100,
                    child: Column(
                      children: [
                        LinearProgressIndicator(
                          value: model.downloadProgress,
                          backgroundColor: Colors.grey[800],
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppTheme.accentColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(model.downloadProgress * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                            color: AppTheme.accentColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        final index = _models.indexOf(model);
                        _models[index] = OfflineModel(
                          name: model.name,
                          size: model.size,
                          status: 'Downloading',
                          downloadProgress: 0.3,
                        );
                      });
                    },
                    icon: const Icon(Icons.download),
                    label: const Text('Download'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryColor,
                    ),
                  ),
              ],
            ),
            if (model.status == 'Downloading')
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.withOpacity(0.2),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
