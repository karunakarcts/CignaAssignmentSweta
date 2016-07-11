//
//  DetailViewController.m
//  cigna
//
//  Created by Ganesh on 11/07/16.
//  Copyright (c) 2016 iOS. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"hi");
    self.navigationItem.title = self.episode.title;
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    [self getDetails];
   }
-(void)getDetails{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.omdbapi.com/?i=%@&plot=short&r=json", self.episode.imdbID]]];
                                                          
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            
        } else {
            
            [self parseDetailsData:data];
        }
    }];
    
}

-(void)parseDetailsData:(NSData *)data
{
    NSError *error=nil;
    NSDictionary *dataDict= [NSJSONSerialization JSONObjectWithData:data
                                                     options:kNilOptions
                                                       error:&error];
    NSLog(@"--->%@",dataDict);
    Details *details = [[Details alloc] init];
    self.yearLabel.text =[dataDict objectForKey:@"Year"];
    self.ratedLabel.text = [dataDict objectForKey:@"Rated"];
    self.releasedLabel.text  = [dataDict objectForKey:@"Released"];
    self.seasonLabel.text = [dataDict objectForKey:@"Season"];
    self.episodeLabel.text = [dataDict objectForKey:@"Episode"];
   self.runTimeLabel.text = [dataDict objectForKey:@"Runtime"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
