
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/Images.dart';
import '../utils/MyColors.dart';

 class ProfileImage extends StatelessWidget {
   final String? imageUrl;
 final double size;

  ProfileImage({
    required this.imageUrl,
    this.size=150,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: appPrimaryColor,

      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: imageUrl==''?Image.asset(
            place_avatar,
            fit: BoxFit.cover,
            height: size,
            width: size,
          ): CachedNetworkImage(
            imageUrl: "$imageUrl",
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Image.asset(
              place_avatar,
              fit: BoxFit.cover,
              height: size,
              width: size,
            ),
            fit: BoxFit.cover,
            height: size,
            width: size,
          ),

        ),
      )
     );


  }
}
