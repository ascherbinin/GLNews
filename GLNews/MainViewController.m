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

@interface MainViewController ()


@end

@implementation MainViewController

@synthesize sampleTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NewsElement *news1 = [[NewsElement alloc] init];
    news1.titleText = @"Движемся к посадочному экватору!";
    news1.descriptionText = @"Два города уже одарены добром: 25 апреля мы посадили вместе с новокузнечанами 30 тысяч кедров, а 2 мая жители Белова смогли поучаствовать в посадке 10 тысяч сосен. Впереди столица Кузбасса и новые рекорды :)";
    news1.imageName = @"news1.jpg";
    
    NewsElement *news2 = [[NewsElement alloc] init];
    news2.titleText = @"Good Line Open 2015 Spring: регистрация и команда";
    news2.descriptionText = @"Подготовка к весеннему киберфесту идёт вовсю: регистрируем игроков, собираем команду, планируем грандиозный финал 17 мая в ГЦС «Кузбасс». К нам снова приедут ребята из Wargaming, мы снова устроим мини-турниры и кучу развлекательных зон. Будут и новые суперфишки";
    news2.imageName = @"news2.jpg";
    
    NewsElement *news3 = [[NewsElement alloc] init];
    news3.titleText = @"Центр притяжения небезразличных айтишников Кузбасса";
    news3.descriptionText = @"Вчера вечером к нам в ЭТО_ в гости приезжали ребята из Юрги (интернет-группа «ЮГС»). Немного предыстории: несколько недель назад один из руководителей «ЮГС», Кирилл, сам вышел на нас с предложением проводить для айтишников совместные мероприятия по чтению докладов и обсуждению интересных бизнес-книжек. Тогда мы пригласили ребят в гости, познакомиться и рассказать о себе и своём опыте.";
    news3.imageName = @"news3.jpg";
    
    _items = [[NSArray alloc] initWithObjects:news1,news2,news3, nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // Return the number of rows in the section.
    // Usually the number of items in your array (the one that holds your list)
    return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Where we configure the cell in each row
    
    static NSString *CellIdentifier = @"NewsCell";
    MainTableCell *cell = (MainTableCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    if (cell == nil) {
        NSArray* topLevelObjects = [[NSBundle mainBundle]loadNibNamed:@"MainTableCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if([currentObject isKindOfClass:[UITableViewCell class]])
            {
                cell = (MainTableCell*) currentObject;
                break;
            }
            
        }
        
    }
    
    NewsElement *news = [_items objectAtIndex:indexPath.row];
    cell.imageNews.image = [UIImage imageNamed:news.imageName];
    cell.titleNews.text = news.titleText;
    cell.descriptionNews.text = news.descriptionText;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
   
    return cell;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    // If you want to push another view upon tapping one of the cells on your table.
    
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
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
