import 'package:flutter/material.dart';
import 'package:music_fl/controllers/player_controller.dart';
import 'package:music_fl/views/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../consts/colors.dart';
import '../consts/text_style.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
        backgroundColor: bgDarkColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: whiteColor,
                ))
          ],
          leading: Icon(
            Icons.sort_rounded,
            color: whiteColor,
          ),
          title: Text("Meow",
              style: ourStyle(
                family: bold,
                size: 18,
              )),
        ),
        body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
            ignoreCase: true,
            orderType: OrderType.ASC_OR_SMALLER,
            sortType: null,
            uriType: UriType.EXTERNAL,
          ),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error: ${snapshot.error}",
                  style: ourStyle(),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "No songs found",
                  style: ourStyle(),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final song = snapshot.data![index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: Obx(
                          ()=>  ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          tileColor: bgColor,
                          title: Text(
                            song.title, // Display song title
                            style: ourStyle(
                              family: bold,
                              size: 15,
                            ),
                          ),
                          subtitle: Text(
                            song.artist ?? "Unknown artist",
                            // Display artist name
                            style: ourStyle(
                              family: regular,
                              size: 12,
                            ),
                          ),
                          leading: QueryArtworkWidget(
                            id: snapshot.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: const Icon(Icons.music_note,
                            color: whiteColor,
                            size: 32,),
                          ),
                        trailing: controller.playIndex.value==index &&controller.isPlaying.value ?Icon(Icons.play_arrow, color: whiteColor, size: 26,)
                          :null,
                          onTap: (){
                            Get.to (()=>Player(data: snapshot.data!,));
                            controller.playSong(snapshot.data![index].uri, index);
                          },
                                            ),
                      ),);
                  },
                ),
              );
            }
          },
        ));
  }
}
