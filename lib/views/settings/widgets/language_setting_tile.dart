import 'package:flutter/material.dart';
import 'package:notoro/controllers/settings/settings_notifier.dart';
import 'package:notoro/core/utils/strings/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:world_flags/world_flags.dart";

class LanguageSettingTile extends StatelessWidget {
  const LanguageSettingTile({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<SettingsNotifier>();
    final currentLang = notifier.settings.languageCode;

    final theme = Theme.of(context);

    final languages = [
      {'code': 'en', 'name': AppStrings.english, 'flag': 'GBR'},
      {'code': 'pl', 'name': AppStrings.polish, 'flag': 'POL'},
      {'code': 'de', 'name': AppStrings.german, 'flag': 'DEU'},
      {'code': 'fr', 'name': AppStrings.french, 'flag': 'FRA'},
      {'code': 'es', 'name': AppStrings.spanish, 'flag': 'ESP'},
      {'code': 'it', 'name': AppStrings.italian, 'flag': 'ITA'},
      {'code': 'pt', 'name': AppStrings.portuguese, 'flag': 'PRT'},
    ];

    final currentLangName = languages.firstWhere(
      (lang) => lang['code'] == currentLang,
      orElse: () => languages.first,
    )['name'];

    return ListTile(
      title: Text(AppLocalizations.of(context)!.selectLanguage),
      subtitle: Text(currentLangName.toString()),
      leading: const Icon(Icons.language),
      onTap: () => showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (_) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  AppLocalizations.of(context)!.selectLanguage,
                  style: theme.textTheme.titleLarge,
                ),
              ),
              ...languages.map((lang) {
                final isSelected = lang['code'] == currentLang;
                return ListTile(
                  tileColor: isSelected
                      ? theme.colorScheme.primary.withAlpha(25)
                      : null,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CountryFlag.simplified(
                      WorldCountry.fromCode(lang['flag']!),
                      height: 32,
                      aspectRatio: 1.5,
                    ),
                  ),
                  title: Text(lang['name']!),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: Colors.green)
                      : null,
                  onTap: () {
                    notifier.updateLanguage(lang['code']!);
                    Navigator.pop(context);
                  },
                );
              }),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }
}
