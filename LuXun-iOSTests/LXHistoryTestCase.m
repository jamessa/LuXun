//
//  LXCoreDataTestCase.m
//  LuXun-iOS
//
//  Created by jamie on 10/24/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LXHistory+Addons.h"
#import "LXAppDelegate.h"

@interface LXHistoryTestCase : XCTestCase{
  NSManagedObjectContext *context;
}

@end

@implementation LXHistoryTestCase {
  NSString *testRunString;
}

- (void)setUp
{
  [super setUp];
  testRunString = [NSString stringWithFormat:@"TestRun-%d",rand()];
  
  context = ((LXAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
  
  for (int i=0; i<10; i++) {
    [LXHistory trackTimeInterval:5.0-i*0.2 forReading:testRunString withContext:context];
  }
  
}

- (void)tearDown
{
  context = nil;
  [super tearDown];
}

- (void)testLastFiveResult {
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"History" inManagedObjectContext:context];
  [fetchRequest setEntity:entity];
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
  [fetchRequest setSortDescriptors:@[sortDescriptor]];
  
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"reading like %@", testRunString];
  [fetchRequest setPredicate:predicate];
  
  [fetchRequest setFetchLimit:5];
  
  NSError *error;
  NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
  if (fetchedObjects == nil) {
    NSLog(@"%@", [error localizedDescription]);
  }
  
  double total=0;
  for (LXHistory *history in fetchedObjects) {
    total += [history.responseTime doubleValue];
  }
  
  XCTAssertEqual(total, (double)18.0, @"Should be 18.");
  XCTAssertEqual((double)18.0, [[fetchedObjects valueForKeyPath:@"@sum.responseTime"] doubleValue], "Should be 18.");
}

- (void)testStoredProcedure {
  NSManagedObjectModel *model = [[context persistentStoreCoordinator] managedObjectModel];
  
  NSFetchRequest *fetchRequest = [model fetchRequestFromTemplateWithName:@"responseTimeForPinyin"
                                                   substitutionVariables:@{@"READING": testRunString}] ;
  
  NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:NO];
  [fetchRequest setSortDescriptors:@[sortDescriptor]];
  
  [fetchRequest setFetchLimit:5];
  
  NSError *error;
  NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
  if (fetchedObjects == nil) {
    NSLog(@"%@", [error localizedDescription]);
  }
  
  NSLog(@"%@", fetchRequest);
  double total=0;
  for (LXHistory *history in fetchedObjects) {
    total += [history.responseTime doubleValue];
  }
  
  XCTAssertEqual(total, (double)18.0, @"Should be 18.");
  XCTAssertEqual((double)18.0, [[fetchedObjects valueForKeyPath:@"@sum.responseTime"] doubleValue], "Should be 18.");

}

@end
