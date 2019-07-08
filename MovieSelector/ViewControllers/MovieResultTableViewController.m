//
//  MovieResultTableViewController.m
//  MovieSelector
//
//  Created by Alan Longcoy on 6/16/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "MovieResultTableViewController.h"
#import "MovieResultTableViewCell.h"
#import "Movie.h"
#import "MovieSelectorViewController.h"

@interface MovieResultTableViewController ()

@end

@implementation MovieResultTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movieResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"movieCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    //Movie *movie = [self.movieResults objectAtIndex:indexPath.row];
    
    //cell.MovieTitle.text = movie.title;
    //cell.MovieReleseDate.text = movie.releaseDate;
    //cell.moviePosterImageString = movie.posterPath;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(MovieResultTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    
    Movie *movie = [self.movieResults objectAtIndex:indexPath.row];
    
    cell.MovieTitle.text = movie.title;
    cell.MovieReleseDate.text = movie.releaseDate;
    cell.moviePosterImageString = movie.posterPath;
    
}

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
        
        // reset the selections for the movie lovers
        
        movieSelectorController.viewResultsButton.hidden = TRUE;
        movieSelectorController.viewResultsButton.enabled = TRUE;
        movieSelectorController.movieLoverOneSelections = [NSMutableArray array];
        movieSelectorController.movieLoverTwoSelections = [NSMutableArray array];
        [movieSelectorController.movieLoverOneButton setImage:[UIImage imageNamed:@"BubbleEmpty"] forState:UIControlStateNormal];
        [movieSelectorController.movieLoverTwoButton setImage:[UIImage imageNamed:@"BubbleEmpty"] forState:UIControlStateNormal];
        
        
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
