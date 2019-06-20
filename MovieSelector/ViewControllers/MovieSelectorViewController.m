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
#import "Movie.h"
#import "GenreTableViewController.h"
#import "MovieResultTableViewController.h"

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
    
    // hide view results button
    
    _viewResultsButton.hidden = TRUE;
    
    // Initialize Arrays
    
    self.movieLoverOneSelections = [NSMutableArray array];
    self.movieLoverTwoSelections = [NSMutableArray array];
    
    // hide navigation bar
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)movieLoverInput:(id)sender
{
    _movieLoverOneButton.enabled = FALSE;
    _movieLoverTwoButton.enabled = FALSE;
    
        // Create a URL Session and the URL needed for Movie Genre List
    
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [MovieAPIClient getMovieGenreURL];
    
        // Instantiate movieGenres Array
    
        self.movieGenres = [NSMutableArray array];
    
        // Create the download task for with the created movieGenreURL
    
        NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
        {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            
            if (error != NULL)
            {
                [self alertMessageForUser:error.localizedDescription];
                self.movieLoverOneButton.enabled = TRUE;
                self.movieLoverTwoButton.enabled = TRUE;
            }
            
            else
            {
                // Create the data dictionary objects to pull the information from
                
                NSData *data = [[NSData alloc] initWithContentsOfURL:location];
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                if (httpResponse.statusCode == 401)
                {
                    [self alertMessageForUser:[dictionary valueForKey:@"status_message"]];
                    self.movieLoverOneButton.enabled = TRUE;
                    self.movieLoverTwoButton.enabled = TRUE;
                }
                
                else if (httpResponse.statusCode == 404)
                {
                    [self alertMessageForUser:[dictionary valueForKey:@"status_message"]];
                    self.movieLoverOneButton.enabled = TRUE;
                    self.movieLoverTwoButton.enabled = TRUE;
                }
                
                else
                {
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
                       if ([self shouldPerformSegueWithIdentifier:@"showGenreTableView" sender: sender])
                       {
                           [self performSegueWithIdentifier: @"showGenreTableView" sender: sender];
                       }
                       
                   });
                }
            }
        }];
    
        // resume download task
    
        [task resume];
}

- (IBAction)getMovieSelections:(id)sender
{
    _viewResultsButton.enabled = FALSE;
    
    NSMutableArray *movieGenreSelections = [NSMutableArray array];
    
    [movieGenreSelections addObjectsFromArray:_movieLoverOneSelections];
    [movieGenreSelections addObjectsFromArray:_movieLoverTwoSelections];
    
    // Create a URL Session and the URL needed for Movie Genre List
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [MovieAPIClient discoverMovieURL: movieGenreSelections];
    
    // Instantiate movieResults Array
    
    self.movieResults = [NSMutableArray array];
    
    // Create the download task for with the created discoverMovieURL
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
          {
              
              NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
              
              if (error != NULL)
              {
                  [self alertMessageForUser:error.localizedDescription];
                  self.movieLoverOneButton.enabled = TRUE;
                  self.movieLoverTwoButton.enabled = TRUE;
              }
              
              else
              {
                  NSData *data = [[NSData alloc] initWithContentsOfURL:location];
                  NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                  
                  if (httpResponse.statusCode == 401)
                  {
                      [self alertMessageForUser:[dictionary valueForKey:@"status_message"]];
                      self.movieLoverOneButton.enabled = TRUE;
                      self.movieLoverTwoButton.enabled = TRUE;
                  }
                  
                  else if (httpResponse.statusCode == 404)
                  {
                      [self alertMessageForUser:[dictionary valueForKey:@"status_message"]];
                      self.movieLoverOneButton.enabled = TRUE;
                      self.movieLoverTwoButton.enabled = TRUE;
                  }
                  
                  else
                  {
                      // Create the array of dictionaries with Movie structure

                      long totalResults = [[dictionary valueForKey:@"total_results"] integerValue];
                      NSArray *dictionaries = [dictionary valueForKey:@"results"];
                      
                      if (totalResults == 0)
                      {
                          dispatch_async(dispatch_get_main_queue(), ^
                         {
                             self.viewResultsButton.hidden = TRUE;
                             self.movieLoverOneSelections = [NSMutableArray array];
                             self.movieLoverTwoSelections = [NSMutableArray array];
                             [self.movieLoverOneButton setImage:[UIImage imageNamed:@"BubbleEmpty"] forState:UIControlStateNormal];
                             [self.movieLoverTwoButton setImage:[UIImage imageNamed:@"BubbleEmpty"] forState:UIControlStateNormal];
                             
                         });
                          
                          
                          [self alertMessageForUser:@"There were no results for your selection of genres. Please select 1 or 2 genres to increase the chances of finding movies."];
                      }
                      else
                      {
                          // For each dictionary in the array create the Movie Object and add to the Movie array
                          
                          for (NSDictionary *dict in dictionaries)
                          {
                              Movie *movie = [Movie movieWithDictionary:dict];
                              [self.movieResults addObject:movie];
                          }
                          
                          // Once we retrieve the data perform the segue to the tableview
                          
                          dispatch_async(dispatch_get_main_queue(), ^
                         {
                             [self performSegueWithIdentifier: @"showMovieResults" sender: sender];
                             
                         });
                      }
                  }
              }
              
          }];
    
    // resume download task
    
    [task resume];
    
}



#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender;
{
    if (((UIButton *) sender).tag == 1 && _movieLoverOneSelections.count > 0 && [identifier isEqualToString:@"showGenreTableView"])
    {
        [self alertMessageForUser:@"You already selected your movie genres. Let your fellow movie watcher select some as well :D."];
        return false;
    }
    else if (((UIButton *) sender).tag == 2 && _movieLoverTwoSelections.count > 0 && [identifier isEqualToString:@"showGenreTableView"])
    {
        [self alertMessageForUser:@"You already selected your movie genres. Let your fellow movie watcher select some as well :D."];
        return false;
    }
    else
    {
        return true;
    }
}

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
     
     if([segue.identifier isEqualToString:@"showMovieResults"])
     {
         MovieResultTableViewController *movieTableViewController = segue.destinationViewController;
         movieTableViewController.movieResults = self.movieResults;
         
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

- (void)noMovieLoverSelection
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Selection" message:@"Please choose at least 1 movie genre you would like to watch." preferredStyle:UIAlertControllerStyleAlert];
    
    //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil]; //You can use a block here to handle a press on this button
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)alertMessageForUser: (NSString *) alertMessage
{
    NSString *message = [NSString stringWithFormat:@"%@", alertMessage];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"OOPS!" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil]; //You can use a block here to handle a press on this button
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
