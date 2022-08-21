import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/extension_generator.dart';
import 'src/subclass_generator.dart';
import 'src/class_generator.dart';

Builder generateExtension(BuilderOptions options) =>
    SharedPartBuilder([ExtensionGenerator()], 'extension_generator');

Builder generateSubclass(BuilderOptions options) =>
    SharedPartBuilder([SubclassGenerator()], 'subclass_generator');

Builder generateClass(BuilderOptions options) =>
    SharedPartBuilder([ClassGenerator()], 'class_generator');