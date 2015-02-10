//
//  TextField.m
//  Peak
//
//  Created by Vitaly Berg on 09/02/15.
//  Copyright (c) 2015 Peak. All rights reserved.
//

#import "TextField.h"

#import "UIColor+Helper.h"

static void * TextFieldEditingObservingContext = &TextFieldEditingObservingContext;

@implementation TextField

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == TextFieldEditingObservingContext) {
        if (self.editing) {
            self.layer.shadowOpacity = 1;
        } else {
            self.layer.shadowOpacity = 0;
        }
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    //style.alignment = NSTextAlignmentCenter;
    id attributes = @{NSParagraphStyleAttributeName: style, NSFontAttributeName: self.font, NSForegroundColorAttributeName: RGB(182, 190, 198)};
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:attributes];
}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    CGRect rect = [super caretRectForPosition:position];
    rect.size.width = 1;
    return rect;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    //NSLog(@"%s", __func__);
    //NSLog(@"bounds: %@", NSStringFromCGRect(bounds));
    CGRect r = [super textRectForBounds:bounds];
    //NSLog(@"%@", NSStringFromCGRect(r));
    if (self.textAlignment == NSTextAlignmentLeft) {
        r.origin.x = 9;
        r.size.width -= 18;
    }
    
    return r;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    //NSLog(@"%s", __func__);
    //NSLog(@"bounds: %@", NSStringFromCGRect(bounds));
    CGRect r = [super placeholderRectForBounds:bounds];
    //NSLog(@"%@", NSStringFromCGRect(r));
    if (self.textAlignment == NSTextAlignmentLeft) {
        r.origin.x = 9;
        r.size.width -= 18;
    }
    return r;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    //NSLog(@"%s", __func__);
    //NSLog(@"bounds: %@", NSStringFromCGRect(bounds));
    CGRect r = [super editingRectForBounds:bounds];
    //NSLog(@"%@", NSStringFromCGRect(r));
    if (self.textAlignment == NSTextAlignmentLeft) {
        r.origin.x = 9;
        r.size.width -= 18;
    }
    return r;
}

- (void)bingo {
    if (self.editing) {
        self.layer.borderColor = RGB(85, 162, 255).CGColor;
    } else {
        self.layer.borderColor = RGB(64, 74, 84).CGColor;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.placeholder = self.placeholder;
    self.backgroundColor = RGB(32, 36, 42);
    self.textColor = RGB(182, 190, 198);
    self.tintColor = RGB(182, 190, 198);
    
    self.layer.borderColor = RGB(64, 74, 84).CGColor;
    self.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    self.layer.cornerRadius = 2;
    
    [self addObserver:self forKeyPath:@"editing" options:NSKeyValueObservingOptionNew context:nil];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 1;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bingo) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bingo) name:UITextFieldTextDidEndEditingNotification object:self];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"editing" context:nil];
}

@end
