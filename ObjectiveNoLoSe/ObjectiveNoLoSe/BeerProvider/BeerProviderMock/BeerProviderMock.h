//
//  DataProviderMock.h
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/25/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeerProvider.h"


@interface BeerProviderMock : NSObject <BeerProvider>
- (void) fetchBeersWithCompletion:(void (^)(NSArray *, NSError *))completion;
- (void) fetchBeerImageFor:(BeerModel *)beer withCompletion:(void (^)(UIImage *, NSError *))completion;
@end
