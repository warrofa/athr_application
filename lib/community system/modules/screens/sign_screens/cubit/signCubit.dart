import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../models/user_model.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/local_network.dart';
import 'signStates.dart';


class SignCubit extends Cubit<SignStates>{
  SignCubit() : super(InitialSignState());
  // method to get cubit from state that call it
  static SignCubit get(BuildContext context)=>BlocProvider.of(context);

  File? userImageFile;
  final pickerImage = ImagePicker();
  Future<void> getUserImageFile() async{
    final pickedImage = await pickerImage.pickImage(source: ImageSource.gallery);
    if(pickedImage != null)
    {
      userImageFile = File(pickedImage.path);
      emit(ChosenUserImageSuccessfullyState());
    }
    else
    {
      emit(ChosenUserImageErrorState());
    }
  }

  // Method to Create User throw FirebaseAuth
  void createUser({required String email,required String password,required String userName,required String phoneNumber}) async {
    emit(CreateUserLoadingState());
    // createUserWithEmailAndPassword return UserCredential (( Future type ))
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((val) async {
      emit(CreateUserSuccessState());
      await CacheHelper.saveCacheData(key: 'uid', val: val.user!.uid);    // to save User ID on Cache to go to home directly second time
      userID = await CacheHelper.getCacheData(key: 'uid');
      saveUserData(userName: userName, email: email, uid: val.user!.uid,phoneNumber: phoneNumber);      // save UserData on Cloud FireStore
    }).catchError((e){
      debugPrint(e.toString());
      emit(CreateUserErrorState(e.toString()));
    });
  }

  UserModel? userLoginData;
  // Method to save UserData on cloud fireStore
  void saveUserData({required String userName,required String email,required String uid,required String phoneNumber}) async {
    emit(SaveUserDataLoadingState());
    await FirebaseStorage.instance.ref()
    .child("users/${Uri.file(userImageFile!.path).pathSegments.last}")
    .putFile(userImageFile!)
    .then((val){
      val.ref.getDownloadURL().then((imageUrl) async {
        debugPrint(imageUrl);
        UserModel model = UserModel(userName:userName,email: email,userID: uid,image: imageUrl,phoneNumber: phoneNumber);
        await FirebaseFirestore.instance.collection('users').doc(uid).set(model.toJson()).then((value){
          emit(SaveUserDataSuccessState());
        });
      });
    }).catchError((error){emit(SaveUserDataErrorState(error));});
  }

  // Method to Sign In to App using Email & Password that stored on Cloud fireStore
  Future<void> userLogin({required String email,required String password}) async {
    emit(UserLoginLoadingState());
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
        CacheHelper.saveCacheData(key: 'uid', val: value.user!.uid);
        emit(UserLoginSuccessState());
      }).catchError((onError){
        debugPrint("Error during login to Athr, reason is : $onError");
        emit(UserLoginErrorState(onError.toString()));
      });
    } catch(error){
      debugPrint("Error during login to Athr, reason is : $error");
      emit(UserLoginErrorState(error.toString()));
    }
  }

}