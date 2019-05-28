//
//  MovieSelectorViewController.h
//  MovieSelector
//
//  Created by Alan Longcoy on 5/26/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Genre.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieSelectorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *movieLoverOneButton;
@property (weak, nonatomic) IBOutlet UIButton *movieLoverTwoButton;
@property (strong, nonatomic) NSMutableArray *movieGenres;

@end

NS_ASSUME_NONNULL_END
