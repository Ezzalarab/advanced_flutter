abstract class BaseVMInputs {
  void start();
  void dispose();
}

abstract class BaseVMOutputs {
// later
}

abstract class BaseVM extends BaseVMInputs with BaseVMOutputs {}
