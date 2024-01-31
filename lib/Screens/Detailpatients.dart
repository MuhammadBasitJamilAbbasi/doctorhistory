import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorhistory/Screens/Addvisitissue.dart';
import 'package:doctorhistory/Screens/Models/PaitentModel.dart';
import 'package:doctorhistory/Screens/Models/VisitModel.dart';
import 'package:doctorhistory/Screens/values/Appconstants.dart';
import 'package:doctorhistory/Screens/widgets/paitentdetailswidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPaitent extends StatelessWidget{
  PaitentModel model;
  List<VisitModel> newvisits=[];
  DetailPaitent( {required this.model});


  Future<List<VisitModel>> loadCheckinsForPatient(String pid) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      var collectionRef = firestore.collection('CHECKUPS');
      var docRef = collectionRef.doc(pid);
      var subCollectionRef = docRef.collection('CHECKIN');
      var querySnapshot = await subCollectionRef.get();
        List<VisitModel> visits = querySnapshot.docs.map((doc) {return VisitModel.fromMap(doc.data());}).toList();
        return visits;



    } catch (e) {
      // Error loading check-ins
      print(e.toString());
      return [];
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        onPressed: (){Get.to(Addvisitissues(id: model.pphone,));},
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    new BoxShadow(color: Colors.white, offset: new Offset(6.0, 6.0),),
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                            Appconstants.appname,
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
                          Appconstants.slogon,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  paitentdetailswidget(title: 'Name',values: model.pname,),
                  paitentdetailswidget(title: 'Phone',values: model.pphone,),
                  paitentdetailswidget(title: 'Age',values: model.page,),
                  paitentdetailswidget(title: 'Create Date',values: model.createdate,),
                    Divider(),

                    Expanded(
                      child: FutureBuilder(
                        future: loadCheckinsForPatient(model.pphone),
                        builder: (context,snapshot){
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            // If the Future is still running, show a loading indicator
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            // If there is an error, show an error message
                            return Center(child: Text('Error: ${snapshot.error}'));
                          }
                          else
                            {
                              List<VisitModel>? visitlist=snapshot.data;
                              if(visitlist!.length>0)
                                {
                                  return ListView.builder(itemBuilder: (context,index)
                                  {
                                    return Card(
                                      color: Colors.white,
                                      surfaceTintColor:Colors.white ,
                                      child: ListTile(
                                        leading: Icon(Icons.visibility),
                                        trailing: Icon(Icons.chevron_right),

                                        title: Text(visitlist[index].entryDate.toString() ),
                                      ),
                                    );
                                  },itemCount:visitlist!.length,);
                                }
                              else{
                                return Center(child: Text("No Data Found"));
                              }

                            }

                        },

                    ),
                    ),




                  ],
                        ),
              ),
            ),
      ),
    );
  }

}