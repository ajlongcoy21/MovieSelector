//
//  MovieAPIClient.h
//  MovieSelector
//
//  Created by Alan Longcoy on 5/26/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Genre.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieAPIClient : NSObject

extern NSString *const apiKey;
extern NSString *const baseURL;

+(NSURL *) getMovieGenreURL;
+(NSURL *) discoverMovieURL:(NSMutableArray *) genreList;

@end

NS_ASSUME_NONNULL_END
