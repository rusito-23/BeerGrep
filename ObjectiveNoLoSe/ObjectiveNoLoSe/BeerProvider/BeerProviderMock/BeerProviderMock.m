//
//  DataProviderMock.m
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/25/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import "BeerProviderMock.h"
#import "NSString+Localizable.h"
#import "BeerModel.h"


@implementation BeerProviderMock

#pragma mark - BeerProvider protocol implementation

- (void) fetchBeersWithCompletion:(void (^)(NSArray *, NSError *))completion {
  NSLog(@"fetching all beers");
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSArray *beers = [self getBeers];
    completion(beers, nil);
  });
}

- (void) fetchBeerImageFor:(BeerModel *)beer withCompletion:(void (^)(UIImage *, NSError *))completion {
    NSLog(@"fetching image for beer: %@", beer.name);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      if (!beer.imageName) {
        completion(nil, [NSError errorWithDomain:@"beer.image" code:404 userInfo:@{}]);
        return;
      }

      UIImage *beerImage = [UIImage imageNamed:beer.imageName];
      completion(beerImage, nil);
    });
}

#pragma mark - mock stuff

- (NSArray *) getBeers {
  BeerModel *caribbean = [[BeerModel alloc] initWithName: @"CARIBBEAN_NAME".localized
                                          andDescription: @"CARIBBEAN_DESC".localized
                                                  andIBU: @"CARIBBEAN_IBU".localized
                                              andBrewery: @"CARIBBEAN_BREW".localized
                                                andColor: @"CARIBBEAN_COLOR".localized
                                            andImageName: @"CARIBBEAN_PIC".localized];

  BeerModel *ipa = [[BeerModel alloc] initWithName: @"IPA_NAME".localized
                                    andDescription: @"IPA_DESC".localized
                                            andIBU: @"IPA_IBU".localized
                                        andBrewery: @"IPA_BREW".localized
                                          andColor: @"IPA_COLOR".localized
                                      andImageName: @"IPA_PIC".localized];

  BeerModel *porter = [[BeerModel alloc] initWithName: @"PORTER_NAME".localized
                                       andDescription: @"PORTER_DESC".localized
                                               andIBU: @"PORTER_IBU".localized
                                           andBrewery: @"PORTER_BREW".localized
                                             andColor: @"PORTER_COLOR".localized
                                         andImageName: @"PORTER_PIC".localized];

  return @[caribbean, ipa, porter];
}

@end
