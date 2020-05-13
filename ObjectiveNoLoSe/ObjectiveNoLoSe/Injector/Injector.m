//
//  Injector.m
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/26/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import "Injector.h"
#import "BeerProviderMock.h"

@implementation Injector

+ (id<BeerProvider>) getBeerProvider {
  return [BeerProviderMock new];
}

@end
