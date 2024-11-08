import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void addLicences() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/Jura/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}
