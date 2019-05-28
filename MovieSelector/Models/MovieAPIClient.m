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
    
    //NSLog(genreURL.absoluteString);
    
    // return URL
    
    return genreURL;
    
}

@end
