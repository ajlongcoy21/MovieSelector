//
//  Movie.h
//  MovieSelector
//
//  Created by Alan Longcoy on 6/15/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic, strong) NSString *releaseDate;

+ (instancetype) movieWithDictionary:(NSDictionary *) dictionary;
- (void) printMovie;

@end

NS_ASSUME_NONNULL_END
