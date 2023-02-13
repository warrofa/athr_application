import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/certificate_model.dart';
import '../utils/Images.dart';
import '../utils/Widgets.dart';
import '../utils/constants.dart';
import '../views/my_text.dart';

class EducationItem extends StatelessWidget {
  final CertificateModel certificatesModel;
  final GestureTapCallback onTap;
  final bool isSelected;

  const EducationItem({
    required this.certificatesModel,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: (){


      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyText(
              certificatesModel.name,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            isSelected
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(


                    imageUrl:
                    basePinateUrl+"${certificatesModel.image}",
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Image.asset(
                        icon_holder,
                        fit: BoxFit.cover,
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                      ),
                      fit: BoxFit.cover,
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                    ),
                  )
                : Container(),
            verticalSpace5,
            MyText(
              "${certificatesModel.urlSite}",
              fontSize: 12,
              color: Colors.black45,
              maxLines: 2,
            ),
            myDivider(),
            MyText(
              "${certificatesModel.date}",
              fontSize: 12,
              color: Colors.black45,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
