import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../screens/utils/constants.dart';
import '../../screens/widgets/add_certificate_dialog.dart';
import '../FactoryContract.dart';


class HomeProvider extends ChangeNotifier {


  int selectedEducationIndex = -1;

  DateTime selectedDate = DateTime.now();


  final TextEditingController tEUrlController = TextEditingController();
  final TextEditingController tENameController = TextEditingController();
  final TextEditingController checkDateCon = TextEditingController();


  UserCertModel userData = UserCertModel(
      userId: "1",
      userName: "Bahaa Taha",
      userPhone: "+202121456456",
      userImage: "https://picsum.photos/800",
      userLink: "www.link.com");

  setSelectedDate(DateTime date) {
    selectedDate = date;
    checkDateCon.text = DateFormat("dd-MM-yyyy").format(date);

    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        lastDate: DateTime.now(),
        firstDate: DateTime(1990));
    if (picked != null && picked != selectedDate) {
      setSelectedDate(picked);
    }
  }

  Future<void> addCertificate(BuildContext context,String category) async {

    var contractFactory = Provider.of<FactoryContract>(context,listen: false);

    contractFactory.addCertificate(tENameController.text,tEUrlController.text , imageCID, category,checkDateCon.text );
  }

  Future<void> downloadCertificate(String imageUrl) async {
    //proceed

    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(imageUrl);
      if (imageId == null) {
        return;
      }

    } on PlatformException catch (error) {
      print(error);
    }

  }

  void resetForm() {
    checkDateCon.text = '';
    selectedImageFile = null;
    notifyListeners();
  }

  setSelectEducation(int i) {
    selectedEducationIndex = i;
    notifyListeners();
  }

  setSelectIMageCID(String val) {
    imageCID = val;
    notifyListeners();
  }
  Future showAddCertificateDialog(BuildContext context,  String category
  ) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AddCertificateDialog(category);
      },
    );
  }
  String imageCID  ="";
  File? selectedImageFile;

  Future<Map<String, dynamic>> pickImage(
    context,
  ) async {
    final ImagePicker picker = ImagePicker();

    // FilePickerResult? result = await FilePicker.platform.pickFiles();
    XFile? result = await picker.pickImage(source: ImageSource.gallery);
    if (kDebugMode) {
      print("result $result");
    }
    if (result != null) {
      try {
        var fileName = '${DateTime.now()}';
        File file = File(result.path);

        var request = http.MultipartRequest('POST', Uri.parse(uriFile));
        request.headers['Content-Type'] = 'multipart/form-data';
        request.headers['pinata_api_key'] = pinataAPIKEY;
        request.headers['pinata_secret_api_key'] = pinataSECRETKEY;
        request.fields['name'] = fileName;
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
        var response = await request.send();
        final res = await http.Response.fromStream(response);
        if (response.statusCode != 200) {
          return {
            'status': 'fail',
          };
        } else if (response.statusCode == 200) {
          var mainBody = jsonDecode(res.body);

          if (kDebugMode) {
            print('object ${mainBody["IpfsHash"].toString()}');
          }

          return {
            'status': 'success',
            'IpfsHash': mainBody["IpfsHash"].toString(),
          };
        }
      } catch (e) {
        return {
          'status': 'fail1',
        };
      }
    } else {
      return {
        'status': 'fail2',
      };
    }
    throw {
      'status': 'fail3',
    };

  }


}

