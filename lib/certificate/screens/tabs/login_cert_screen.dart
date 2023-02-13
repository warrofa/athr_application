
import 'package:flutter/material.dart';
import 'package:simpleui/main.dart';

import 'package:web3dart/web3dart.dart';

import '../../../community system/layout/cubit/layout_cubit.dart';
import '../../../constant.dart';
import '../../Services/FactoryContract.dart';
import 'package:provider/provider.dart';

import '../../services/provider/home_provider.dart';

import '../utils/Widgets.dart';
import '../views/my_button.dart';
import '../views/my_text.dart';
import '../views/profile_app_bar.dart';


class CertificateLoginScreen extends StatefulWidget {


  const CertificateLoginScreen({super.key});

  @override
  State<CertificateLoginScreen> createState() => _CertificateLoginScreenState();
}

class _CertificateLoginScreenState extends State<CertificateLoginScreen> {
  final TextEditingController privateKeyTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final LayoutCubit cubit = LayoutCubit.getInstance(context);
    var contractFactory = Provider.of<FactoryContract>(context);

    return Scaffold(
      body: Consumer<HomeProvider>(
      builder:
          (BuildContext? context, HomeProvider? homeProvider, Widget? child) {
        return SingleChildScrollView(
          child: Column(
            children: [
              ProfileAppBar(
                userCertModel: homeProvider?.userData,
              ),
              verticalSpace15,
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 40),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey, width: .5),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      
                      
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(children: [IconButton(onPressed: (){
                            cubit.changeBottomNavIndex(0);
                            Navigator.pushReplacementNamed(context!, 'home_layout_screen');
                          }, icon: const Icon(Icons.close))],),
                         Image.asset(ImageConstant.metaMaskLogo,width: 200,),
                          verticalSpace15,
                          MyText(
                            'Enter private key to access your',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            maxLines: 1,
                          ),
                          MyText(
                            ' achievement list',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            maxLines: 1,
                          ),
                          verticalSpace15,
                          TextFormField(
                            controller:privateKeyTextField ,
                            
                            
                            enableInteractiveSelection: true,
                            
                            textCapitalization: TextCapitalization.sentences,
                            
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 8.0),
                              alignLabelWithHint: true,
                              isCollapsed: false,
                            ),
                          ),
                          verticalSpace30,
                          Container(
                            constraints: const BoxConstraints(maxWidth: 120.0),
                            child: MyButton(
                              onPressed: () async {
                                if(checkPrivateKey(privateKeyTextField.text))
                                {
                                  prKey = privateKeyTextField.text;
                                  contractFactory.savePrivateKey(privateKeyTextField.text);          //will take the private key and then save it
                                  Navigator.pushReplacementNamed(context!, "cert_home_screen");
                                }
                               
                              },
                              textContent: 'Connect',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
  bool checkPrivateKey(String key){

    return true;

  }
}
