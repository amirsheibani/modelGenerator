
import 'package:annotations/annotations.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class ExtensionGenerator extends GeneratorForAnnotation<ExtensionAnnotation> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final visitor = ModelVisitor();
    element.visitChildren(visitor);
    final className ='${visitor.className.replaceAll('Entity','Model')}';
    final classBuffer = StringBuffer();
    classBuffer.writeln('extension ConvertToModel on ${visitor.className} {');
    classBuffer.writeln('$className toModel(){');
    classBuffer.writeln('return $className(');
    for (final field in visitor.fields.keys) {
      classBuffer.writeln('$field : $field,');
    }
    classBuffer.writeln(');}');
    classBuffer.writeln('}');
    return classBuffer.toString();
  }
}
