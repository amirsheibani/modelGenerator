import 'package:build/build.dart';
import 'package:generators/src/build_model_mapper.dart';
import 'package:source_gen/source_gen.dart';

import 'src/build_model_class.dart';

Builder buildMapper(BuilderOptions options) =>
    LibraryBuilder(BuildMapper(), generatedExtension: '.mapper.g.dart');


Builder buildModelClass(BuilderOptions options) =>
    LibraryBuilder(BuildModelClass(), generatedExtension: '.model.g.dart');
