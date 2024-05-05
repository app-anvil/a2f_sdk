class ReceivedNotification {
  const ReceivedNotification._({
    required this.id,
    this.title,
    this.body,
    this.payload,
    // ignore: unused_element
    this.imageUrl,
  });

  factory ReceivedNotification.fromLocal({
    required String title,
    int? id,
    String? body,
    Map<String, dynamic>? payload,
  }) {
    return ReceivedNotification._(
      id: id ?? -1,
      title: title,
      body: body ?? 'Clicca su questa notifica per vedere i dettagli',
      payload: payload,
    );
  }

  // Uncomment when we wanto to support push notifications
  // factory ReceivedNotification.fromRemoteMessage(RemoteMessage message) {
  //   return ReceivedNotification._(
  //     id: message.hashCode,
  //     title: message.notification?.title,
  //     body: message.notification?.body,
  //     payload: message.data,
  //   );
  // }

  final int id;
  final String? title;
  final String? body;
  final String? imageUrl;
  final Map<String, dynamic>? payload;
}
