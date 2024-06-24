import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:lottie/lottie.dart';

import '../widgets/chat_input_box.dart';

class SectionEmbedContent extends StatefulWidget {
  const SectionEmbedContent({super.key});

  @override
  State<SectionEmbedContent> createState() => _SectionEmbedContentState();
}

class _SectionEmbedContentState extends State<SectionEmbedContent> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  String? searchedText;
  List<num>? result;
  bool _loading = false;
  String procurementSummary =
      "Procurement Summary,Home > Procurement Summary,Tender ID- 64534,View BOQ/lItem Details,Organization Name,Location,Department,Sub Department,IFB/Tender Notice No,Tender Type,Tender title/Name Of Project,Description of Material/Name of Work,Sector Category,Form of Contract,Product Category,Tender Category,Tender Currency Type,Tender Currency Setting,Period of Completion/Delivery Period,Procurement Type,Consortium / Joint Venture,Rebate,Alternate decrypter,Calender Details,Bid Document Download Start Date,Bid document download End Date,Bid Submission Start Date,Bid Submission Closing Date,Tender NIT View Date,Remarks,Pre-Bid Meeting,Bid validity,Amount Details,Bidding Processing Fee ( OFFLINE),a a ee a,Agriculture and Co-operative Department,Bharuch,Agriculture and Co-operative Department,Shree Khedut Sahakari Khand Udyog Mandli Ltd,17 of 2024-25,Open,PURCHASE OF SYNTHETIC ENAMEL PAINT,PURCHASE OF SYNTHETIC ENAMEL PAINT,Cooperatives,Supply,Agriculture or Forestry Works,GOODS,Single,Indian Rupee,4 Weeks,Goods,N/A,N/A,N/A,28-03-2024 15:00,06-04-2024 15:30,28-03-2024 15:00,06-04-2024 15:30,N/A,N/A,No Meeting,60 Days,2,500 INR. (Two Thousand Five Hundred Only ),Chern Mhandiit QCnhbanbarnt Mhard linduan Mandhil+tda Dandi,ne ae ee ee ee ee ENE ALTONA EAT IY Oe Re,Bidding Processing Fee Payable at Kosamba,Bid Security/EMD/Proposal Security INR ( OFFLIN E),Bid Security/EMD/Proposal Security INR Payable to Shree Khedut Sahakari Khand Udyog Mandli Ltd, Pandvai,50,000 INR. (Fifty Thousand Only ),Bid Security/EMD/Proposal Security INR Payable at Kosamba,Exempted Fee,Yes,Other Details,Officer Inviting Bids,I/C Managing Director,Bid Opening Authority,I/C Managing Director,Shree Khedut Sahakari Khand Udyog Mandli Ltd.,Pandvai At,Address,Pandvai Ta Hansot Di Bharuch,Contact Details,9824599940,Tender Stages,Stage Name,Evaluation Date,Minimum Forms for Submission,Preliminary Stage,06-04-2024 15:45,ie},Commercial Stage,06-04-2024 16:00,ie},Documents required for Stage - Preliminary Stage,Company Licence;GST Certificate;Demand Draft,Documents required For Form - Emd Fee Form,Provide any proof of EMD Document,General Terms & Conditions,1 Provide any proof of Bid Processing Fee,Certificate Details,Cert Serial No.,CN=MUKESH D PATEL...,Thumbprint...,General Terms & Conditions,Other Terms & Conditions as per detailed tender documents,Tender Documents";

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);

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
                  result = null;
                });
              },
              child: Text('search: $searchedText')),
        Expanded(
            child: loading
                ? Lottie.asset('assets/lottie/ai.json')
                : result != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                            child: Text(result?.toString() ?? '')),
                      )
                    : const Center(child: Text('Search something!'))),
        ChatInputBox(
          controller: controller,
          onSend: () {
            if (controller.text.isNotEmpty) {
              searchedText = procurementSummary+"\n" +controller.text;
              controller.clear();
              loading = true;

              gemini.embedContent(procurementSummary).then((value) {
                result = value;
                loading = false;
              });
            }
          },
        ),
      ],
    );
  }
}
