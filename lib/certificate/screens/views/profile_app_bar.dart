import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Services/FactoryContract.dart';
import '../../model/user_model.dart';
import '../utils/MyColors.dart';
import '../utils/Widgets.dart';
import 'my_text.dart';
import 'profile_image.dart';

class ProfileAppBar extends StatelessWidget {
  final UserCertModel? userCertModel;

  ProfileAppBar({
    required this.userCertModel,
   });

  @override
  Widget build(BuildContext context) {

    var contractFactory = Provider.of<FactoryContract>(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        horizontalSpace25,
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ProfileImage(
            size: 80,
            imageUrl: userCertModel?.userImage,

          ),
        ),
        horizontalSpace10,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myDivider(),
              verticalSpace15,
              MyText(
                "${contractFactory.ownAddress}",
                color: myTextColorPrimary,
                fontSize: 20,
                decoration: TextDecoration.underline,

              ),
              MyText(
                "Balance",
                color: myTextColorSecond,
                fontSize: 11,
                decoration: TextDecoration.underline,

              ),
              MyText(
                "${contractFactory.myBalance} BNB",
                color: myTextColorSecond,
                fontSize: 11,
                decoration: TextDecoration.underline,

              ),
              myDivider(),

            ],
          ),
        ),
      ],
    );
  }
}
