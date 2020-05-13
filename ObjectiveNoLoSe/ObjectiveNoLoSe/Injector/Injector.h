//
//  Injector.h
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/26/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeerProvider.h"

@interface Injector : NSObject

+ (id<BeerProvider>) getBeerProvider;

@end
