class Notes {
  ////id, account_type, title, description, currency, amount, taxes, insert_date, update_date
  int id;
  String notes;
  String duration;

  Notes({this.notes, this.duration});

  Notes.withId(this.id, this.notes, this.duration);

  int get getid => id;
  String get getnotes => notes;
  String get getduration => duration;

  set setNotes(String newNotes) {
    if (newNotes.length <= 1000) {
      this.notes = newNotes;
    }
  }

  set setDuration(String newDuration) {
    if (newDuration.length <= 255) {
      this.duration = newDuration;
    }
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['notes'] = notes;
    map['duration'] = duration;

    return map;
  }

  // Extract a Note object from a Map object
  Notes.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.notes = map['notes'];
    this.duration = map['duration'];
  }
}
