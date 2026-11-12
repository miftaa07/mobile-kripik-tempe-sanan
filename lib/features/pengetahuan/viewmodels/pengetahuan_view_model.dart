import '../models/knowledge_article.dart';
import '../repositories/knowledge_repository.dart';

class PengetahuanViewModel {
  final KnowledgeRepository _repository;

  const PengetahuanViewModel(this._repository);

  List<KnowledgeArticle> get articles => _repository.getArticles();
}
