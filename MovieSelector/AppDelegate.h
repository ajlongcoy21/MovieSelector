//
//  AppDelegate.h
//  MovieSelector
//
//  Created by Alan Longcoy on 5/26/19.
//  Copyright © 2019 Alan Longcoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

