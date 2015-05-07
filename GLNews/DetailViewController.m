//
//  DetailViewController.m
//  GLNews
//
//  Created by Admin on 07.05.15.
//  Copyright (c) 2015 GoodLine. All rights reserved.
//

#import "DetailViewController.h"
#import "NewsElement.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController ()  <UIActionSheetDelegate>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Open"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(openNews)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setDetails:(NewsElement*)reciveDetail;
{
    _newsElementDetail = reciveDetail;
    
    
    NSLog(@"%@",_newsElementDetail.titleText);
    NSLog(@"%@",self.textView.text );
}



-(void)openNews
{
   
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Назад" destructiveButtonTitle:nil otherButtonTitles:@"Открыть",@"Открыть в браузере", nil];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            
            break;
        case 1:
            [[UIApplication sharedApplication] openURL:_newsElementDetail.articleUrl];
            break;
        default:
            break;
    }
}

-(void) reloadData
{
    if(!_newsElementDetail)
    {
        return;
    }
    self.navigationItem.title = _newsElementDetail.dateNewsText;
    self.titleLable.text = _newsElementDetail.titleText;
    self.textView.text = _newsElementDetail.descriptionText;
    NSArray* images = [_newsElementDetail imagesFromContent:_newsElementDetail.imageUrl];
    NSString *imageStringURL = [images objectAtIndex:0];
    NSURL* imageURL = [NSURL URLWithString: imageStringURL];
    [self.imageView setImageWithURL: imageURL];
    NSLog(@"%@",_newsElementDetail.imageName);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
