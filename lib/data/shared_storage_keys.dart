// TODO: Migrate everything to this enum.
enum SharedStorageKeys {
  themeMode('themeModeKey');

  const SharedStorageKeys(this.key);

  final String key;
}
