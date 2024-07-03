// ignore_for_file: public_member_api_docs, sort_constructors_first

class RatingModel {
  int ratingValue;
  String comment;
  DateTime timeStamp;

  RatingModel({
    required this.ratingValue,
    required this.comment,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'ratingValue': ratingValue,
      'comment': comment,
      'timeStamp': timeStamp.millisecondsSinceEpoch,
    };
  }

  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      ratingValue: map['ratingValue'] as int,
      comment: map['comment'] as String,
      timeStamp: DateTime.fromMillisecondsSinceEpoch(map['timeStamp'] as int),
    );
  }
}