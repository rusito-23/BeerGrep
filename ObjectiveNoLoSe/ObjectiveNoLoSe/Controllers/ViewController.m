//
//  ViewController.m
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/25/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import "ViewController.h"
#import "BeerModel.h"
#import "BeerProvider.h"
#import "Injector.h"
#import "BeerTableViewCell.h"
#import "NSString+Localizable.h"
#import "UITableView+Message.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *beers;
@end


@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  NSLog(@"ViewController: viewDidLoad");

  [self setUpTitle];
  [self setUpTableView];
  [self fetchBeers];
}

#pragma mark - title

- (void) setUpTitle {
  [self.titleLabel setText:@"APP_TITLE".localized];
  [self.titleLabel setFont:[UIFont boldSystemFontOfSize:32.]];
}

#pragma mark - fetch beers

- (void) fetchBeers {
  [self.tableView showMessage:@"LOADING".localized];

  __weak ViewController *weakSelf = self;
  [self.beerProvider fetchBeersWithCompletion:^(NSArray *beers, NSError *error){
    dispatch_async(dispatch_get_main_queue(), ^{
      ViewController *self = weakSelf;
      if (error) {
        NSLog(@"ViewController: error fetching beers: %@", error.localizedDescription);
        return;
      }

      self.beers = beers;
      [self.tableView reloadData];
      [self.tableView clearMessage];
      [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    });
  }];
}

#pragma mark - table view setup

- (void) setUpTableView {
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  [self.tableView registerNib:[UINib nibWithNibName:BeerTableViewCell.nibName bundle:nil]
       forCellReuseIdentifier:BeerTableViewCell.identifier];
}

#pragma mark - table view delegate

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  BeerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BeerTableViewCell.identifier];
  NSInteger idx = [indexPath row];

  BeerModel *beer = self.beers[idx];
  [cell setUpWithBeer:beer];

  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return BeerTableViewCell.height;
}

#pragma mark - table view datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.beers.count;
}

#pragma mark - beer provider

- (id<BeerProvider>) beerProvider {
  return [Injector getBeerProvider];
}

@end
