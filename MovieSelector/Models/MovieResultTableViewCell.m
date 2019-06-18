//
//  MovieResultTableViewCell.m
//  MovieSelector
//
//  Created by Alan Longcoy on 6/16/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import "MovieResultTableViewCell.h"

@implementation MovieResultTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setMoviePosterImageString:(NSString *)moviePosterImageString
{
    _moviePosterImageString = moviePosterImageString;
    
    [self downloadImageWithPosterPath:moviePosterImageString];
}

-(void)downloadImageWithPosterPath:(NSString*)posterPath
{
    NSString * baseURLString = @"https://image.tmdb.org/t/p/original";
    NSMutableString *posterPathString = [NSMutableString stringWithFormat:@"/t/p/original%@", posterPath];
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *posterPathURL = [NSURL URLWithString:posterPathString relativeToURL:baseURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:posterPathURL cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.MoviePosterImage.image = image;
        });
        
    }];
    
    [task resume];
}

@end
