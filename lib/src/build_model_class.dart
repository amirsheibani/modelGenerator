
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import 'package:annotations/annotations.dart';

import 'model_visitor.dart';

class BuildModelClass extends GeneratorForAnnotation<ClassAnnotation> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final className ='${visitor.className.replaceAll('Entity','Model')}';

    final classBuffer = StringBuffer();

    classBuffer.writeln('class $className extends ${visitor.className} {');

    classBuffer.writeln('$className({');
    for (final field in visitor.fields.keys) {
      final type = '${visitor.fields[field]}';
      classBuffer.writeln('$type $field ,');
    }
    classBuffer.writeln('}) : super(');
    for (final field in visitor.fields.keys) {
      classBuffer.write('$field : $field,');
    }
    classBuffer.writeln(');');
    classBuffer.writeln();
    generateFromJson(visitor,classBuffer);
    classBuffer.writeln();
    generateToJson(visitor,classBuffer);
    classBuffer.writeln();
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
      classBuffer.writeln("$field: json['$field'],");
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
