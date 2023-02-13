
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../services/provider/home_provider.dart';
import '../utils/Widgets.dart';
import '../views/edit_text.dart';
import '../views/my_button.dart';
import '../views/my_text.dart';

class AddCertificateDialog extends StatelessWidget {

  final String category;

  AddCertificateDialog(this.category);




  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder:
        (BuildContext? context2, HomeProvider homeProvider, Widget? child) { return myAlert(
      content: Container(
        width: MediaQuery.of(context).size.width,

        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpace15,

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                  Flexible(
                    child: MyText(
                      'Enter the URL of issuing certificate organisation',
                      color: Colors.black87,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      maxLines: 3,
                    ),
                  ),
                   GestureDetector(
                     onTap: (){
                       Navigator.pop(context);
                     },
                    child: const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        FontAwesomeIcons.close,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),

              verticalSpace5,
              MyEditText(
                controller: homeProvider.tEUrlController,


              ),

              verticalSpace15,


              MyText(
                'Enter certificate name',
                color: Colors.black87,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),

              verticalSpace5,
              MyEditText(
                controller: homeProvider.tENameController,


              ),
              verticalSpace15,

              MyText(
                'Enter certificate date',
                color: Colors.black87,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),

              verticalSpace5,
              MyEditText(
                 readOnly: true,
                 onTap: () => homeProvider.selectDate(context),
                controller: homeProvider.checkDateCon,

              ),

              verticalSpace15,

              MyText(
                'Only accepted formats are : pdf , png , jpeg',
                 fontSize: 11.0,
               ),

              verticalSpace15,
              GestureDetector(
                onTap: (){
                  homeProvider.pickImage(context).then((value) => {
                    if (value['status'] == 'success')
                      homeProvider.setSelectIMageCID (value["IpfsHash"]) ,
                  });

                },
                child: SizedBox(
                  height: 120,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    dashPattern: [6, 6],

                    radius: const Radius.circular(12),
                     child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      child: Stack(
                        children: [


                          Container(
                            padding: const EdgeInsets.all(20.0),

                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[100],

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                 const Icon(
                                   FontAwesomeIcons.arrowUp,
                                   size: 30,
                                  ),
                                 verticalSpace5,

                                 MyText(
                                  'Upload certificate',
                                  fontSize: 15.0,
                                  decoration: TextDecoration.underline,

                                ),
                              ],
                            ),
                          ),
                          homeProvider.selectedImageFile==null?Container(): ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.file(
                              homeProvider.selectedImageFile!,
                              fit: BoxFit.cover,
                              height: 120,
                              width: MediaQuery.of(context).size.width,

                              // width: 500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpace20,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(

                    onPressed: () {
                    

                      homeProvider.addCertificate(context,category).then((value) {
                        homeProvider.resetForm();
                         Navigator.pop(context);

                      });

                    },
                    textContent: 'Save',
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );   },
    );
  }

}
//140
