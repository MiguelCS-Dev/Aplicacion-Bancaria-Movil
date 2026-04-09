import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTransactionDataSource {
  final FirebaseFirestore firestore;

  FirebaseTransactionDataSource(this.firestore);

  DocumentSnapshot? lastDocument;

  Future<List<DocumentSnapshot>> getTransactions({
    required String userId,
    required String filter,
    int limit = 10,
    bool loadMore = false,
  }) async {
    Query query = firestore
        .collection('transactions')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .limit(limit);

    if (filter != 'all') {
      query = query.where('type', isEqualTo: filter);
    }

    if (loadMore && lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    final snapshot = await query.get();

    if (snapshot.docs.isNotEmpty) {
      lastDocument = snapshot.docs.last;
    }

    return snapshot.docs;
  }
}
