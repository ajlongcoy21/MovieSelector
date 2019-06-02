//
//  MovieSelectorViewController.m
//  MovieSelector
//
//  Created by Alan Longcoy on 5/26/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "MovieSelectorViewController.h"
#import "MovieAPIClient.h"
#import "Genre.h"
#import "GenreTableViewController.h"

@interface MovieSelectorViewController ()

//@property (strong, nonatomic) NSMutableArray *movieGenres;

@end

@implementation MovieSelectorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // add tag ids to the buttons to be able to identify which button was clicked by the user
    
    _movieLoverOneButton.tag = 1;
    _movieLoverTwoButton.tag = 2;
    
    // Initialize Arrays
    
    self.movieLoverOneSelections = [NSMutableArray array];
    self.movieLoverTwoSelections = [NSMutableArray array];
    
    // hide navigation bar
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)movieLoverInput:(id)sender
{
        // debug code
    
        [self printGenreLists];
    
        // Create a URL Session and the URL needed for Movie Genre List
    
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [MovieAPIClient getMovieGenreURL];
    
        // Instantiate movieGenres Array
    
        self.movieGenres = [NSMutableArray array];
    
        // Create the download task for with the created movieGenreURL
    
        NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            // Create the data dictionary objects to pull the information from
            
            NSData *data = [[NSData alloc] initWithContentsOfURL:location];
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            // Create the array of dictionaries with Genre structure
            
            NSArray *dictionaries = [dictionary valueForKey:@"genres"];
            
            // For each dictionary in the array create the Genre Object and to the Genre array
            
            for (NSDictionary *dict in dictionaries)
            {
                Genre *genre = [Genre genreWithDictionary:dict];
                [self.movieGenres addObject:genre];
            }
            
            // Once we retrieve the data perform the segue to the tableview
            
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [self performSegueWithIdentifier: @"showGenreTableView" sender: sender];
            });
            
        }];
    
        // resume download task
    
        [task resume];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if (((UIButton *) sender).tag == 1)
     {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
         
         if([segue.identifier isEqualToString:@"showGenreTableView"])
         {
             // Connect to the next view controller and pass the necessary data for the tableview
             
             GenreTableViewController *genreTableViewController = segue.destinationViewController;
             genreTableViewController.genres = self.movieGenres;
             genreTableViewController.movieLover = [NSNumber numberWithInt:1];
         }
     }
     else if (((UIButton *) sender).tag == 2)
     {
         // Get the new view controller using [segue destinationViewController].
         // Pass the selected object to the new view controller.
         
         if([segue.identifier isEqualToString:@"showGenreTableView"])
         {
             // Connect to the next view controller and pass the necessary data for the tableview
             
             GenreTableViewController *genreTableViewController = segue.destinationViewController;
             genreTableViewController.genres = self.movieGenres;
             genreTableViewController.movieLover = [NSNumber numberWithInt:2];
         }
         
     }
}

- (void)printGenreLists
{
    NSLog(@"\n\nMovie Lover 1 Selections:\n");
    for (Genre *genreFromList1 in _movieLoverOneSelections)
    {
        [genreFromList1 printGenre];
    }
    NSLog(@"\n\nMovie Lover 2 Selections:\n");
    for (Genre *genreFromList2 in _movieLoverTwoSelections)
    {
        [genreFromList2 printGenre];
    }
}


@end
