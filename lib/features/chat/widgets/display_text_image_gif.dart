import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:howsapp/common/enums/message_enum.dart';
import 'package:howsapp/features/chat/widgets/video_player_item.dart';
import 'package:audioplayers/audioplayers.dart';

class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;

  const DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    final AudioPlayer audioPlayer = AudioPlayer();
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.audio
            ? IconButton(
                constraints: const BoxConstraints(
                  minWidth: 100,
                ),
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    await audioPlayer.play(UrlSource(message));
                  }
                },
                icon: const Icon(Icons.play_circle),
              )
            : type == MessageEnum.video
                ? VideoPlayerItem(
                    videoUrl: message,
                  )
                : CachedNetworkImage(
                    imageUrl: message,
                    fit: BoxFit.cover,
                  );
  }
}
