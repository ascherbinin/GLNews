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
#import "RDHelper.h"

@interface DetailViewController ()  <UIActionSheetDelegate>

@property int yOffset;

@end

@implementation DetailViewController

@synthesize titleLable;
@synthesize yOffset;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Open"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(openNews)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self roundMyView:titleLable borderRadius:5.0f borderWidth:1.0f color:[UIColor orangeColor]];
    
    yOffset = _imageView.frame.size.height + titleLable.frame.size.height + 10;
    NSLog(@"ImageView Size - %f", _imageView.frame.size.height);
    NSLog(@"Label Size - %f", titleLable.frame.size.height);
    NSLog(@"START OFFSET - %d", yOffset);
    
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setDetails:(NewsElement*)reciveDetail;
{
    _newsElementDetail = reciveDetail;
    
  
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
    
    
    NSLog(@"%@",_newsElementDetail.imageUrl);
    
    self.navigationItem.title = _newsElementDetail.dateNewsText;
    self.titleLable.text = _newsElementDetail.titleText;
    

    NSArray *articleNodes = [RDHelper requestData:_newsElementDetail.articleUrl xPathQueryStr:@"//div[@class='topic-content text']"];
    
    NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc] initWithString:@""];
   
    for (TFHppleElement *element in articleNodes)
    {
        for (TFHppleElement *child in element.children) {
            
            if ([child.tagName isEqual:@"img"])
            {
                // then setting imageView
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, yOffset, _scrollView.frame.size.width-10, _scrollView.frame.size.width*9/16)];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [imageView setImageWithURL:[NSURL URLWithString:[child objectForKey:@"src"]]];
                NSLog(@"Child - %@, image url - %@",[child content],[child objectForKey:@"src"]);
                
                [_scrollView addSubview:imageView];
                yOffset += imageView.frame.size.height+10;
                NSLog(@"OFFSET after add view - %d", yOffset);
            }
            // else appending text variable
            else if([child.tagName characterAtIndex:0] == 'h')
            {
                [resultStr appendAttributedString:[[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@"\n%@\n", child.content]
                                                                                  attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:15.0f]}]];
                
               
            }
            else
            {
                NSAttributedString *tempString = [[NSAttributedString alloc] initWithString:@""];
                NSString *tempTrimString = [[child content]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ];
                
                tempString = [[NSAttributedString alloc] initWithString:tempTrimString];
                
               
                [resultStr appendAttributedString:tempString];
            }

        }
       
        
        self.textView.attributedText = resultStr ;
        NSLog(@"ContentView size - %f",_contentView.frame.size.height);
        NSLog(@"ScrollView size - %f",_scrollView.frame.size.height);
        NSLog(@"TextView size - %f",_textView.frame.size.height);
      
    }
    
    
    
    if(_newsElementDetail.imageUrl != nil)
    {
        NSArray* image = [_newsElementDetail imagesFromContent:_newsElementDetail.imageUrl];NSString *imageStringURL = [image objectAtIndex:0];
        NSURL* imageURL = [NSURL URLWithString: imageStringURL];
        [self.imageView setImageWithURL: imageURL];
    }
    else
    {
        self.imageView.image = [UIImage imageNamed:@"glnews.png"];
    }

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
