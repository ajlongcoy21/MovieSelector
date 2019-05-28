//
//  Genre.m
//  MovieSelector
//
//  Created by Alan Longcoy on 5/26/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "Genre.h"

@implementation Genre

+ (instancetype) genreWithDictionary:(NSDictionary *) dictionary
{
    // create a genre object
    
    Genre *genre = [[Genre alloc] init];
    
    // if genre created successfully add the properties to the genre and return
    
    if (genre)
    {
        genre.name = [dictionary valueForKeyPath:@"name"];
        genre.genreID = [dictionary valueForKeyPath:@"id"];
    }
    
    return genre;
}

@end
