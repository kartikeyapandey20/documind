import 'package:documind/data/model/extract_text_model.dart';
import 'package:documind/screens/dashboard_screen/categories/chat/chart_screen_2.dart';
import 'package:documind/screens/dashboard_screen/categories/chat/chat_screen.dart';
import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../../../data/api_call/document_api_call.dart';
import '../../../data/model/project_model.dart';
import '../../../utils/custom_container.dart';

class ProjectScreen extends StatefulWidget {
  final int CategoryId;
  const ProjectScreen({super.key, required this.CategoryId});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Icon(Icons.list_sharp),
        title: Text("Project Screen"),
        backgroundColor: AppColors.transparent,
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
                text: 'Select a Project you want to talk about',
                fontSize: 17,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              FutureBuilder<List<ProjectModel>>(
                  future: DocumentApiCall().getProject(widget.CategoryId),
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
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: ()async{
                                   DocumentApiCall().textForLLM(snapshot.data![index].documentUrl!).then((value) {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(title: "Lets Solve", document: value.extractedText!,)));
                                    });
                                  },
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
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FittedBox(
                                                  child: Text("${snapshot.data![index].projectName!.length >50 ? snapshot.data![index].projectName!.substring(0, 10) + '...' : snapshot.data![index].projectName}",
                                                    style: TextStyle(
                                                      fontSize: 8,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Container(
                                            height: screenWidth * 0.17,
                                            width: screenWidth * 0.17,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  AppColors
                                                      .purpleProfileOne, // Light blue starting color
                                                  AppColors
                                                      .purpleProfileTwo, // Purple ending color
                                                ],
                                              ),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.assignment_ind,
                                                size: 30,
                                                color: AppColors.appGreen,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
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
