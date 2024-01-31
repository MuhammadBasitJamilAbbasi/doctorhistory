import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorhistory/Screens/Addpatients.dart';
import 'package:doctorhistory/Screens/Models/PaitentModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ApiService{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late ProgressDialog _progressDialog=ProgressDialog(context: Get.context!);

  Future<bool> addPatients(PaitentModel patientModel, BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('patients')
          .where('pphone', isEqualTo: patientModel.pphone)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Phone number already exists, return false

        return false;
      }
      await _firestore.collection('patients').doc(patientModel.pphone).set(patientModel.toMap());
      return true;
    } catch (error) {
      // Handle error
      print('Error adding patient: $error');
      throw error;
    }
  }

  Future<List<PaitentModel>> loadPatients() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('patients').get();
      List<PaitentModel> patients = querySnapshot.docs.map((doc) {
        return PaitentModel.fromJson(doc.data() as Map<String, dynamic>);}).toList();
      return patients;
    } catch (error) {
      // Handle error
      print('Error loading patients: $error');
      throw error;
    }
  }




}