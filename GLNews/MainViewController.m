//
//  MainViewController.m
//  GLNews
//
//  Created by Admin on 06.05.15.
//  Copyright (c) 2015 GoodLine. All rights reserved.
//

#import "MainViewController.h"
#import "NewsElement.h"
#import "MainTableCell.h"
#import "TFHpple.h"
#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MainViewController ()
{
NSMutableArray *objects;
}
@end

@implementation MainViewController

@synthesize sampleTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Новости";
    [self loadNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loadNews
{
    NSURL *newsUrl = [NSURL URLWithString:@"http://live.goodline.info"];
    NSData *newsHtmlData = [NSData dataWithContentsOfURL:newsUrl];
    
    TFHpple *newsParser = [TFHpple hppleWithHTMLData:newsHtmlData];

    NSString *newsXpathQueryString = @"//article";
  
    NSArray *newsNodes = [newsParser searchWithXPathQuery:newsXpathQueryString];
    
    if ([newsNodes count] == 0)
        NSLog(@"Нету node");
    else
    {
        NSLog(@"Найдено %d корневых элементов", [newsNodes count]);
   
        
        
        NSMutableArray *newNews = [[NSMutableArray alloc] initWithCapacity:0];
        for (TFHppleElement *element in newsNodes){
            
            
            
            
            NewsElement *ne = [[NewsElement alloc]init];
            [newNews addObject:ne];
            
            TFHppleElement *subelement = [element firstChildWithClassName:@"wraps out-topic"];
            TFHppleElement *descriptionElement = [subelement firstChildWithClassName:@"topic-content text"];
            TFHppleElement *titleElement =[subelement firstChildWithClassName:@"topic-header"] ;
            TFHppleElement *imageElement = [element firstChildWithClassName:@"preview"];
            
          //  (NSLog(@"Description element - %@",[[titleElement firstChildWithTagName:@"time"]content])) ;
          
            ne.titleText =[[[titleElement firstChildWithClassName:@"topic-title word-wrap"] content]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            ne.descriptionText =[[descriptionElement content] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString *dateString = [[[titleElement firstChildWithTagName:@"time"]content]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSScanner *scanner = [[NSScanner alloc] initWithString:dateString];
            [scanner scanUpToString:@"," intoString:nil];
            
            ne.dateNewsText = [dateString substringWithRange:NSMakeRange(0, scanner.scanLocation)];
            
            TFHppleElement *imageNode = [[imageElement firstChildWithTagName:@"a"] firstChildWithTagName:@"img"];
            ne.imageUrl = [imageNode objectForKey:@"src"];
            
            NSString *urlString = [[imageElement firstChildWithTagName:@"a"] objectForKey:@"href"];
            ne.articleUrl =[NSURL URLWithString:urlString];
            
            
            
    }
    objects = newNews;
    
    [self.tableView reloadData];
    
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
    return [objects count];
}

-(void) tableView:(UITableView*)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    static NSString *CellIdentifier = @"NewsCell";
    MainTableCell *cell = (MainTableCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MainTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NewsElement *news = [objects objectAtIndex:indexPath.row];
    NSArray* images = [news imagesFromContent:news.imageUrl];
    NSString *imageStringURL = [images objectAtIndex:0];
    NSURL* imageURL = [NSURL URLWithString: imageStringURL];
    [cell.imageNews setImageWithURL: imageURL];
    cell.titleNews.text = news.titleText;
    cell.descriptionNews.text = news.descriptionText;
    cell.dateNews.text = news.dateNewsText;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
   
    NSLog(@"%d", indexPath.row);
   
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    // If you want to push another view upon tapping one of the cells on your table.
    
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    if(indexPath)
    {
        NewsElement *news = [objects objectAtIndex:indexPath.row];
        [detailViewController setDetails:news];
    }
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
