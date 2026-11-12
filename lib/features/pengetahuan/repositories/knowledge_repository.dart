import '../data_sources/knowledge_local_data_source.dart';
import '../models/knowledge_article.dart';

class KnowledgeRepository {
  final KnowledgeLocalDataSource _dataSource;

  const KnowledgeRepository(this._dataSource);

  List<KnowledgeArticle> getArticles() => _dataSource.getArticles();
}
