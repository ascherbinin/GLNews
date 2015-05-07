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
#import "TFHpple.h"

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
    
    NSURL *articleUrl = _newsElementDetail.articleUrl;
    NSData *articleHtmlData = [NSData dataWithContentsOfURL:articleUrl];
    
    TFHpple *articleParser = [TFHpple hppleWithHTMLData:articleHtmlData];
    
    NSString *articleXpathQueryString = @"//div[@class='topic-content text']";

    //    NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
    
    NSArray *articleNodes = [articleParser searchWithXPathQuery:articleXpathQueryString];
   for (TFHppleElement *element in articleNodes)
   {
        
//        TFHppleElement *imageUrl =  [element firstChildWithTagName:@"img"];
//        [imagesArray addObject:[imageUrl objectForKey:@"src"]];
//        for (TFHppleElement *child in element.children) {
//            if ([child.tagName isEqualToString:@"img"]) {
//                @try {
//                }
//                @catch (NSException *e) {}
//            }
//        }
       
      // NSString* tempStr = [[element content] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
      // NSLog(@"%@",[tempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]);
       //NSMutableString* temp = [NSMutableString stringWithString:[element raw]];
       //[temp replaceOccurrencesOfString:@"<br/>" withString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(0, temp.length)];
       //NSLog(@"%@", temp);
       self.textView.text = [[element content] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        

    }
    
    
    
    
    NSArray* image = [_newsElementDetail imagesFromContent:_newsElementDetail.imageUrl];
    NSString *imageStringURL = [image objectAtIndex:0];
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
