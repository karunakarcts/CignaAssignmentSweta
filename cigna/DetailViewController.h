//
//  DetailViewController.h
//  cigna
//
//  Created by Ganesh on 11/07/16.
//  Copyright (c) 2016 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Episode.h"
#import "Details.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) Episode *episode;
@property (nonatomic, strong) IBOutlet UILabel *yearLabel;
@property (nonatomic, strong) IBOutlet UILabel *ratedLabel;
@property (nonatomic, strong) IBOutlet UILabel *releasedLabel;
@property (nonatomic, strong) IBOutlet UILabel *seasonLabel;
@property (nonatomic, strong) IBOutlet UILabel *episodeLabel;
@property (nonatomic, strong) IBOutlet UILabel *runTimeLabel;
-(void)getDetails;
@end
