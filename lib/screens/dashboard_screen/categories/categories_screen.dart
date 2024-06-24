import 'package:documind/data/api_call/document_api_call.dart';
import 'package:documind/data/model/category_model.dart';
import 'package:documind/screens/dashboard_screen/project/project_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/colors.dart';
import '../../../data/api_call/user_api_call.dart';
import '../../../data/model/user_model.dart';
import '../../../utils/custom_container.dart';
import '../../login/login_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  UserModel userModel = UserModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserModel();
  }
  getUserModel()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userId = preferences.getInt("userId");

    userModel = await UserApiCall().getUser(userId!);

    setState(() {

    });
    print(userModel.name);
  }
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              if (!scaffoldKey.currentState!.isDrawerOpen) {
                //check if drawer is closed
                scaffoldKey.currentState!
                    .openDrawer(); //open drawer
              }
            },
            child: Icon(Icons.list_sharp)),
        title: Text("Categories"),
        backgroundColor: AppColors.transparent,
      ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.appGreen, AppColors.appLightGreen],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    'Hii ${userModel.name}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () async{
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  preferences.clear();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.center,
            colors: [
              AppColors.appGreen, // Light blue starting color
              AppColors.appLightGreen, // Purple ending color
            ],
          ),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.12,
              ),
              GradientContainer(
                padding: 10,
                borderColor: AppColors.transparent,
                beginColor: AppColors.purpleOne,
                endColor: AppColors.purpleTwo,
                borderWidth: 0,
                text: 'Categories',
                fontSize: 17,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              FutureBuilder<List<CategoryModel>>(
                  future: DocumentApiCall().getCategory(),
                  builder: (context, snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.purple,
                          ),
                        ),
                      );
                    }
                    if(snapshot.hasError){
                      return Expanded(
                        child: Center(
                          child: Text("${snapshot.error}"),
                        ),
                      );
                    }
                    else{
                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProjectScreen(CategoryId: snapshot.data![index].id!,)));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColors.white, // Light blue starting color
                                            AppColors.grey, // Purple ending color
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(12)),
                                    child:Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Center(
                                        child: Text("${snapshot.data![index].categoryName}"),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),

    );
  }
}
