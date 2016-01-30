//
//  IBOutlint.h
//  IBOutlint
//
//  Created by Marcelo Fabri on 28/01/16.
//  Copyright © 2016 Marcelo Fabri. All rights reserved.
//

#import <AppKit/AppKit.h>

@class IBOutlint;

static IBOutlint *sharedPlugin;

@interface IBOutlint : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;

@end