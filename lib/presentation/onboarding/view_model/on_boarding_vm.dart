// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:advanced_flutter/domain/entities/slider_object.dart';
import 'package:advanced_flutter/presentation/base/base_vm.dart';

class OnBoardingVM extends BaseVM with OnBoardingVMInputs, OnBoardingVMOutputs {
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void goNext() {
    // TODO: implement goNext
  }

  @override
  void goPrevious() {
    // TODO: implement goPrevious
  }

  @override
  void onPageChanged(int pageIndex) {
    // TODO: implement onPageChanged
  }
}

abstract class OnBoardingVMInputs {
  void goNext();
  void goPrevious();
  void onPageChanged(int pageIndex);
}

abstract class OnBoardingVMOutputs {}
