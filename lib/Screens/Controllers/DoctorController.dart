
import 'dart:async';

import 'package:doctorhistory/Screens/Apiservice.dart';
import 'package:doctorhistory/Screens/Models/PaitentModel.dart';
import 'package:doctorhistory/Screens/widgets/ErrorhandlingDialoge.dart';
import 'package:doctorhistory/Screens/widgets/Snakebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class DoctorController extends GetxController{
  final ApiService _apiService = ApiService();
  RxString  selectedDate="".obs;
  String imageurl="";
  final RxList<PaitentModel> patients = <PaitentModel>[].obs;
     RxInt count=0.obs;
     late Timer _timer;
     @override
  void onInit() {
    super.onInit();
    loadPatients();
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _timer=Timer.periodic(Duration(seconds: 1), (timer) {
         count+100;
    });

  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
     Future<void> loadPatients() async {
       patients.clear();
       try {
         patients.value = await _apiService.loadPatients();
       } catch (error) {
         // Handle error
         print('Error loading patients: $error');
         Get.snackbar(
           'Error',
           'Failed to load patients',
           snackPosition: SnackPosition.BOTTOM,
         );
       }
     }


  Future<void> addPatient(PaitentModel patientModel,BuildContext context) async {
    try {
      ProgressDialog _progressDialog = ProgressDialog(context: context);

      // Show progress dialog
      _progressDialog.show(msg: "Sending Wait...");

      // Create a patient model from user inputs


      // Call the API service to add the patient
      bool success = await _apiService.addPatients(patientModel,context);
      _progressDialog.close();

      // Close progress dialog


      // Show success/failure dialog based on API response
      if (success) {
        loadPatients();
        Get.back();
      } else {
        //showErrorMessage("Phonenumber Already taken Please use Unique Phonenumber ", context);
        ErrorhandlingDialoge(context,'Fail','Phone number Already taken please use Unique','F');
      }
    } catch (error) {
      // Handle error
      print('Error during sending: $error');
      ErrorhandlingDialoge(context,'New Patient','Fail to added Patient','F');
    }
  }





}