//
//  MovieAPIClient.m
//  MovieSelector
//
//  Created by Alan Longcoy on 5/26/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "MovieAPIClient.h"

@implementation MovieAPIClient

// Create constants for retrieving data from the api

NSString * const apiKey = @"eb84cf269c13d015f77d053434245ab2";
NSString * const baseURLString = @"https://api.themoviedb.org/";

+(NSURL *) getMovieGenreURL
{
    // Create the part of the URL for retrieving movie genres
    
    NSString *movieGenreURLString = [NSString stringWithFormat:@"3/genre/movie/list?api_key=%@&language=en-US", apiKey];
    
    // create base URL and complete URL by combining movieGeneralURLString and baseURL
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *genreURL = [NSURL URLWithString:movieGenreURLString relativeToURL:baseURL];
    
    // return URL
    
    return genreURL;
    
}

+(NSURL *) discoverMovieURL:(NSMutableArray *) genreList
{
    NSString *genreIDString;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSMutableString *movieSearchURLString = [NSMutableString stringWithFormat:@"3/discover/movie?api_key=%@&language=en-US&sort_by=release_date.desc&include_adult=false&include_video=false&page=1&release_date.lte=%@&with_genres=", apiKey, [dateFormatter stringFromDate:NSDate.date].description];
    
    NSNumber *count = 0;
    
    for (Genre *genreSelection in genreList)
    {
        if (count.intValue == genreList.count-1)
        {
            //[genreIDString initWithFormat:@"%li", (long)genreSelection.genreID.integerValue];
            genreIDString = [NSString stringWithFormat:@"%li", (long)genreSelection.genreID.integerValue];
            [movieSearchURLString appendString:genreIDString];
        }
        else
        {
            //[genreIDString initWithFormat:@"%li,", (long)genreSelection.genreID.integerValue];
            genreIDString = [NSString stringWithFormat:@"%li,", (long)genreSelection.genreID.integerValue];
            [movieSearchURLString appendString:genreIDString];
        }
  
        count = [NSNumber numberWithInt:count.intValue+1];
        
    }
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *discoverMovieURL = [NSURL URLWithString:movieSearchURLString relativeToURL:baseURL];
    
    return discoverMovieURL;
    
}

@end
