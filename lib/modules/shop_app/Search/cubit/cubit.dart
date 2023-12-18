
// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/shop_app/Search/cubit/states.dart';
import 'package:shopapp/network/endpoints.dart';

import '../../../../models/search/search_mod.dart';
import '../../../../network/remote/dio_helpear.dart';
import '../../../../shared/components.dart/constants.dart';

class ShopSearchCubit extends Cubit<Shopsearchstates>
{
  ShopSearchCubit():super(ShopsearchInitialState());
  static ShopSearchCubit get(context)=>BlocProvider.of(context);
  SearchModel? model;
  void GetSearch({
 required String ?Text,

}) { 
  emit(ShopsearchLoadingState());
    DioHelper.postData(
      url:SEARCH,
      
      data: {
'text':Text
      },
   Token: Token,
      lang: 'en'
    ).then((value) {
      model = SearchModel.fromJson(value.data);


      emit(ShopsearchSuccesState());
    }).catchError(( error) {
      emit(ShopsearchErrorState(error));
    });
  }
}