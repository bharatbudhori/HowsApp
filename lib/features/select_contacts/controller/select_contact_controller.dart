import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:howsapp/features/select_contacts/repository/select_contact_repository.dart';

final getContactProvider = FutureProvider((ref) {
  final selectContactRepository = ref.watch(selectContactRepositoryProvider);
  return selectContactRepository.getContacts();
});
