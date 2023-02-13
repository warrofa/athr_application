
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

const appFontSize = 14.0;

Future<String?> getPrivateKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var prKey = prefs.getString("privateKey");
  return prKey;
}
//Social Media Links

String facebookUrl = "https://www.facebook.com/talesinhome/";
String twitterUrl = "https://www.twitter.com/talesinhome/";
String pinterestUrl = "https://www.pinterest.com/talesinhome";
String youtubeUrl = "https://www.youtube.com/channel/UCFetjWniBaUOr0fwabpXsUg";
String instagramUrl = "https://www.instagram.com/talesinhome/";

const pinataAPIKEY = '88746cf369df6f06da30';
const pinataSECRETKEY = '791ea26d97f42fa7b7b98a19924e0d13587c8bc1c66180660b1a048e1a892f85';
const uriFile = 'https://api.pinata.cloud/pinning/pinFileToIPFS';
const uri = 'https://api.pinata.cloud/pinning/pinJSONToIPFS';
//Your Email
String email = "info@taleshome.com";
String baseUrl = 'https://testnet.bscscan.com//address/';
String basePinateUrl = 'https://athr.mypinata.cloud/ipfs/';

class Constants {
  //Change the main color
  final mainColor = const Color(0xff323144);
  final goldCustomColor = const Color(0xffF1B553);
  final orangeCustmColor= const Color(0xffEFBA40);
  final bGcustmColor = const Color(0xffFEFEFF);
  final whitecustmColor =const  Color(0xfffFFFFF);
  final blackcustmColor = const Color(0xff272F42);
  final bluecustmColor = const Color(0xff6664E9);
  final redcustmColor = const Color(0xfff03030);
  final greencustmColor = const Color(0xffAFDE4D);
  final greycustmColor = const Color(0xffCACDE8);
  final redLightcustomColor =const  Color(0xffFEDEDF);
  final gryDarkCustom =const  Color(0xff707070);

  // ignore: non_constant_identifier_names
  String PINATA_URL = "https://gateway.pinata.cloud/ipfs/";
  //Change the title style
  static TextStyle titleStyle = const TextStyle(
    color: Color(0xff3f3d56),
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
//Change the title style
  final TextStyle descriptionStyle = const TextStyle(
    color: Color(0xff3f3d56),
    fontSize: 15,
  );

  final List<String> categoryList = <String>[
    'Game',
    'NFT Art',
    'Binary options',
    'NFT Marketplaces',
    'Metaverse',
    'Meta Casino',
    'Meta School',
    'SandBox',
    'Meta Museum'
  ];

  final List<String> categoryListImages = <String>[
    'images/games.png',
    'images/NFTart.png',
    'images/BinaryOptions.png',
    'images/Marketplace.png',
    'images/Metaverse.png',
    'images/MetaCasino.png',
    'images/MetaSchool.png',
    'images/Sandbox.png',
    'images/MetaMuseum.png',
  ];

  String infoParagraph = """
Lorem Ipsum is simply dummy text of the printing 
and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release 
of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
""";

  urlLauncher(String owner)async {
    final Uri url = Uri.parse(baseUrl + owner);

    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  customUrlLaunch(String baseurl) async{
    final Uri url = Uri.parse(baseurl);

    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
