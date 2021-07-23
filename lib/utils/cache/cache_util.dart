
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CatcheUtil {
  static const fontKey = 'fontCacheKey';
  static CacheManager instanceFont = CacheManager(
    Config(
      fontKey,
      stalePeriod: const Duration(days: 1000),
      maxNrOfCacheObjects: 20,
      repo: JsonCacheInfoRepository(databaseName: fontKey),
      // fileSystem: IOFileSystem(key),
      fileService: HttpFileService(),
    ),
  );
  
}
