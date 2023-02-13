import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simpleui/main.dart';
import '../../community system/layout/cubit/layout_cubit.dart';
import '../Services/FactoryContract.dart';
import '../services/provider/home_provider.dart';
import 'profile_tabs/awards_screen.dart';
import 'profile_tabs/education_screen.dart';
import 'profile_tabs/licences_screen.dart';
import 'utils/MyColors.dart';
import 'utils/Widgets.dart';
import 'views/profile_app_bar.dart';

class CertificateHomeScreen extends StatefulWidget {
  const CertificateHomeScreen({super.key});

  @override
  State<CertificateHomeScreen> createState() => _CertificateHomeScreenState();
}

class _CertificateHomeScreenState extends State<CertificateHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var contractFactory = Provider.of<FactoryContract>(context);
     final LayoutCubit cubit = LayoutCubit.getInstance(context);
    return Consumer<HomeProvider>(builder:
        (BuildContext? context, HomeProvider? homeProvider, Widget? child) {
      return Scaffold(
        appBar: AppBar(
          
          leading: IconButton(icon: const Icon(Icons.arrow_back),onPressed: (){ 
            cubit.changeBottomNavIndex(0);
            Navigator.pushReplacementNamed(context!, 'home_layout_screen');
            },),
          actions: [TextButton(onPressed:() {
            prKey = "";
            contractFactory.resetPrivateKey();
            cubit.changeBottomNavIndex(0);
            Navigator.pushReplacementNamed(context!, 'home_layout_screen');
          }, child: const Text("Exit"))],
        ),
         body: SafeArea(
          
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ProfileAppBar(
                userCertModel: homeProvider?.userData,
               ),
              verticalSpace20,
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        constraints: const BoxConstraints(maxHeight: 150.0),
                        color: Colors.grey[300],
                        child: TabBar(
                          indicatorColor: appPrimaryColor,
                          labelColor: myTextColorPrimary,
                          isScrollable: false,
                          indicator: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(color: Colors.black, width: 1.0),
                              right: BorderSide(color: Colors.black, width: 1.0),
                              left: BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),

                          onTap: (index) async {},
                          tabs: [

                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const  Icon(
                                    FontAwesomeIcons.hatWizard,
                                    size: 20,
                                  ),
                                 horizontalSpace5,
                                  const Text('Education'),
                                ],
                              ),
                            ),

                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.star,
                                    size: 20,
                                  ),
                                  horizontalSpace5,
                                  const Text('Awards'),
                                ],
                              ),
                            ),

                            Tab(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.listCheck,
                                    size: 20,
                                  ),
                                  horizontalSpace5,
                                  const Text('Licences'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              EducationScreen(),
                              AwardsScreen(),
                              LicencesScreen(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
        ),
         ),
      );
    });
  }
}
