//
//  LXStatisticViewController.m
//  LuXun-iOS
//
//  Created by jamie on 10/25/13.
//  Copyright (c) 2013 2think. All rights reserved.
//

#import "LXStatisticViewController.h"
#import "LXMemory.h"

@interface LXStatisticViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

- (IBAction)doneHandler:(id)sender;

@end

@implementation LXStatisticViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  
  NSError *error;
  if(![[self fetchedResultsController] performFetch:&error]) {
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
  }
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [[self.fetchedResultsController sections]count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  NSArray *titles = @[@"常用音",@"次常用音",@"次次常用音",@"罕常用音"];

  NSUInteger numberOfObjects = [[[self.fetchedResultsController sections] objectAtIndex:section ] numberOfObjects];
  
  return [NSString stringWithFormat:@"%@ (%ld)", titles[section], (unsigned long)numberOfObjects];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
  
  
  LXMemory *aMemory = (LXMemory*)[self.fetchedResultsController objectAtIndexPath:indexPath];
  cell.textLabel.text = aMemory.reading;
  cell.detailTextLabel.text = [NSString stringWithFormat:@"%3.2fs", aMemory.timeNeeded];
  
  return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
  if (_fetchedResultsController) {
    return _fetchedResultsController;
  }
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  NSEntityDescription *entity = [NSEntityDescription entityForName:@"Memory" inManagedObjectContext:self.managedObjectContext];
  [fetchRequest setEntity:entity];
  NSSortDescriptor *byFrequency = [[NSSortDescriptor alloc] initWithKey:@"section" ascending:YES];
  NSSortDescriptor *byTimeNeeded = [[NSSortDescriptor alloc] initWithKey:@"timeNeeded" ascending:YES];
  NSSortDescriptor *byWeight = [[NSSortDescriptor alloc] initWithKey:@"weight" ascending:NO];
  [fetchRequest setSortDescriptors:@[byFrequency, byTimeNeeded, byWeight]];
  
  _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"section" cacheName:nil];
  
  _fetchedResultsController.delegate = self;
  return _fetchedResultsController;
}

- (IBAction)doneHandler:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
