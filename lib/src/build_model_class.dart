
import 'package:annotations/generate_model_annotations.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';


import 'model_visitor.dart';

class BuildModelClass extends GeneratorForAnnotation<GenerateModelClass> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {


    String path = buildStep.inputId.path;
    var name = annotation.peek('className')?.stringValue;


    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final className = (name is String) ? name : '${visitor.className.replaceAll('Entity','Model')}';

    final classBuffer = StringBuffer();

    classBuffer.writeln('class $className {');

    for (final field in visitor.fields.keys) {
      final type = '${visitor.fields[field]}';
      classBuffer.writeln('final $type $field;');
    }
    classBuffer.writeln('$className({');
    for (final field in visitor.fields.keys) {
      classBuffer.writeln('this.$field,');
    }
    classBuffer.writeln('});');
    classBuffer.writeln();
    generateFromJson(visitor,classBuffer);
    classBuffer.writeln();
    generateToJson(visitor,classBuffer);
    classBuffer.writeln('}');

    return classBuffer.toString();
  }

  void generateFromJson(
      ModelVisitor visitor, StringBuffer classBuffer) {
    final className ='${visitor.className.replaceAll('Entity','Model')}';
    classBuffer.write('factory $className.fromJson(Map<String, dynamic> json)');
    classBuffer.writeln(' {');
    classBuffer.writeln('  return $className(');
    for (final field in visitor.fields.keys) {
      final type = '${visitor.fields[field]}';
      classBuffer.writeln("$field: json['$field'] as $type,");
    }
    classBuffer.writeln(');');
    classBuffer.writeln('}');
  }
  void generateToJson(
      ModelVisitor visitor, StringBuffer classBuffer) {
    classBuffer.write('Map<String, dynamic> toJson()');
    classBuffer.writeln(' {');
    classBuffer.writeln(' final map = <String, dynamic>{};');

    for (final field in visitor.fields.keys) {
      classBuffer.writeln("map['$field'] = $field;");
    }
    classBuffer.writeln('return map;');
    classBuffer.writeln('}');
  }
}
