//
//  ViewController.m
//  CignaPOC
//
//  Created by swetha on 7/11/16.
//  Copyright © 2016 swetha. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "Episode.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize seasonsTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Game of Thrones";
    
    [self getEpisodeList];
    dataDictionary = [[NSMutableDictionary alloc] init];
    self.seasonsTableView.delegate = self;
    self.seasonsTableView.dataSource = self;
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(deleteRow)];
    [editButton setTintColor:[UIColor whiteColor]];
 
    self.navigationItem.rightBarButtonItem =editButton;
  }

-(void)deleteRow{
    [self.seasonsTableView setEditing:!self.seasonsTableView.editing animated:YES];
    if (self.seasonsTableView.editing)
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    else
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.episodeArray removeObjectAtIndex:indexPath.row];
        [self.seasonsTableView reloadData];
    }   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.episodeArray.count;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   
    Episode *episode = [self.episodeArray objectAtIndex:indexPath.row];
    cell.textLabel.text = episode.title;
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.seasonsTableView){
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 370, 30)];
        [headerView setBackgroundColor:[UIColor lightGrayColor]];
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 100, 20)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:[UIFont systemFontOfSize:18.0]];
        [nameLabel setTextColor:[UIColor blueColor]];
        [nameLabel setText: [NSString stringWithFormat:@"Season %@",self.seasonNumber]];
        [headerView addSubview:nameLabel];
        return headerView;
        
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detailvc = (DetailViewController *) [sb instantiateViewControllerWithIdentifier:@"DetailVC"];
    detailvc.episode = [self.episodeArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailvc animated:YES];
  }


- (IBAction)refreshButtonClicked:(id)sender{
    [self getEpisodeList];
    
}

-(void)getEpisodeList
{
   
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:
                                                          @"http://www.omdbapi.com/?t=Game%20of%20Thrones&Season=1"]];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
           
        } else {
        
            [self parseData:data];
        }
    }];

}


-(void)getEpisodeListOnSelection:(NSString *)rowNumber{
    NSURLRequest *request ;
    if ([rowNumber isEqualToString:@"2"]) {
    request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.omdbapi.com/?t=Game%20of%20Thrones&Season=2"]];
    }
    else if ([rowNumber isEqualToString:@"3"])
    {
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.omdbapi.com/?t=Game%20of%20Thrones&Season=3"]];
    }
    else if ([rowNumber isEqualToString:@"4"]){
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.omdbapi.com/?t=Game%20of%20Thrones&Season=4"]];
    }

    else if ([rowNumber isEqualToString:@"5"]){
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.omdbapi.com/?t=Game%20of%20Thrones&Season=5"]];
   

    }

    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            
        } else {
            
            [self parseData:data];
        }
    }];
}

-(void)parseData:(NSData *)data
{
    NSError *error=nil;
    dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                               options:kNilOptions
                                                                 error:&error];
    self.seasonNumber = [dataDictionary objectForKey:@"Season"];
    NSArray *episodeArr = [dataDictionary objectForKey:@"Episodes"];
   self.episodeArray = [[NSMutableArray alloc] init];
    NSLog( @"--->%@",episodeArr);
    for (int i = 0; i < episodeArr.count; i++) {
        NSDictionary *titleDict  = [episodeArr objectAtIndex:i];
        
        Episode *episode = [[Episode alloc] init];
        episode.title = [titleDict objectForKey:@"Title"];
        episode.episodeNo = [titleDict objectForKey:@"Episode"];
        episode.imdbID = [titleDict objectForKey:@"imdbID"];
        episode.imdbRating = [titleDict objectForKey:@"imdbRating"];
        episode.releaseDate = [titleDict objectForKey:@"Released"];

        [self.episodeArray addObject:episode];
       
    }
    
    [self.seasonsTableView reloadData];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
   }

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    }

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}
- (IBAction)actionButtonClicked:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Season" delegate:self cancelButtonTitle:@"Cancel Button" destructiveButtonTitle:nil otherButtonTitles:@"Season1", @"Season2", @"Season3", @"Season4", @"Season5", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault; [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            [self getEpisodeList];
           
            break;
        case 1:
            self.episodeArray = nil;
            NSLog(@"-->%@",self.episodeArray);
            [self getEpisodeListOnSelection:[NSString stringWithFormat:@"%d",2]];
            break;
        case 2:
            self.episodeArray = nil;
            NSLog(@"-->%@",self.episodeArray);
            [self getEpisodeListOnSelection:[NSString stringWithFormat:@"%d",3]];
            break;
        case 3:
            self.episodeArray = nil;
            NSLog(@"-->%@",self.episodeArray);
            [self getEpisodeListOnSelection:[NSString stringWithFormat:@"%d",4]];
            break;
        case 4:
            self.episodeArray = nil;
            NSLog(@"-->%@",self.episodeArray);
            [self getEpisodeListOnSelection:[NSString stringWithFormat:@"%d",5]];
            break;
                  break;
    } 
}
@end
