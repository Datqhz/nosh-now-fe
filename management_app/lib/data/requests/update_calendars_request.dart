class UpdateCalendarsRequest {
  List<CreateCalendarInput> inputs;
  
  UpdateCalendarsRequest({
    required this.inputs
  });

  Map<String, dynamic> toJson() {
    return {
      'inputs': inputs.map((x) => x.toJson()).toList()
    };
  }
}

class CreateCalendarInput {
  DateTime startDate;
  DateTime endDate;
  
  CreateCalendarInput({
    required this.startDate,
    required this.endDate
  });

  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate,
      'quantity': endDate
    };
  }
}