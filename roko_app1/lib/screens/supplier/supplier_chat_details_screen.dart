import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roko_app1/models/supplier_model.dart';
// import 'package:rokoapp/app_colors/app_colors.dart';
//
// import '../../models/supplier.dart';
// import '../../models/team_member.dart';
// import '../../services/contacts_sync_list.dart';
import '../../app_colors/app_colors.dart';
import '../../shared_widgets/components/useable_functions.dart';
// import '../navigation/teams_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SupplierChatDetailsScreen extends StatefulWidget {

  SupplierModel? supplier;
  SupplierChatDetailsScreen({this.supplier});
  @override
  State<SupplierChatDetailsScreen> createState() => _SupplierChatDetailsScreenState();
}

class _SupplierChatDetailsScreenState extends State<SupplierChatDetailsScreen> {

  TextEditingController _supplierName  = TextEditingController(), _customerNbr  = TextEditingController();

  @override
  void initState() {
    super.initState();
    _supplierName.text = widget.supplier!.representativeName!;
    _customerNbr.text = "1234567";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Chatdetails",
        ),
      ),
      body: ListView(
        children:
        [
          ListTile(
            contentPadding:const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 5
            ),
            leading: CircleAvatar(
              radius: 50,
              child: Image(
                image: AssetImage(widget.supplier!.profilePicture!),
              ),
            ),
            title: Text(
              "${widget.supplier!.representativeName}",
              style: TextStyle(
                  fontSize: 25
              ),
            ),
            trailing: Icon(
                Icons.arrow_forward_ios
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                const Text(
                  "Supplier display name",
                  style: TextStyle(
                    color: AppColors.deepPurple,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  "This name is only visible to you and your team",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: _supplierName,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(

                      )
                  ),
                )
              ],

            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                const Text(
                  "Customer account number",
                  style: TextStyle(
                    color: AppColors.deepPurple,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10,),
                const Text(
                  "This will be sent to Bio Market to along with contents of your order",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: _customerNbr,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(

                      )
                  ),
                )
              ],

            ),
          ),
          GestureDetector(
            onTap: ()async{
              // if(await Permission.contacts.isGranted){
              //   AppFunctions.navigateTo(context,ContactsSyncList());
              // }else{
              //   Permission.contacts.request()
              //       .then((value){
              //     if(value.isGranted){
              //       AppFunctions.navigateTo(context,ContactsSyncList());
              //     }else{
              //       ScaffoldMessenger.of(context).showSnackBar(
              //           const SnackBar(content: Text(
              //             "Roko App Needs access to your contacts to Add new member",
              //             style: TextStyle(
              //               color: Colors.black,
              //             ),
              //           ),backgroundColor: Colors.yellow,)
              //       );
              //     }
              //   }).catchError((e){
              //     print(e.toString());
              //   });
              // }
            },
            child:const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.add_reaction_rounded,
                  color: Colors.white,
                ),
              ),
              title: Text(
                "ADD TEAM MEMBER",
                style: TextStyle(
                    color: Colors.blue
                ),
              ),
            ),
          ),
          const Divider(),
          // ListView.separated(
          //   shrinkWrap: true,
          //   separatorBuilder: (context,index) => const Divider(),
          //   itemCount: TeamsScreen.members.length,
          //   itemBuilder: (context,index){
          //     TeamMember teamMember = TeamsScreen.members[index];
          //     return GestureDetector(
          //       onTap: (){
          //         if(index != 0){
          //           //deleteTeamMember(teamMember);
          //         }
          //       },
          //       child: ListTile(
          //         leading: CircleAvatar(
          //             backgroundColor: Colors.grey.withOpacity(.3),
          //             child:teamMember.image
          //         ),
          //         title: Text(
          //           "${teamMember.name}",
          //         ),
          //         subtitle: Text(
          //             "${teamMember.role}"
          //         ),
          //         trailing: index != 0 ? Icon(Icons.arrow_forward_ios_outlined) : null,
          //       ),
          //     );
          //   },
          // )
        ],
      ),
    );

  }

  // void deleteTeamMember(TeamMember teamMember){
  //   showDialog(
  //       context: context,
  //       builder: (context){
  //         return AlertDialog(
  //           title: Text(
  //               "Are you sure you want do delete this Member?"
  //           ),
  //           actions:
  //           [
  //             ElevatedButton(
  //                 onPressed: (){
  //                   bool isRemoved = TeamsScreen.members.remove(teamMember);
  //                   if(isRemoved){
  //                     setState(() {});
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(
  //                           content: Text(
  //                             'Member Deleted',
  //                             style: TextStyle(
  //                                 color: Colors.black
  //                             ),
  //                           ),
  //                           backgroundColor: Colors.green,)
  //                     );
  //                     AppFunctions.navigateFrom(context);
  //                   }
  //
  //                 },
  //                 child:Text(
  //                     "Delete"
  //                 )
  //             ),
  //             ElevatedButton(
  //                 onPressed: (){
  //                   AppFunctions.navigateFrom(context);
  //                 },
  //                 child:Text(
  //                     "Cancel"
  //                 )
  //             ),
  //           ],
  //         );
  //       }
  //   );
  // }
}
