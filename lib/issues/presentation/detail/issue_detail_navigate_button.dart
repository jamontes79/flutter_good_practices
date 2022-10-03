import 'package:flutter/material.dart';
import 'package:flutter_good_practices/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class IssueNavigateButton extends StatelessWidget {
  const IssueNavigateButton({super.key, required this.url});
  final String url;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            key: const Key('url_navigator'),
            onPressed: _launchUrl,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            child: Text(
              l10n.issueNavigate,
              key: const Key('url_navigator_text'),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl() async {
    final uri = Uri.parse(url);
    await launchUrl(uri);
  }
}
