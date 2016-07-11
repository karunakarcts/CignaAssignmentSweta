//
//  ViewController.h
//  cigna
//
//  Created by Swetha on 11/07/16.
//  Copyright (c) 2016 iOS. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDelegate,UIActionSheetDelegate>
{
     NSMutableDictionary* dataDictionary;
}
@property (nonatomic,retain)IBOutlet UITableView *seasonsTableView;
@property (nonatomic,strong) NSMutableArray *episodeArray;
@property (nonatomic,strong) NSMutableArray *titlesArray;
@property (nonatomic ,strong)NSString *seasonNumber;


- (IBAction)refreshButtonClicked:(id)sender;
- (IBAction)actionButtonClicked:(id)sender;
-(void)getEpisodeList;
@end


