import 'dart:async';

import 'package:ecommerce_app/app/data/models/user_model.dart';
import 'package:ecommerce_app/app/domain/services/cart_service.dart';
import 'package:ecommerce_app/app/domain/services/favorites_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final _user = Rx<UserModel?>(null);

  UserModel? get user => _user.value;
  Rx<UserModel?> get userStream => _user;

  Future<AuthService> init() async {
    // This is awaited by Get.putAsync in InitializationService
    await _handleAuthChanged(_firebaseAuth.currentUser);

    // This listens for subsequent changes after app startup
    _firebaseAuth.authStateChanges().listen((user) {
      _handleAuthChanged(user);
    });
    return this;
  }

  Future<void> _fetchAndSetUser(User firebaseUser) async {
    try {
      final snapshot = await _database.ref('users/${firebaseUser.uid}').get();
      if (snapshot.exists) {
        final userData = Map<String, dynamic>.from(snapshot.value as Map);
        _user.value = UserModel(
          uid: firebaseUser.uid,
          name: firebaseUser.displayName ?? '',
          email: firebaseUser.email ?? '',
          role: userData['role'] ?? 'user',
        );
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Set user to null or handle error as needed if fetching fails
      _user.value = null;
    }
  }

  Future<void> _handleAuthChanged(User? firebaseUser) async {
    if (firebaseUser != null) {
      await _fetchAndSetUser(firebaseUser);
    } else {
      _user.value = null;
    }
  }

  Future<UserModel?> login(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    if (userCredential.user != null) {
      final snapshot =
          await _database.ref('users/${userCredential.user!.uid}').get();
      if (snapshot.exists) {
        final userData = Map<String, dynamic>.from(snapshot.value as Map);
        return UserModel(
          uid: userCredential.user!.uid,
          name: userCredential.user!.displayName ?? '',
          email: userCredential.user!.email ?? '',
          role: userData['role'] ?? 'user',
        );
      }
    }
    return null;
  }

  Future<void> signup(
      String name, String email, String password, String role) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.updateDisplayName(name);
    await _database.ref('users/${userCredential.user?.uid}').set({
      'name': name,
      'email': email,
      'role': role,
    });
    _user.value = UserModel(
      uid: userCredential.user!.uid,
      name: name,
      email: email,
      role: role,
    );
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    Get.find<CartService>().clearCartLocal();
    Get.find<FavoritesService>().clearFavoritesLocal();
  }
}
