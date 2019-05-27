//
//  MovieAPIClient.m
//  MovieSelector
//
//  Created by Alan Longcoy on 5/26/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "MovieAPIClient.h"

@implementation MovieAPIClient

NSString * const apiKey = @"eb84cf269c13d015f77d053434245ab2";
NSString * const baseURLString = @"https://api.themoviedb.org/";

+(NSURL *) getMovieGenreURL
{
    NSString *movieGenreURLString = [NSString stringWithFormat:@"3/genre/movie/list?api_key=%a&language=en-US", apiKey];
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *genreURL = [NSURL URLWithString:movieGenreURLString relativeToURL:baseURL];
    
    NSLog(genreURL.absoluteString);
    
    return genreURL;
    
}

@end
