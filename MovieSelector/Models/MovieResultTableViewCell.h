//
//  MovieResultTableViewCell.h
//  MovieSelector
//
//  Created by Alan Longcoy on 6/16/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieResultTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *MoviePosterImage;
@property (weak, nonatomic) IBOutlet UILabel *MovieTitle;
@property (weak, nonatomic) IBOutlet UILabel *MovieReleseDate;
@property (weak, nonatomic) NSString *moviePosterImageString;


@end

NS_ASSUME_NONNULL_END
