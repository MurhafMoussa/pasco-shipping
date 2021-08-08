class UnitRequest {
  int? id;
  String name;
  String description;

  UnitRequest(
      {this.id,
      required this.name,
      required this.description,
      });

  Map<String, dynamic> toJson() {
    if (id == null) {
      return {'name': name, 'description': description};
    } else {
      return {
        'id': id,
        'name': name,
        'description': description
      };
    }
  }
}
