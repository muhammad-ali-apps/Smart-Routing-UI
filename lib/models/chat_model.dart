class ChatHistory {
  final String id;
  final String title;
  final String preview;
  final DateTime timestamp;
  final String modelUsed;
  final int messageCount;

  ChatHistory({
    required this.id,
    required this.title,
    required this.preview,
    required this.timestamp,
    required this.modelUsed,
    required this.messageCount,
  });
}

class UserStats {
  final int totalChats;
  final int comparisons;
  final int offlineSessions;
  final double averageResponseTime;
  final int savedTokens;

  UserStats({
    required this.totalChats,
    required this.comparisons,
    required this.offlineSessions,
    required this.averageResponseTime,
    required this.savedTokens,
  });
}
