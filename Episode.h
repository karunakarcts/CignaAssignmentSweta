//
//  Episode.h
//  cigna
//
//  Created by Ganesh on 11/07/16.
//  Copyright (c) 2016 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Episode : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *episodeNo;
@property (strong, nonatomic) NSString *imdbRating;
@property (strong, nonatomic) NSString *imdbID;
@property (strong, nonatomic) NSString *releaseDate;

@end
