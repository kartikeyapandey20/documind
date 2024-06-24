import 'package:documind/screens/dashboard_screen/categories/chat/chart_screen_2.dart';
import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../../../data/api_call/document_api_call.dart';
import '../../../data/model/extract_text_model.dart';
import '../../../utils/custom_container.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Icon(Icons.list_sharp),
        title: Text("History"),
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
                text: 'History Chat',
                fontSize: 17,
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: ()async{
                            // ExtractTextModel extractTextModel = await DocumentApiCall().textForLLM(snapshot.data![index].documentUrl!);
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(title: "Lets Solve", document: extractTextModel.extractedText!,)));
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
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: Text("Chat with PURCHASE OF CANE CARRIER CHAIN PITCH"),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),

    );
  }
}
