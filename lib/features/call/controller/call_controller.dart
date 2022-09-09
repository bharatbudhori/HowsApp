import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howsapp/features/auth/controller/auth_controller.dart';
import 'package:howsapp/features/call/repository/call_repository.dart';

import 'package:howsapp/models/call.dart';
import 'package:uuid/uuid.dart';

final callControllerProvider = Provider((ref) {
  final callRepository = ref.read(callRepositoryProvider);
  return CallController(
    callRepository: callRepository,
    auth: FirebaseAuth.instance,
    ref: ref,
  );
});

class CallController {
  final CallRepository callRepository;
  final ProviderRef ref;
  final FirebaseAuth auth;

  CallController({
    required this.callRepository,
    required this.ref,
    required this.auth,
  });

  Stream<DocumentSnapshot> get callStream => callRepository.callStream;

  void makeCall(
    BuildContext context,
    String recieverName,
    String recieverUid,
    String recieverProfilePic,
    bool isGroupCall,
  ) {
    ref.read(userDataAuthProvider).whenData((value) {
      String callId = const Uuid().v1();
      Call senderCallData = Call(
        callerId: auth.currentUser!.uid,
        callerName: value!.name,
        callerPic: value.profilePic,
        receiverId: recieverUid,
        receiverName: recieverName,
        receiverPic: recieverProfilePic,
        callId: callId,
        hasDialled: true,
      );

      Call receiverCallData = Call(
        callerId: auth.currentUser!.uid,
        callerName: value.name,
        callerPic: value.profilePic,
        receiverId: recieverUid,
        receiverName: recieverName,
        receiverPic: recieverProfilePic,
        callId: callId,
        hasDialled: false,
      );

      callRepository.makeCall(
        senderCallData,
        receiverCallData,
        context,
      );
    });
  }

  void endCall(
    String calllerId,
    String receiverId,
    BuildContext context,
  ) {
    callRepository.endCall(calllerId, receiverId, context);
  }
}
