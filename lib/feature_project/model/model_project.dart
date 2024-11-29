import 'package:cloud_firestore/cloud_firestore.dart';

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

  ModelProject.fromFirestore(Map<String, dynamic> doc, String id)
      : budget = doc["budget"],
        budgetEdited = doc["budget_edited"],
        name = id,
        deadline = doc["deadline"],
        deadlineEdited = doc["deadline_edited"],
        description = doc["description"],
        descriptionEdited = doc["description_edited"],
        platforms = doc["platforms"],
        collaborators = List<String>.from(doc["collaborators"]),
        features = doc["features"],
        featuresEdited = doc["features_edited"];

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
