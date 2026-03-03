import '../models/mood_entry.dart';
import '../services/local_db_service.dart';

class MoodRepository {
  MoodRepository(this._dbService);

  final LocalDbService _dbService;

  Future<List<MoodEntry>> getEntries() => _dbService.getEntries();

  Future<void> saveEntry(MoodEntry entry) => _dbService.insertEntry(entry);
}
