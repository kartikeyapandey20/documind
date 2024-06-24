class ExtractTextModel {
  String? extractedText;

  ExtractTextModel({this.extractedText});

  ExtractTextModel.fromJson(Map<String, dynamic> json) {
    extractedText = json['extracted_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['extracted_text'] = this.extractedText;
    return data;
  }
}
