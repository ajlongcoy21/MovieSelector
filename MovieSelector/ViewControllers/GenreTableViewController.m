//
//  GenreTableViewController.m
//  MovieSelector
//
//  Created by Alan Longcoy on 5/27/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "GenreTableViewController.h"
#import "Genre.h"
#import "GenreCellTableViewCell.h"
#import "MovieSelectorViewController.h"

@interface GenreTableViewController ()

@end

@implementation GenreTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    self.selections = [NSMutableArray array];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // only 1 section for genres
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Table view rows will be the dynamic count of genre list
    return self.genres.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GenreCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GenreCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Genre *genre = [self.genres objectAtIndex:indexPath.row];
    cell.genreLabel.text = genre.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // obtain the selected cell
    
    GenreCellTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    // change the cell image by detecting which image it is and changing to the other image
    
    NSData *image1 = UIImagePNGRepresentation(cell.bubbleImage.image);
    NSData *image2 = UIImagePNGRepresentation([UIImage imageNamed:@"CircleChecked"]);
    
    if ([image1 isEqual:image2])
    {
        [cell.bubbleImage setImage:[UIImage imageNamed:@"CircleEmpty"]];
        [self.selections removeObject: [self.genres objectAtIndex:indexPath.row]];
    }
    else
    {
        [cell.bubbleImage setImage:[UIImage imageNamed:@"CircleChecked"]];
        [self.selections addObject: [self.genres objectAtIndex:indexPath.row]];
    }
    
    // reload the table to show the changes
    
    [self.tableView reloadData];
    
}

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // check if the back button was pressed
    if (self.isMovingFromParentViewController)
    {
        // hide navigation bar
        
        self.navigationController.navigationBar.hidden = YES;
        
        // Connect to the movie selection view controller to pass back the variables
        
        MovieSelectorViewController *movieSelectorController = (MovieSelectorViewController *)self.navigationController.topViewController;
        
        // pass back the selections for the correct movie lover
        
        if ([_movieLover intValue] == 1)
        {
            movieSelectorController.movieLoverOneSelections = self.selections;
            
            if (self.selections.count > 0)
            {
                [movieSelectorController.movieLoverOneButton setImage:[UIImage imageNamed:@"BubbleSelected"] forState:UIControlStateNormal];
            }
            else
            {
                [movieSelectorController noMovieLoverSelection];
            }
            
        }
        else if ([_movieLover intValue] == 2)
        {
            movieSelectorController.movieLoverTwoSelections = self.selections;
            
            if (self.selections.count > 0)
            {
                [movieSelectorController.movieLoverTwoButton setImage:[UIImage imageNamed:@"BubbleSelected"] forState:UIControlStateNormal];
            }
            else
            {
                [movieSelectorController noMovieLoverSelection];
            }
        }
        
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
