//
//  IBOutlint.m
//  IBOutlint
//
//  Created by Marcelo Fabri on 28/01/16.
//  Copyright © 2016 Marcelo Fabri. All rights reserved.
//

#import "IBOutlint.h"

@interface DVTTextStorage : NSTextStorage

- (void)replaceCharactersInRange:(struct _NSRange)arg1 withString:(id)arg2 withUndoManager:(id)arg3;

@end

@interface IBOutlint()

@property (nonatomic, strong, readwrite) NSBundle *bundle;

@end

@implementation IBOutlint

+ (instancetype)sharedPlugin {
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin {
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }

    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti {
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editorDocumentChanged:) name:@"IDEEditorDocumentDidChangeNotification" object:nil];
}

- (void)editorDocumentChanged:(NSNotification *)notification {
    NSArray *array = notification.userInfo[@"IDEEditorDocumentChangeLocationsKey"];
    id firstChange = array.firstObject;

    NSURL *url = [firstChange valueForKey:@"documentURL"];
    if (![url isKindOfClass:[NSNull class]]) {
        NSRange range = [[firstChange valueForKey:@"characterRange"] rangeValue];

        // Check if it's a valid range
        if (range.length == 0 || range.location == NSNotFound) {
            return;
        }

        // Check if it's an IDESourceCodeDocument
        if (![notification.object respondsToSelector:@selector(textStorage)]) {
            return;
        }

        id textStorage = [notification.object textStorage];
        NSAttributedString *attributed;

        @try {
            attributed = [textStorage attributedSubstringFromRange:range];
        }
        @catch (NSException *exception) {
            return;
        }

        NSString *substring = attributed.string;

        NSDictionary *mapping = @{
                                  @"@property (weak, nonatomic) IBOutlet " : @"@property (nonatomic, weak) IBOutlet ",
                                  @"@property (strong, nonatomic) IBOutlet " : @"@property (nonatomic, strong) IBOutlet "
                                  };

        [mapping enumerateKeysAndObjectsUsingBlock:^(NSString *prefix, NSString *replacement, BOOL * _Nonnull stop) {
            if ([substring hasPrefix:prefix]) {
                NSString *updatedSubstring = [substring stringByReplacingOccurrencesOfString:prefix withString:replacement];

                [textStorage beginEditing];
                [textStorage replaceCharactersInRange:range withString:updatedSubstring withUndoManager:nil];
                [textStorage endEditing];
            }
        }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
