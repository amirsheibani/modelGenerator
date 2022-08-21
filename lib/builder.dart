import 'package:build/build.dart';
import 'package:generators/src/build_model_mapper.dart';
import 'package:source_gen/source_gen.dart';

import 'src/build_model_class.dart';

Builder buildModelMapper(BuilderOptions options) =>
    SharedPartBuilder([BuildModelMapper()], 'build_model_mapper');

Builder buildModelClass(BuilderOptions options) =>
    SharedPartBuilder([BuildModelClass()], 'build_model_class');