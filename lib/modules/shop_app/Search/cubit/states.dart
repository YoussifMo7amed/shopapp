abstract class Shopsearchstates{}

class ShopsearchInitialState extends Shopsearchstates{}

class ShopsearchLoadingState extends Shopsearchstates{}

class ShopsearchSuccesState extends Shopsearchstates{}

class ShopsearchErrorState extends Shopsearchstates{
  final dynamic error;

  ShopsearchErrorState(this.error);
}