//
//  LXCoreDataTestCase.m
//  LuXun-iOS
//
//  Created by jamie on 10/24/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LXHistory.h"
#import "LXAppDelegate.h"

@interface LXCoreDataTestCase : XCTestCase{
  NSManagedObjectContext *context;
}

@end

@implementation LXCoreDataTestCase {
  NSString *testRunString;
}

- (void)setUp
{
  [super setUp];
  testRunString = [NSString stringWithFormat:@"TestRun-%d",rand()];
  
  context = ((LXAppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
}

- (void)tearDown
{
  context = nil;
  [super tearDown];
}

- (void)testInsert
{
  for (int i=0; i<50; i++) {
    LXHistory *history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:context];
    history.timestamp = [NSDate date];
    history.reading = testRunString;
    history.responseTime = @(5.0-i*0.1);
    [context save:nil];
  }
}

- (void)testLastFiveResult {
  for (int i=0; i<10; i++) {
    LXHistory *history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:context];
    history.timestamp = [NSDate date];
    history.reading = testRunString;
    history.responseTime = @(5.0-i*0.2);
    [context save:nil];
  }
  
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
  for (int i=0; i<10; i++) {
    LXHistory *history = [NSEntityDescription insertNewObjectForEntityForName:@"History" inManagedObjectContext:context];
    history.timestamp = [NSDate date];
    history.reading = testRunString;
    history.responseTime = @(5.0-i*0.2);
    [context save:nil];
  }

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
