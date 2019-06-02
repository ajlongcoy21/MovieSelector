//
//  GenreTableViewController.h
//  MovieSelector
//
//  Created by Alan Longcoy on 5/27/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GenreTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *genres;
@property (strong, nonatomic) NSMutableArray *selections;
@property (strong, nonatomic) NSNumber *movieLover;

@end

NS_ASSUME_NONNULL_END
