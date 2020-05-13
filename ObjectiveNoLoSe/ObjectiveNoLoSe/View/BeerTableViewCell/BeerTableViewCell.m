//
//  BeerTableViewCell.m
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/26/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import "BeerTableViewCell.h"
#import "NSString+Localizable.h"
#import "BeerProvider.h"
#import "Injector.h"

@interface BeerTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;
@property (weak, nonatomic) IBOutlet UILabel *IBULabel;
@property (weak, nonatomic) IBOutlet UILabel *breweryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *beerImage;
@end

@implementation BeerTableViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  [self.nameLabel setFont:[UIFont boldSystemFontOfSize:23.]];
  [self.kindLabel setFont:[UIFont boldSystemFontOfSize:20.]];
  [self.beerImage setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
}

#pragma mark - set up

- (void) setUpWithBeer:(BeerModel *)beer {
  // setup the labels
  [self.nameLabel setText:beer.name];
  [self.kindLabel setText:beer.colorName];
  [self.kindLabel setTextColor:[self colorForKind:beer.color]];
  [self.IBULabel setAttributedText:[self createIBUAttributedStringWithValue:beer.IBU.stringValue]];
  [self.breweryLabel setText:beer.brewery];

  // clear last image a search a new one
  [self.beerImage setImage:nil];
  __weak typeof(self) weakSelf = self;
  [self.beerProvider fetchBeerImageFor:beer withCompletion:^(UIImage *image, NSError *error){
    dispatch_async(dispatch_get_main_queue(), ^{
      __strong typeof(weakSelf) self = weakSelf;
      if (error || !image) {
        NSLog(@"Error retrieving beer image");
        return;
      }
      [self.beerImage setImage:image];
      [self.beerImage setNeedsDisplay];
    });
  }];
}

- (UIColor *) colorForKind:(BeerColor) color {
  switch (color) {
    case BLONDE: return UIColor.systemYellowColor;
    case RED: return UIColor.redColor;
    case DARK: return UIColor.brownColor;
    case INVALID: return UIColor.blackColor;
  }
}

- (NSAttributedString *) createIBUAttributedStringWithValue:(NSString*)value {
  NSString *string = [NSString stringWithFormat:@"%@: %@", @"IBU_LABEL".localized, value];
  NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];

  [attrString beginEditing];
  [attrString addAttribute:NSFontAttributeName
                     value:[UIFont systemFontOfSize:20.]
                     range:[string rangeOfString:value]];
  [attrString addAttribute:NSFontAttributeName
                     value:[UIFont boldSystemFontOfSize:20.]
                     range:[string rangeOfString:@"IBU_LABEL".localized]];
  [attrString endEditing];

  return attrString;
}

#pragma mark - global helpers

+ (NSString *) identifier {
  return @"BEER_CELL";
}

+ (NSString *) nibName {
  return @"BeerTableViewCell";
}

+ (CGFloat) height {
  return 200.f;
}

#pragma mark - beer provider

- (id<BeerProvider>) beerProvider {
  return [Injector getBeerProvider];
}

@end
