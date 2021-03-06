//
//  TableViewController.m
//  Flashcard_HW5
//
//  Created by Mana Mehraein on 4/11/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import "TableViewController.h"
#import "FlashcardsModel.h"
#import "Flashcard.h"
#import "ViewController.h"
#import "AddViewController.h"

@interface TableViewController ()
@property (strong, nonatomic) FlashcardsModel* model;
@property(nonatomic, readonly, copy) NSString *reuseIdentifier;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [FlashcardsModel sharedModel];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    // [ self.tableView reloadData];
}

-(void) viewWillAppear:(BOOL)animated{
    // [super viewDidAppear];
    
    [ self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model numberOfFlashcards];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Flashcard* flashcard = [self.model flashcardAtIndex: indexPath.row ];
    cell.textLabel.text = [flashcard question];
    cell.detailTextLabel.text =[ flashcard question];
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.model removeFlashcardAtIndex: indexPath.row];
        [tableView reloadData];
        
        // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
        
        
    }
    
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"addFlashcardSegue"])
    {
        AddViewController* avc=[segue destinationViewController];
        
        avc.qTitle =@"Add new Question";
        avc.ansHolder = @"Add New Answer";
        
        avc.addBlock = ^(NSString* question, NSString* answer)
        {
            if(question !=nil && answer != nil)
            {
                // Add to model
                [self.model insertWithQuestion: question answer: answer favorite:NO];
                //NSLog(@"what is happening");
                //update the table view
                [self.tableView reloadData];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
            
        };
    
    }
}


@end
