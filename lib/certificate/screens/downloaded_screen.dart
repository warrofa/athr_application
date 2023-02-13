

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simpleui/certificate/screens/utils/Widgets.dart';
import 'package:simpleui/certificate/screens/views/profile_app_bar.dart';
import '../model/certificate_model.dart';
import '../services/provider/home_provider.dart';
import 'utils/MyColors.dart';
import 'utils/constants.dart';
import 'views/full_button.dart';
import 'widgets/download_item.dart';
class DownloadedScreen extends StatelessWidget {

 final CertificateModel products ;


 const DownloadedScreen({required this.products});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder:
        (BuildContext? context, HomeProvider? homeProvider, Widget? child) {
      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              ProfileAppBar(
                userCertModel: homeProvider?.userData,
              ),

              verticalSpace20,

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    DownloadItem(
                        certificatesModel: products,
                    ),
                    verticalSpace20,

                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),

                      constraints: const BoxConstraints(maxWidth: 180.0),
                      child: FullButton(
                        onPressed: () async {
                          String fullImageUrl = basePinateUrl+products.image;
                          await homeProvider?.downloadCertificate(fullImageUrl);

                        },
                        textContent: 'Download certificate',
                        iconData: FontAwesomeIcons.download,
                        textColor: appPrimaryColor,
                        color: appPrimaryColor?.withOpacity(.1),
                      ),
                    )
                  ],
                ),
              ),


            ],
          ),
        ),
      );
    });
  }
}
