@interface CCEDictionaryInformation : NSObject
{
  struct __IDXIndex *indexRef;
  unsigned long long dataEncoding;
  struct __CFString *searchMethod;
  NSString *searchString;
  BOOL searchHasBegun;
  BOOL searchFinished;
  char *dataPtrs[100];
  long long dataSizes[100];
  unsigned long long numberOfResults;
  unsigned long long resultCounter;
  NSMutableDictionary *dataUnpackingNameDictionary;
  NSString *dataUnpackingSeparator;
}

- (void)deleteEntry:(id)arg1 forKey:(id)arg2;
- (void)addEntry:(id)arg1 forKey:(id)arg2;
- (void)setSearchMethod:(int)arg1;
- (void)setDataUnpackingNames:(id)arg1 separator:(id)arg2;
- (void)searchForAllElements;
- (void)setSearchString:(id)arg1;
- (void)cleanForNewSearch;
- (void)dealloc;
- (id)init;
- (id)_createDataForDictionary:(id)arg1;

@end

@interface CCEDictionaryController : NSObject
{
  NSMapTable *_dictionaryIdentifiers;
  CCEDictionaryInformation *_currentSearchSession;
  NSArray *_currentIdentifiers;
  unsigned long long _currentIdentifierCounter;
}

- (void)deleteEntry:(id)arg1 forKey:(id)arg2 identifier:(id)arg3;
- (void)addEntry:(id)arg1 forKey:(id)arg2 identifier:(id)arg3;
- (BOOL)entryExists:(id)arg1 forKey:(id)arg2 identifier:(id)arg3;
- (id)allEntriesInDictionaryWithIdentifier:(id)arg1;
- (void)setSearchMethod:(int)arg1 forIdentifiers:(id)arg2;
- (void)setDataUnpackingNames:(id)arg1 separator:(id)arg2 forIdentifiers:(id)arg3;
- (void)setDataUnpackingEncoding:(unsigned long long)arg1 forIdentifiers:(id)arg2;
- (BOOL)setIdentifier:(id)arg1 forDictionaryWithPath:(id)arg2;
- (void)createDictionaryAtPath:(id)arg1;
- (BOOL)dictionaryExistsAtPath:(id)arg1;
- (id)allCandidates;
- (id)nextCandidate;
- (void)setSearchString:(id)arg1 forIdentifiers:(id)arg2;
- (void)dealloc;
- (id)init;
- (id)_convertedSearchResult:(id)arg1;
- (id)_nextSearchResult;
- (void)_initializeForNewSearch;
- (struct __IDXIndex *)_indexRefForIdentifier:(id)arg1;
- (id)_holderForIdentifier:(id)arg1;

@end

#define CIMCharacterInformationRepositoryScriptTypeTraditionalChinese 1

@interface CIMCharacterInformationRepository : NSObject
{
  unsigned long long _scriptType;
  CCEDictionaryController *_dictionaryController;
}

@property(nonatomic) unsigned long long scriptType; // @synthesize scriptType=_scriptType;
@property(readonly, nonatomic) CCEDictionaryController *dictionaryController; // @synthesize dictionaryController=_dictionaryController;
- (NSString*)combinedZhuyinReadingsForCharacter:(NSString*)arg1;
- (NSString*)combinedPinyinReadingsForCharacter:(NSString*)arg1;
- (NSDictionary*)pinyinReadingsForCharacters:(NSString*)arg1;
- (id)inputCodesForCharacter:(id)arg1 modes:(id)arg2;
- (void)dealloc;
- (id)initWithScriptType:(unsigned long long)arg1;

@end

@interface NSString (CIMCandidateController)
- (id)firstLogicalCharacter;
- (id)stringByStrippingDiacritics;
- (long long)traditionalChineseZhuyinCompare:(id)arg1;
- (long long)traditionalChinesePinyinCompare:(id)arg1;
- (long long)simplifiedChineseCompare:(id)arg1;
@end