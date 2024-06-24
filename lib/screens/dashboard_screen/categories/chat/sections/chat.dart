import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../widgets/chat_input_box.dart';

class SectionChat extends StatefulWidget {
  const SectionChat({super.key});

  @override
  State<SectionChat> createState() => _SectionChatState();
}

class _SectionChatState extends State<SectionChat> {
  final controller = TextEditingController();
  final gemini = Gemini.instance;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);
  final List<Content> chats = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: chats.isNotEmpty
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      reverse: true,
                      child: ListView.builder(
                        itemBuilder: chatItem,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: chats.length,
                        reverse: false,
                      ),
                    ),
                  )
                : const Center(child: Text('Search something!'))),
        if (loading) const CircularProgressIndicator(),
        ChatInputBox(
          controller: controller,
          onSend: () {
            if (controller.text.isNotEmpty) {
              String procurementSummary =
                  "Procurement Summary,Home > Procurement Summary,Tender ID- 64534,View BOQ/lItem Details,Organization Name,Location,Department,Sub Department,IFB/Tender Notice No,Tender Type,Tender title/Name Of Project,Description of Material/Name of Work,Sector Category,Form of Contract,Product Category,Tender Category,Tender Currency Type,Tender Currency Setting,Period of Completion/Delivery Period,Procurement Type,Consortium / Joint Venture,Rebate,Alternate decrypter,Calender Details,Bid Document Download Start Date,Bid document download End Date,Bid Submission Start Date,Bid Submission Closing Date,Tender NIT View Date,Remarks,Pre-Bid Meeting,Bid validity,Amount Details,Bidding Processing Fee ( OFFLINE),a a ee a,Agriculture and Co-operative Department,Bharuch,Agriculture and Co-operative Department,Shree Khedut Sahakari Khand Udyog Mandli Ltd,17 of 2024-25,Open,PURCHASE OF SYNTHETIC ENAMEL PAINT,PURCHASE OF SYNTHETIC ENAMEL PAINT,Cooperatives,Supply,Agriculture or Forestry Works,GOODS,Single,Indian Rupee,4 Weeks,Goods,N/A,N/A,N/A,28-03-2024 15:00,06-04-2024 15:30,28-03-2024 15:00,06-04-2024 15:30,N/A,N/A,No Meeting,60 Days,2,500 INR. (Two Thousand Five Hundred Only ),Chern Mhandiit QCnhbanbarnt Mhard linduan Mandhil+tda Dandi,ne ae ee ee ee ee ENE ALTONA EAT IY Oe Re,Bidding Processing Fee Payable at Kosamba,Bid Security/EMD/Proposal Security INR ( OFFLIN E),Bid Security/EMD/Proposal Security INR Payable to Shree Khedut Sahakari Khand Udyog Mandli Ltd, Pandvai,50,000 INR. (Fifty Thousand Only ),Bid Security/EMD/Proposal Security INR Payable at Kosamba,Exempted Fee,Yes,Other Details,Officer Inviting Bids,I/C Managing Director,Bid Opening Authority,I/C Managing Director,Shree Khedut Sahakari Khand Udyog Mandli Ltd.,Pandvai At,Address,Pandvai Ta Hansot Di Bharuch,Contact Details,9824599940,Tender Stages,Stage Name,Evaluation Date,Minimum Forms for Submission,Preliminary Stage,06-04-2024 15:45,ie},Commercial Stage,06-04-2024 16:00,ie},Documents required for Stage - Preliminary Stage,Company Licence;GST Certificate;Demand Draft,Documents required For Form - Emd Fee Form,Provide any proof of EMD Document,General Terms & Conditions,1 Provide any proof of Bid Processing Fee,Certificate Details,Cert Serial No.,CN=MUKESH D PATEL...,Thumbprint...,General Terms & Conditions,Other Terms & Conditions as per detailed tender documents,Tender Documents";
              final searchedText = controller.text;
              var user_response_Test = procurementSummary + "\n" + searchedText!;
              chats.add(
                  Content(role: 'user', parts: [Parts(text: user_response_Test)]));
              controller.clear();
              loading = true;

              gemini.chat(chats).then((value) {
                chats.add(Content(
                    role: 'model', parts: [Parts(text: value?.output)]));
                loading = false;
              });
            }
          },
        ),
      ],
    );
  }

  Widget chatItem(BuildContext context, int index) {
    final Content content = chats[index];

    return Card(
      elevation: 0,
      color:
          content.role == 'model' ? Colors.blue.shade800 : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(content.role ?? 'role'),
            Markdown(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                data:
                    content.parts?.lastOrNull?.text ?? 'cannot generate data!'),
          ],
        ),
      ),
    );
  }
}
