import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseTransactionDataSource {
  final FirebaseFirestore firestore;

  FirebaseTransactionDataSource(this.firestore);

  Stream<QuerySnapshot> getTransactions({
    required String userId,
    required String filter,
  }) {
    Query query = firestore
        .collection('transactions')
        .where('userId', isEqualTo: userId);

    if (filter != 'all') {
      query = query.where('type', isEqualTo: filter);
    }

    return query.snapshots();
  }
}
