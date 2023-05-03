import 'dart:async';

import 'package:advanced_flutter/presentation/common/state_renderer/state_renderer_empl.dart';

abstract class BaseVMInputs {
  void start();
  void dispose();
  Sink get inputState;
}

abstract class BaseVMOutputs {
// later
  Stream<FlowState> get outputState;
}

abstract class BaseVM extends BaseVMInputs with BaseVMOutputs {
  final StreamController _inputSC = StreamController<FlowState>.broadcast();

  @override
  void dispose() {
    _inputSC.close();
  }

  @override
  Sink get inputState => _inputSC.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputSC.stream.map((flowState) => flowState);
}
