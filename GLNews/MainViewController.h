//
//  MainViewController.h
//  GLNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 GoodLine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) IBOutlet UITableView *sampleTableView;
@property (nonatomic, strong) NSArray *items;

@end
