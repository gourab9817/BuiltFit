import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutAppTile extends StatelessWidget {
  const AboutAppTile({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: Text(AppLocalizations.of(context)!.aboutApp),
      onTap: () => showAboutDialog(
        context: context,
        applicationName: AppLocalizations.of(context)!.appName,
        applicationVersion: '1.0.0',
        applicationIcon: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            !isDarkMode
                ? 'assets/branding/app_logo.png'
                : 'assets/branding/app_logo_light.png',
            width: 48,
            height: 48,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.fitness_center,
              size: 48,
            ),
          ),
        ),
        applicationLegalese: '© 2025 Adam Dybcio',
        children: [
          const SizedBox(height: 12),
          Text('GitHub: github.com/AdamDybcio/Notoro'),
        ],
      ),
    );
  }
}
