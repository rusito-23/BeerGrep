//
//  DataProvider.h
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/25/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BeerModel.h"

@protocol BeerProvider <NSObject>
@required
- (void) fetchBeersWithCompletion:(void (^)(NSArray *, NSError *))completion;
- (void) fetchBeerImageFor:(BeerModel *)beer withCompletion:(void (^)(UIImage *, NSError *))completion;
@end
