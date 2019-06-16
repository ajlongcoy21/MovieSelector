//
//  Movie.m
//  MovieSelector
//
//  Created by Alan Longcoy on 6/15/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "Movie.h"

@implementation Movie

+ (instancetype) movieWithDictionary:(NSDictionary *) dictionary
{
    // create a genre object
    
    Movie *movie = [[Movie alloc] init];
    
    // if genre created successfully add the properties to the genre and return
    
    if (movie)
    {
        movie.title = [dictionary valueForKeyPath:@"title"];
        movie.posterPath = [dictionary valueForKeyPath:@"poster_path"];
        movie.releaseDate = [dictionary valueForKey:@"release_date"];
    }
    
    return movie;
}

- (void) printMovie
{
    NSLog(@"\nMovie Title: %@\nMovie PosterPath: %@\nMovie Release Date: %@", self.title, self.posterPath, self.releaseDate);
    
}

@end
