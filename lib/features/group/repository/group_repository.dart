import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howsapp/common/repository/common_firebase_storage_repository.dart';
import 'package:howsapp/common/utils/utils.dart';
import 'package:howsapp/models/group.dart' as model;
import 'package:uuid/uuid.dart';

class GroupRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final ProviderRef ref;

  GroupRepository({
    required this.firestore,
    required this.auth,
    required this.ref,
  });

  void createGroup(
    BuildContext context,
    String name,
    File profilePic,
    List<Contact> selectedContact,
  ) async {
    try {
      List<String> uids = [];
      for (int i = 0; i < selectedContact.length; i++) {
        var userCollection = await firestore
            .collection('users')
            .where(
              'phoneNumber',
              isEqualTo: selectedContact[i].phones[0].number.replaceAll(
                    ' ',
                    '',
                  ),
            )
            .get();

        if (userCollection.docs[0].exists) {
          uids.add(userCollection.docs[0].data()['uid']);
        }

        var groupId = const Uuid().v1();

        String profilePicUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFiletoFirebase(
              'group/$groupId',
              profilePic,
            );

        model.Group group = model.Group(
          senderId: auth.currentUser!.uid,
          name: name,
          groupId: groupId,
        );
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
