//
//  MainTableViewCell.m
//  GLNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 GoodLine. All rights reserved.
//

#import "MainTableCell.h"

@implementation MainTableCell

@synthesize imageNews;
@synthesize titleNews;
@synthesize descriptionNews;
@synthesize dateNews;
@synthesize imageView;

- (void)awakeFromNib {
   
    [super awakeFromNib];
    
    
    [self roundMyView:imageNews borderRadius:5.0f borderWidth:1.5f color:[UIColor orangeColor]];
    [self roundMyView:imageView borderRadius:3.0f borderWidth:1.0f color:[UIColor orangeColor]];
    //titleNews.backgroundColor = [UIColor greenColor];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)roundMyView:(UIView*)view
       borderRadius:(CGFloat)radius
        borderWidth:(CGFloat)border
              color:(UIColor*)color
{
    CALayer *layer = [view layer];
    layer.masksToBounds = YES;
    layer.cornerRadius = radius;
    layer.borderWidth = border;
    layer.borderColor = color.CGColor;
}

@end
