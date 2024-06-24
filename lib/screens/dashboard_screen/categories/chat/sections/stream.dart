import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../widgets/chat_input_box.dart';
import '../widgets/item_image_view.dart';

class SectionTextStreamInput extends StatefulWidget {
  const SectionTextStreamInput({super.key});

  @override
  State<SectionTextStreamInput> createState() => _SectionTextInputStreamState();
}

class _SectionTextInputStreamState extends State<SectionTextStreamInput> {
  final ImagePicker picker = ImagePicker();
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText,
      // result,
      _finishReason;

  List<Uint8List>? images;

  String? get finishReason => _finishReason;

  set finishReason(String? set) {
    if (set != _finishReason) {
      setState(() => _finishReason = set);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (searchedText != null)
          MaterialButton(
              color: Colors.blue.shade700,
              onPressed: () {
                setState(() {
                  searchedText = null;
                  finishReason = null;
                  // result = null;
                });
              },
              child: Text('search: $searchedText')),
        Expanded(child: GeminiResponseTypeView(
          builder: (context, child, response, loading) {
            if (loading) {
              return Lottie.asset('assets/lottie/ai.json');
            }

            if (response != null) {
              return Markdown(
                data: response,
                selectable: true,
              );
            } else {
              return const Center(child: Text('Search something!'));
            }
          },
        )),

        /// if the returned finishReason isn't STOP
        if (finishReason != null) Text(finishReason!),

        if (images != null)
          Container(
            height: 120,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.centerLeft,
            child: Card(
              child: ListView.builder(
                itemBuilder: (context, index) => ItemImageView(
                  bytes: images!.elementAt(index),
                ),
                itemCount: images!.length,
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),

        /// imported from local widgets
        ChatInputBox(
          controller: controller,
          onClickCamera: () {
            picker.pickMultiImage().then((value) async {
              final imagesBytes = <Uint8List>[];
              for (final file in value) {
                imagesBytes.add(await file.readAsBytes());
              }

              if (imagesBytes.isNotEmpty) {
                setState(() {
                  images = imagesBytes;
                });
              }
            });
          },
          onSend: () {
            if (controller.text.isNotEmpty) {
              print('request');
              String procurementSummary =
                  "Procurement Summary,Home > Procurement Summary,Tender ID- 64534,View BOQ/lItem Details,Organization Name,Location,Department,Sub Department,IFB/Tender Notice No,Tender Type,Tender title/Name Of Project,Description of Material/Name of Work,Sector Category,Form of Contract,Product Category,Tender Category,Tender Currency Type,Tender Currency Setting,Period of Completion/Delivery Period,Procurement Type,Consortium / Joint Venture,Rebate,Alternate decrypter,Calender Details,Bid Document Download Start Date,Bid document download End Date,Bid Submission Start Date,Bid Submission Closing Date,Tender NIT View Date,Remarks,Pre-Bid Meeting,Bid validity,Amount Details,Bidding Processing Fee ( OFFLINE),a a ee a,Agriculture and Co-operative Department,Bharuch,Agriculture and Co-operative Department,Shree Khedut Sahakari Khand Udyog Mandli Ltd,17 of 2024-25,Open,PURCHASE OF SYNTHETIC ENAMEL PAINT,PURCHASE OF SYNTHETIC ENAMEL PAINT,Cooperatives,Supply,Agriculture or Forestry Works,GOODS,Single,Indian Rupee,4 Weeks,Goods,N/A,N/A,N/A,28-03-2024 15:00,06-04-2024 15:30,28-03-2024 15:00,06-04-2024 15:30,N/A,N/A,No Meeting,60 Days,2,500 INR. (Two Thousand Five Hundred Only ),Chern Mhandiit QCnhbanbarnt Mhard linduan Mandhil+tda Dandi,ne ae ee ee ee ee ENE ALTONA EAT IY Oe Re,Bidding Processing Fee Payable at Kosamba,Bid Security/EMD/Proposal Security INR ( OFFLIN E),Bid Security/EMD/Proposal Security INR Payable to Shree Khedut Sahakari Khand Udyog Mandli Ltd, Pandvai,50,000 INR. (Fifty Thousand Only ),Bid Security/EMD/Proposal Security INR Payable at Kosamba,Exempted Fee,Yes,Other Details,Officer Inviting Bids,I/C Managing Director,Bid Opening Authority,I/C Managing Director,Shree Khedut Sahakari Khand Udyog Mandli Ltd.,Pandvai At,Address,Pandvai Ta Hansot Di Bharuch,Contact Details,9824599940,Tender Stages,Stage Name,Evaluation Date,Minimum Forms for Submission,Preliminary Stage,06-04-2024 15:45,ie},Commercial Stage,06-04-2024 16:00,ie},Documents required for Stage - Preliminary Stage,Company Licence;GST Certificate;Demand Draft,Documents required For Form - Emd Fee Form,Provide any proof of EMD Document,General Terms & Conditions,1 Provide any proof of Bid Processing Fee,Certificate Details,Cert Serial No.,CN=MUKESH D PATEL...,Thumbprint...,General Terms & Conditions,Other Terms & Conditions as per detailed tender documents,Tender Documents";
              searchedText = controller.text;
              var user_response_Test = procurementSummary + "\n" + searchedText!;
              controller.clear();
              gemini
                  .streamGenerateContent(user_response_Test, images: images)
                  .handleError((e) {
                if (e is GeminiException) {
                  print(e);
                }
              }).listen((value) {
                setState(() {
                  images = null;
                });
                // result = (result ?? '') + (value.output ?? '');

                if (value.finishReason != 'STOP') {
                  finishReason = 'Finish reason is `${value.finishReason}`';
                }
              });
            }
          },
        )
      ],
    );
  }
}
