class ModelProject {
  String name;
  String deadline;
  String description;
  String features;
  String platforms;
  String budget;
  List<String> collaborators;

  String deadlineEdited;
  String descriptionEdited;
  String featuresEdited;
  String budgetEdited;

  ModelProject(this.name, this.deadline, this.description, this.features,
      this.platforms, this.budget, this.collaborators,
      {this.deadlineEdited = "",
      this.descriptionEdited = "",
      this.featuresEdited = "",
      this.budgetEdited = ""});

  Map<String, dynamic> toFirestoreObject() {
    return {
      "budget": budget,
      "budget_edited": budgetEdited,
      "collaborators": collaborators,
      "deadline": deadline,
      "deadline_edited": deadlineEdited,
      "description": description,
      "description_edited": descriptionEdited,
      "features": features,
      "features_edited": featuresEdited,
      "platforms": platforms
    };
  }
}
