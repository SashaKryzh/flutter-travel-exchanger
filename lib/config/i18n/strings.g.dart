/// Generated file. Do not edit.
///
/// Original: assets/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 1
/// Strings: 180
///
/// Built on 2024-02-11 at 15:01 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	Map<String, String> get currencyNames => {
		'AED': 'UAE Dirham',
		'AFN': 'Afghani',
		'ALL': 'Lek',
		'AMD': 'Armenian Dram',
		'ANG': 'Netherlands Antillean Guilder',
		'AOA': 'Kwanza',
		'ARS': 'Argentine Peso',
		'AUD': 'Australian Dollar',
		'AWG': 'Aruban Florin',
		'AZN': 'Azerbaijan Manat',
		'BAM': 'Convertible Mark',
		'BBD': 'Barbados Dollar',
		'BDT': 'Taka',
		'BGN': 'Bulgarian Lev',
		'BHD': 'Bahraini Dinar',
		'BIF': 'Burundi Franc',
		'BMD': 'Bermudian Dollar',
		'BND': 'Brunei Dollar',
		'BOB': 'Boliviano',
		'BOV': 'Mvdol',
		'BRL': 'Brazilian Real',
		'BSD': 'Bahamian Dollar',
		'BTN': 'Ngultrum',
		'BWP': 'Pula',
		'BYN': 'Belarusian Ruble',
		'BYR': 'Belarusian Ruble',
		'BZD': 'Belize Dollar',
		'CAD': 'Canadian Dollar',
		'CDF': 'Congolese Franc',
		'CHE': 'WIR Euro',
		'CHF': 'Swiss Franc',
		'CHW': 'WIR Franc',
		'CLF': 'Unidad de Fomento',
		'CLP': 'Chilean Peso',
		'CNY': 'Yuan Renminbi',
		'COP': 'Colombian Peso',
		'COU': 'Unidad de Valor Real',
		'CRC': 'Costa Rican Colon',
		'CUC': 'Peso Convertible',
		'CUP': 'Cuban Peso',
		'CVE': 'Cabo Verde Escudo',
		'CZK': 'Czech Koruna',
		'DJF': 'Djibouti Franc',
		'DKK': 'Danish Krone',
		'DOP': 'Dominican Peso',
		'DZD': 'Algerian Dinar',
		'EGP': 'Egyptian Pound',
		'ERN': 'Nakfa',
		'ETB': 'Ethiopian Birr',
		'EUR': 'Euro',
		'FJD': 'Fiji Dollar',
		'FKP': 'Falkland Islands Pound',
		'GBP': 'Pound Sterling',
		'GEL': 'Lari',
		'GHS': 'Ghana Cedi',
		'GIP': 'Gibraltar Pound',
		'GMD': 'Dalasi',
		'GNF': 'Guinean Franc',
		'GTQ': 'Quetzal',
		'GYD': 'Guyana Dollar',
		'HKD': 'Hong Kong Dollar',
		'HNL': 'Lempira',
		'HTG': 'Gourde',
		'HUF': 'Forint',
		'IDR': 'Rupiah',
		'ILS': 'New Israeli Sheqel',
		'INR': 'Indian Rupee',
		'IQD': 'Iraqi Dinar',
		'IRR': 'Iranian Rial',
		'ISK': 'Iceland Krona',
		'JMD': 'Jamaican Dollar',
		'JOD': 'Jordanian Dinar',
		'JPY': 'Yen',
		'KES': 'Kenyan Shilling',
		'KGS': 'Som',
		'KHR': 'Riel',
		'KMF': 'Comorian Franc ',
		'KPW': 'North Korean Won',
		'KRW': 'Won',
		'KWD': 'Kuwaiti Dinar',
		'KYD': 'Cayman Islands Dollar',
		'KZT': 'Tenge',
		'LAK': 'Lao Kip',
		'LBP': 'Lebanese Pound',
		'LKR': 'Sri Lanka Rupee',
		'LRD': 'Liberian Dollar',
		'LSL': 'Loti',
		'LYD': 'Libyan Dinar',
		'MAD': 'Moroccan Dirham',
		'MDL': 'Moldovan Leu',
		'MGA': 'Malagasy Ariary',
		'MKD': 'Denar',
		'MMK': 'Kyat',
		'MNT': 'Tugrik',
		'MOP': 'Pataca',
		'MRU': 'Ouguiya',
		'MUR': 'Mauritius Rupee',
		'MVR': 'Rufiyaa',
		'MWK': 'Malawi Kwacha',
		'MXN': 'Mexican Peso',
		'MXV': 'Mexican Unidad de Inversion (UDI)',
		'MYR': 'Malaysian Ringgit',
		'MZN': 'Mozambique Metical',
		'NAD': 'Namibia Dollar',
		'NGN': 'Naira',
		'NIO': 'Cordoba Oro',
		'NOK': 'Norwegian Krone',
		'NPR': 'Nepalese Rupee',
		'NZD': 'New Zealand Dollar',
		'OMR': 'Rial Omani',
		'PAB': 'Balboa',
		'PEN': 'Sol',
		'PGK': 'Kina',
		'PHP': 'Philippine Peso',
		'PKR': 'Pakistan Rupee',
		'PLN': 'Zloty',
		'PYG': 'Guarani',
		'QAR': 'Qatari Rial',
		'RON': 'Romanian Leu',
		'RSD': 'Serbian Dinar',
		'RUB': 'Russian Ruble',
		'RWF': 'Rwanda Franc',
		'SAR': 'Saudi Riyal',
		'SBD': 'Solomon Islands Dollar',
		'SCR': 'Seychelles Rupee',
		'SDG': 'Sudanese Pound',
		'SEK': 'Swedish Krona',
		'SGD': 'Singapore Dollar',
		'SHP': 'Saint Helena Pound',
		'SLE': 'Leone',
		'SOS': 'Somali Shilling',
		'SRD': 'Surinam Dollar',
		'SSP': 'South Sudanese Pound',
		'STN': 'Dobra',
		'SVC': 'El Salvador Colon',
		'SYP': 'Syrian Pound',
		'SZL': 'Lilangeni',
		'THB': 'Baht',
		'TJS': 'Somoni',
		'TMT': 'Turkmenistan New Manat',
		'TND': 'Tunisian Dinar',
		'TOP': 'Pa’anga',
		'TRY': 'Turkish Lira',
		'TTD': 'Trinidad and Tobago Dollar',
		'TWD': 'New Taiwan Dollar',
		'TZS': 'Tanzanian Shilling',
		'UAH': 'Hryvnia',
		'UGX': 'Uganda Shilling',
		'USD': 'US Dollar',
		'USN': 'US Dollar (Next day)',
		'UYI': 'Uruguay Peso en Unidades Indexadas (UI)',
		'UYU': 'Peso Uruguayo',
		'UYW': 'Unidad Previsional',
		'UZS': 'Uzbekistan Sum',
		'VED': 'Bolívar Soberano',
		'VES': 'Bolívar Soberano',
		'VND': 'Dong',
		'VUV': 'Vatu',
		'WST': 'Tala',
		'XAF': 'CFA Franc BEAC',
		'XAG': 'Silver',
		'XAU': 'Gold',
		'XBA': 'Bond Markets Unit European Composite Unit (EURCO)',
		'XBB': 'Bond Markets Unit European Monetary Unit (E.M.U.-6)',
		'XBC': 'Bond Markets Unit European Unit of Account 9 (E.U.A.-9)',
		'XBD': 'Bond Markets Unit European Unit of Account 17 (E.U.A.-17)',
		'XCD': 'East Caribbean Dollar',
		'XDR': 'SDR (Special Drawing Right)',
		'XOF': 'CFA Franc BCEAO',
		'XPD': 'Palladium',
		'XPF': 'CFP Franc',
		'XPT': 'Platinum',
		'XSU': 'Sucre',
		'XTS': 'Codes specifically reserved for testing purposes',
		'XUA': 'ADB Unit of Account',
		'XXX': 'The codes assigned for transactions where no currency is involved',
		'YER': 'Yemeni Rial',
		'ZAR': 'Rand',
		'ZMW': 'Zambian Kwacha',
		'ZWL': 'Zimbabwe Dollar',
	};
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'currencyNames.AED': return 'UAE Dirham';
			case 'currencyNames.AFN': return 'Afghani';
			case 'currencyNames.ALL': return 'Lek';
			case 'currencyNames.AMD': return 'Armenian Dram';
			case 'currencyNames.ANG': return 'Netherlands Antillean Guilder';
			case 'currencyNames.AOA': return 'Kwanza';
			case 'currencyNames.ARS': return 'Argentine Peso';
			case 'currencyNames.AUD': return 'Australian Dollar';
			case 'currencyNames.AWG': return 'Aruban Florin';
			case 'currencyNames.AZN': return 'Azerbaijan Manat';
			case 'currencyNames.BAM': return 'Convertible Mark';
			case 'currencyNames.BBD': return 'Barbados Dollar';
			case 'currencyNames.BDT': return 'Taka';
			case 'currencyNames.BGN': return 'Bulgarian Lev';
			case 'currencyNames.BHD': return 'Bahraini Dinar';
			case 'currencyNames.BIF': return 'Burundi Franc';
			case 'currencyNames.BMD': return 'Bermudian Dollar';
			case 'currencyNames.BND': return 'Brunei Dollar';
			case 'currencyNames.BOB': return 'Boliviano';
			case 'currencyNames.BOV': return 'Mvdol';
			case 'currencyNames.BRL': return 'Brazilian Real';
			case 'currencyNames.BSD': return 'Bahamian Dollar';
			case 'currencyNames.BTN': return 'Ngultrum';
			case 'currencyNames.BWP': return 'Pula';
			case 'currencyNames.BYN': return 'Belarusian Ruble';
			case 'currencyNames.BYR': return 'Belarusian Ruble';
			case 'currencyNames.BZD': return 'Belize Dollar';
			case 'currencyNames.CAD': return 'Canadian Dollar';
			case 'currencyNames.CDF': return 'Congolese Franc';
			case 'currencyNames.CHE': return 'WIR Euro';
			case 'currencyNames.CHF': return 'Swiss Franc';
			case 'currencyNames.CHW': return 'WIR Franc';
			case 'currencyNames.CLF': return 'Unidad de Fomento';
			case 'currencyNames.CLP': return 'Chilean Peso';
			case 'currencyNames.CNY': return 'Yuan Renminbi';
			case 'currencyNames.COP': return 'Colombian Peso';
			case 'currencyNames.COU': return 'Unidad de Valor Real';
			case 'currencyNames.CRC': return 'Costa Rican Colon';
			case 'currencyNames.CUC': return 'Peso Convertible';
			case 'currencyNames.CUP': return 'Cuban Peso';
			case 'currencyNames.CVE': return 'Cabo Verde Escudo';
			case 'currencyNames.CZK': return 'Czech Koruna';
			case 'currencyNames.DJF': return 'Djibouti Franc';
			case 'currencyNames.DKK': return 'Danish Krone';
			case 'currencyNames.DOP': return 'Dominican Peso';
			case 'currencyNames.DZD': return 'Algerian Dinar';
			case 'currencyNames.EGP': return 'Egyptian Pound';
			case 'currencyNames.ERN': return 'Nakfa';
			case 'currencyNames.ETB': return 'Ethiopian Birr';
			case 'currencyNames.EUR': return 'Euro';
			case 'currencyNames.FJD': return 'Fiji Dollar';
			case 'currencyNames.FKP': return 'Falkland Islands Pound';
			case 'currencyNames.GBP': return 'Pound Sterling';
			case 'currencyNames.GEL': return 'Lari';
			case 'currencyNames.GHS': return 'Ghana Cedi';
			case 'currencyNames.GIP': return 'Gibraltar Pound';
			case 'currencyNames.GMD': return 'Dalasi';
			case 'currencyNames.GNF': return 'Guinean Franc';
			case 'currencyNames.GTQ': return 'Quetzal';
			case 'currencyNames.GYD': return 'Guyana Dollar';
			case 'currencyNames.HKD': return 'Hong Kong Dollar';
			case 'currencyNames.HNL': return 'Lempira';
			case 'currencyNames.HTG': return 'Gourde';
			case 'currencyNames.HUF': return 'Forint';
			case 'currencyNames.IDR': return 'Rupiah';
			case 'currencyNames.ILS': return 'New Israeli Sheqel';
			case 'currencyNames.INR': return 'Indian Rupee';
			case 'currencyNames.IQD': return 'Iraqi Dinar';
			case 'currencyNames.IRR': return 'Iranian Rial';
			case 'currencyNames.ISK': return 'Iceland Krona';
			case 'currencyNames.JMD': return 'Jamaican Dollar';
			case 'currencyNames.JOD': return 'Jordanian Dinar';
			case 'currencyNames.JPY': return 'Yen';
			case 'currencyNames.KES': return 'Kenyan Shilling';
			case 'currencyNames.KGS': return 'Som';
			case 'currencyNames.KHR': return 'Riel';
			case 'currencyNames.KMF': return 'Comorian Franc ';
			case 'currencyNames.KPW': return 'North Korean Won';
			case 'currencyNames.KRW': return 'Won';
			case 'currencyNames.KWD': return 'Kuwaiti Dinar';
			case 'currencyNames.KYD': return 'Cayman Islands Dollar';
			case 'currencyNames.KZT': return 'Tenge';
			case 'currencyNames.LAK': return 'Lao Kip';
			case 'currencyNames.LBP': return 'Lebanese Pound';
			case 'currencyNames.LKR': return 'Sri Lanka Rupee';
			case 'currencyNames.LRD': return 'Liberian Dollar';
			case 'currencyNames.LSL': return 'Loti';
			case 'currencyNames.LYD': return 'Libyan Dinar';
			case 'currencyNames.MAD': return 'Moroccan Dirham';
			case 'currencyNames.MDL': return 'Moldovan Leu';
			case 'currencyNames.MGA': return 'Malagasy Ariary';
			case 'currencyNames.MKD': return 'Denar';
			case 'currencyNames.MMK': return 'Kyat';
			case 'currencyNames.MNT': return 'Tugrik';
			case 'currencyNames.MOP': return 'Pataca';
			case 'currencyNames.MRU': return 'Ouguiya';
			case 'currencyNames.MUR': return 'Mauritius Rupee';
			case 'currencyNames.MVR': return 'Rufiyaa';
			case 'currencyNames.MWK': return 'Malawi Kwacha';
			case 'currencyNames.MXN': return 'Mexican Peso';
			case 'currencyNames.MXV': return 'Mexican Unidad de Inversion (UDI)';
			case 'currencyNames.MYR': return 'Malaysian Ringgit';
			case 'currencyNames.MZN': return 'Mozambique Metical';
			case 'currencyNames.NAD': return 'Namibia Dollar';
			case 'currencyNames.NGN': return 'Naira';
			case 'currencyNames.NIO': return 'Cordoba Oro';
			case 'currencyNames.NOK': return 'Norwegian Krone';
			case 'currencyNames.NPR': return 'Nepalese Rupee';
			case 'currencyNames.NZD': return 'New Zealand Dollar';
			case 'currencyNames.OMR': return 'Rial Omani';
			case 'currencyNames.PAB': return 'Balboa';
			case 'currencyNames.PEN': return 'Sol';
			case 'currencyNames.PGK': return 'Kina';
			case 'currencyNames.PHP': return 'Philippine Peso';
			case 'currencyNames.PKR': return 'Pakistan Rupee';
			case 'currencyNames.PLN': return 'Zloty';
			case 'currencyNames.PYG': return 'Guarani';
			case 'currencyNames.QAR': return 'Qatari Rial';
			case 'currencyNames.RON': return 'Romanian Leu';
			case 'currencyNames.RSD': return 'Serbian Dinar';
			case 'currencyNames.RUB': return 'Russian Ruble';
			case 'currencyNames.RWF': return 'Rwanda Franc';
			case 'currencyNames.SAR': return 'Saudi Riyal';
			case 'currencyNames.SBD': return 'Solomon Islands Dollar';
			case 'currencyNames.SCR': return 'Seychelles Rupee';
			case 'currencyNames.SDG': return 'Sudanese Pound';
			case 'currencyNames.SEK': return 'Swedish Krona';
			case 'currencyNames.SGD': return 'Singapore Dollar';
			case 'currencyNames.SHP': return 'Saint Helena Pound';
			case 'currencyNames.SLE': return 'Leone';
			case 'currencyNames.SOS': return 'Somali Shilling';
			case 'currencyNames.SRD': return 'Surinam Dollar';
			case 'currencyNames.SSP': return 'South Sudanese Pound';
			case 'currencyNames.STN': return 'Dobra';
			case 'currencyNames.SVC': return 'El Salvador Colon';
			case 'currencyNames.SYP': return 'Syrian Pound';
			case 'currencyNames.SZL': return 'Lilangeni';
			case 'currencyNames.THB': return 'Baht';
			case 'currencyNames.TJS': return 'Somoni';
			case 'currencyNames.TMT': return 'Turkmenistan New Manat';
			case 'currencyNames.TND': return 'Tunisian Dinar';
			case 'currencyNames.TOP': return 'Pa’anga';
			case 'currencyNames.TRY': return 'Turkish Lira';
			case 'currencyNames.TTD': return 'Trinidad and Tobago Dollar';
			case 'currencyNames.TWD': return 'New Taiwan Dollar';
			case 'currencyNames.TZS': return 'Tanzanian Shilling';
			case 'currencyNames.UAH': return 'Hryvnia';
			case 'currencyNames.UGX': return 'Uganda Shilling';
			case 'currencyNames.USD': return 'US Dollar';
			case 'currencyNames.USN': return 'US Dollar (Next day)';
			case 'currencyNames.UYI': return 'Uruguay Peso en Unidades Indexadas (UI)';
			case 'currencyNames.UYU': return 'Peso Uruguayo';
			case 'currencyNames.UYW': return 'Unidad Previsional';
			case 'currencyNames.UZS': return 'Uzbekistan Sum';
			case 'currencyNames.VED': return 'Bolívar Soberano';
			case 'currencyNames.VES': return 'Bolívar Soberano';
			case 'currencyNames.VND': return 'Dong';
			case 'currencyNames.VUV': return 'Vatu';
			case 'currencyNames.WST': return 'Tala';
			case 'currencyNames.XAF': return 'CFA Franc BEAC';
			case 'currencyNames.XAG': return 'Silver';
			case 'currencyNames.XAU': return 'Gold';
			case 'currencyNames.XBA': return 'Bond Markets Unit European Composite Unit (EURCO)';
			case 'currencyNames.XBB': return 'Bond Markets Unit European Monetary Unit (E.M.U.-6)';
			case 'currencyNames.XBC': return 'Bond Markets Unit European Unit of Account 9 (E.U.A.-9)';
			case 'currencyNames.XBD': return 'Bond Markets Unit European Unit of Account 17 (E.U.A.-17)';
			case 'currencyNames.XCD': return 'East Caribbean Dollar';
			case 'currencyNames.XDR': return 'SDR (Special Drawing Right)';
			case 'currencyNames.XOF': return 'CFA Franc BCEAO';
			case 'currencyNames.XPD': return 'Palladium';
			case 'currencyNames.XPF': return 'CFP Franc';
			case 'currencyNames.XPT': return 'Platinum';
			case 'currencyNames.XSU': return 'Sucre';
			case 'currencyNames.XTS': return 'Codes specifically reserved for testing purposes';
			case 'currencyNames.XUA': return 'ADB Unit of Account';
			case 'currencyNames.XXX': return 'The codes assigned for transactions where no currency is involved';
			case 'currencyNames.YER': return 'Yemeni Rial';
			case 'currencyNames.ZAR': return 'Rand';
			case 'currencyNames.ZMW': return 'Zambian Kwacha';
			case 'currencyNames.ZWL': return 'Zimbabwe Dollar';
			default: return null;
		}
	}
}
