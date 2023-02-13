
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Services/FactoryContract.dart';

import '../../services/provider/home_provider.dart';
import '../downloaded_screen.dart';
import '../utils/MyColors.dart';
import '../utils/Widgets.dart';
import '../views/full_button.dart';
import '../widgets/education_item.dart';

class EducationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var contractFactory = Provider.of<FactoryContract>(context);
    var homeProvider = Provider.of<HomeProvider>(context);

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: FutureBuilder<dynamic>(
              future: contractFactory.getFilteredUserProducts("Education"),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData) {
                  return Center(
                    child: emptyWidget(context, text: 'Education list is empty'),
                  );
                }
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    
                    return EducationItem(
                        certificatesModel: snapshot.data[index],
                        isSelected: false,
                        onTap: () async {

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DownloadedScreen(products:snapshot.data[index],),
                            ),
                          );

                        });
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return verticalSpace20;
                  },
                );
              },
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          constraints: BoxConstraints(maxWidth: 180.0),
          child: FullButton(
            onPressed: () async {
              await homeProvider.showAddCertificateDialog(context, "Education");



            },
            textContent: 'Upload certificate',
            iconData: FontAwesomeIcons.upload,
            textColor: appPrimaryColor,
            color: appPrimaryColor?.withOpacity(.1),
          ),
        ),
      ],
    );
  }
}
