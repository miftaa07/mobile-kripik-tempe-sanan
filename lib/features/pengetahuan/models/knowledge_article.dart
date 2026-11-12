import 'package:flutter/material.dart';

class KnowledgeArticle {
  final String title;
  final String subtitle;
  final IconData icon;
  final String introduction;
  final List<KnowledgeSection> sections;

  const KnowledgeArticle({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.introduction,
    required this.sections,
  });
}

class KnowledgeSection {
  final String title;
  final String body;

  const KnowledgeSection({required this.title, required this.body});
}
