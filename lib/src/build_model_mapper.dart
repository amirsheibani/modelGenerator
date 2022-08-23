
import 'package:annotations/generate_model_annotations.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

import 'model_visitor.dart';

class BuildMapper extends GeneratorForAnnotation<GenerateMapper> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    String path = buildStep.inputId.path;
    final isModel = annotation.peek('model')?.boolValue;
    final isEntity = annotation.peek('entity')?.boolValue;
    final visitor = ModelVisitor();
    element.visitChildren(visitor);

    final classBuffer = StringBuffer();
    String className = visitor.className.split('Entity').first;
    if(isModel ?? false){
      classBuffer.writeln('extension MapperOn${className}Model on ${className}Model {');
      classBuffer.writeln('${className}Entity? mapper(){');
      classBuffer.writeln('return ${className}Entity(');
      for (final field in visitor.fields.keys) {
        classBuffer.writeln('$field : $field,');
      }
      classBuffer.writeln(');}');
      classBuffer.writeln('}');
      classBuffer.writeln('');
    }
    if(isEntity ?? false){
      classBuffer.writeln('extension MapperOn${className}Entity on ${className}Entity {');
      classBuffer.writeln('${className}Model? mapper(){');
      classBuffer.writeln('return ${className}Model(');
      for (final field in visitor.fields.keys) {
        classBuffer.writeln('$field : $field,');
      }
      classBuffer.writeln(');}');
      classBuffer.writeln('}');
      classBuffer.writeln('');
    }
    return classBuffer.toString();
  }
}
