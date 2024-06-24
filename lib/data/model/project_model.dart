class ProjectModel {
  int? id;
  String? projectName;
  int? categoryId;
  String? documentUrl;
  String? createdAt;

  ProjectModel({
    this.id,
    this.projectName,
    this.categoryId,
    this.documentUrl,
    this.createdAt,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'],
      projectName: json['project_name'],
      categoryId: json['category_id'],
      documentUrl: json['document_url'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['project_name'] = projectName;
    data['category_id'] = categoryId;
    data['document_url'] = documentUrl;
    data['created_at'] = createdAt;
    return data;
  }

  static List<ProjectModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((item) => ProjectModel.fromJson(item)).toList();
  }
}
