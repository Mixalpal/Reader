import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_application_1/data/review.dart';

class ReviewRepository {
  late FirebaseFirestore db;

  ReviewRepository() {
    db = FirebaseFirestore.instance;
  }

  Future<List<Review>> getReviewsList(List<String> ids) async {
    List<Review> result = [];
    ids.forEach((element) async {
      result.add(await getReview(element));
    });
    return result;
  }

  Future<Review> getReview(String uid) async {
    DocumentSnapshot _snap = await db.collection('review').doc(uid).get();
    return Review.fromMap(_snap.data() as Map<String, dynamic>, uid);
  }

  void update(Review review) {
    db.collection('review').doc(review.id).set(review.toMap()).then(
        (value) => log("Review updated successfully!"),
        onError: (e) => log("Error updating review: $e"));
    return;
  }

  String createReview(Review review) {
    DocumentReference docReference = db.collection('review').doc();
    docReference.set(review.toMap()).then((doc) {
      log('Created a review with id: ${docReference.id}');
    });
    return docReference.id;
  }
}
