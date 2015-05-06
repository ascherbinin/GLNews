//
//  MainTableViewCell.h
//  GLNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 GoodLine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageNews;
@property (strong, nonatomic) IBOutlet UILabel *titleNews;
@property (strong, nonatomic) IBOutlet UILabel *descriptionNews;

@end
