//
//  IDTViewController.m
//  MasterDetail
//
//  Created by Josh Brown on 12/17/13.
//  Copyright (c) 2013 iOS Dev Training. All rights reserved.
//

#import "IDTViewController.h"
#import "IDTDetailViewController.h"
#import "IDTBooksAndMoviesDataSource.h"

#define kMoviesSegment 0
#define kBooksSegment 1

@interface IDTViewController ()

@property IDTBooksAndMoviesDataSource *dataSource;

@end

@implementation IDTViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.dataSource = [[IDTBooksAndMoviesDataSource alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self.dataSource;
    [self loadMovies];
}

- (void)loadMovies
{
    [self.dataSource
     loadMoviesWithSuccess:^{
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
     }
     failure:^{
         // TODO: handle failure
     }];
}

- (void)loadBooks
{
    [self.dataSource
     loadBooksWithSuccess:^{
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.tableView reloadData];
         });
     }
     failure:^{
         // TODO: handle failure
     }];
}

- (IBAction)didChangeSegment:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;

    if (control.selectedSegmentIndex == kMoviesSegment)
    {
        [self loadMovies];
    }
    else if (control.selectedSegmentIndex == kBooksSegment)
    {
        [self loadBooks];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    IDTDetailViewController *vc = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    vc.entry = [self.dataSource.entries objectAtIndex:indexPath.row];
}

@end
