//
//  GenreCellTableViewCell.h
//  MovieSelector
//
//  Created by Alan Longcoy on 5/27/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GenreCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImage;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;


@end

NS_ASSUME_NONNULL_END
