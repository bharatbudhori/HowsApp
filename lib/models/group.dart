class Group{
  final String senderId
  final String name;
  final String groupId;
  final String lastMessage;
  final String profilePic;
  final String groupPic;
  final List<String> membersUid;

  Group({
    required this.senderId,
    required this.name,
    required this.groupId,
    required this.lastMessage,
    required this.profilePic,
    required this.groupPic,
    required this.membersUid,
  });


  
}