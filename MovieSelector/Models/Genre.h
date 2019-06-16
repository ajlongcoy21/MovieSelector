//
//  Genre.h
//  MovieSelector
//
//  Created by Alan Longcoy on 5/26/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Genre : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *genreID;

+ (instancetype) genreWithDictionary:(NSDictionary *) dictionary;
- (void) printGenre;

@end

NS_ASSUME_NONNULL_END
