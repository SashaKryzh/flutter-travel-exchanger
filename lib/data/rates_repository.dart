import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_exchanger/data/rates.dart';
import 'package:travel_exchanger/domain/rate.dart';
import 'package:travel_exchanger/supabase.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'rates_repository.g.dart';

@riverpod
RatesRepository ratesRepository(RatesRepositoryRef ref) {
  return RatesRepository(
    ref.watch(supabaseProvider),
  );
}

class RatesRepository {
  const RatesRepository(this._supabase);

  final SupabaseClient _supabase;

  Future<List<Rate>> fetchRates() async {
    List<Rate> rates;

    try {
      final response = await _supabase.functions.invoke('rates', method: HttpMethod.get);
      final data = GetRatesResponse.fromJson(response.data);
      rates = data.rates;
    } on FunctionException catch (e) {
      logger.e('FunctionException: ${e.status} ${e.reasonPhrase} ${e.details}');
      rates = [];
    }

    return rates;
  }
}
