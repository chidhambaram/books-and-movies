//
//  IDTBooksAndMoviesDataSource.h
//  MasterDetail
//
//  Created by Josh Brown on 3/18/14.
//  Copyright (c) 2014 iOS Dev Training. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDTBooksAndMoviesDataSource : NSObject <UITableViewDataSource>

@property NSArray *entries;

- (void)loadBooksWithSuccess:(void (^)())success failure:(void(^)())failure;
- (void)loadMoviesWithSuccess:(void (^)())success failure:(void(^)())failure;

@end
