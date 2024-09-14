import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:manage_orders/core/provider/firebase_provider.dart';

final storageRepositoryProvider = Provider((ref) => StorageRepository(
      firebaseStorage: ref.watch(storageProvider),
    ));

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;
}
