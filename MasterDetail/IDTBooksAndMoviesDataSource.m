//
//  IDTBooksAndMoviesDataSource.m
//  MasterDetail
//
//  Created by Josh Brown on 3/18/14.
//  Copyright (c) 2014 iOS Dev Training. All rights reserved.
//

#import "IDTBooksAndMoviesDataSource.h"

#define kMoviesURL  @"https://itunes.apple.com/us/rss/topmovies/limit=15/json"
#define kBooksURL @"https://itunes.apple.com/us/rss/toppaidebooks/limit=15/json"

@implementation IDTBooksAndMoviesDataSource

#pragma mark - Public

- (void)loadBooksWithSuccess:(void (^)())success failure:(void (^)())failure
{
    [self loadFromURL:kBooksURL success:success failure:failure];
}

- (void)loadMoviesWithSuccess:(void (^)())success failure:(void (^)())failure
{
    [self loadFromURL:kMoviesURL success:success failure:failure];
}

#pragma mark - Private

- (void)loadFromURL:(NSString *)urlString success:(void (^)())success failure:(void (^)())failure
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask =
    [session dataTaskWithURL:url
           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
         if (error)
         {
             failure();
             return;
         }
         
         NSError *jsonError = nil;
         id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
         
         if (jsonError)
         {
             failure();
             return;
         }
         
         NSDictionary *feed = [json objectForKey:@"feed"];
         self.entries = [feed objectForKey:@"entry"];
         
         success();
     }];
    
    [dataTask resume];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    
    NSDictionary *entry = [self.entries objectAtIndex:indexPath.row];
    cell.textLabel.text = [entry valueForKeyPath:@"im:name.label"];
    
    return cell;
}

@end
