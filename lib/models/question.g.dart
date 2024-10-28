// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      text: json['text'] as String,
      isTrueOrFalse: (json['isTrueOrFalse'] as num).toInt(),
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswerIndex: (json['correctAnswerIndex'] as num).toInt(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'text': instance.text,
      'isTrueOrFalse': instance.isTrueOrFalse,
      'options': instance.options,
      'correctAnswerIndex': instance.correctAnswerIndex,
    };
