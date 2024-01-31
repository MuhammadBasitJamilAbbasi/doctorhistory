import 'package:doctorhistory/Screens/Apiservice.dart';
import 'package:doctorhistory/Screens/Controllers/DoctorController.dart';
import 'package:doctorhistory/Screens/Models/PaitentModel.dart';
import 'package:doctorhistory/Screens/widgets/Snakebar.dart';
import 'package:doctorhistory/Screens/widgets/app_text_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Addpaitents extends StatefulWidget{
  @override
  State<Addpaitents> createState() => _AddpaitentsState();
}

class _AddpaitentsState extends State<Addpaitents> {
  var controller=Get.put(DoctorController());

  TextEditingController patientnameController = TextEditingController();
  TextEditingController paitentphoneController = TextEditingController();
  TextEditingController paitentageController = TextEditingController();
  String selectedDate = "";

  // Show progress dialog
  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime lastSelectableDate = currentDate.subtract(Duration(days: 25));
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: lastSelectableDate,
      lastDate: currentDate,
    );

    if (picked != null && picked != currentDate) {
      selectedDate = '${picked}'.split(' ')[0];
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
body:  SafeArea(
  child: Padding(
    padding: const EdgeInsets.all(14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                  'Paitents',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.black,
                      fontSize: 34,
                      fontWeight: FontWeight.bold
                  )
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                'Create new  Paitent',
                style: Theme.of(context).textTheme.bodySmall,
              ),

            ],
          ),
          const SizedBox(
            height: 10,
          ),
          AppTextFormField(
            labelText: 'PATENT NAME',
            keyboardType: TextInputType.name,
            controller: patientnameController,
          ),
          AppTextFormField(
            controller:paitentphoneController ,
            keyboardType: TextInputType.number,
           labelText: 'Patent Phone',
          ),
          AppTextFormField(
            labelText: 'PATENT AGE',
            keyboardType: TextInputType.number,
            controller: paitentageController,
          ),

          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: selectedDate.isNotEmpty
                        ? Text(
                      selectedDate,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 8,
                      ),
                    )
                        : Text(
                      "Please Select Transaction Date",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          FilledButton(
            onPressed: (){
              if(patientnameController.text.isEmpty)
              {
                showErrorMessage("Please Enter Patent name",context);

              }else if(paitentphoneController.text.isEmpty)
              {
                showErrorMessage("Please Enter Phone",context);
              }
              else if(paitentageController.text.isEmpty)
              {
                showErrorMessage("Please Enter Age",context);
              }
              else
                {
                 var patientModel= PaitentModel(pname: patientnameController.text, pphone: paitentphoneController.text, page: paitentageController.text, createdate: selectedDate);
                  controller.addPatient(patientModel, context);
                }


            },

            child: Text("Submit"),

          ),
        ],
      ),
  ),
),

   );
  }
}