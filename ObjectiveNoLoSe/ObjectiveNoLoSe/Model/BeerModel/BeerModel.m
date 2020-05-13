//
//  BeerModel.m
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/25/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import "BeerModel.h"

@implementation BeerModel

- (instancetype) initWithName:(NSString *)name
               andDescription:(NSString *)description
                       andIBU:(NSString *)IBU
                   andBrewery:(NSString *)brewery
                     andColor:(NSString *)color
                 andImageName:(NSString *)imageName {
  self = [super init];
  if (self) {
    self.name = name;
    self.tasteDescription = description;
    self.IBU = [[NSNumberFormatter new] numberFromString:IBU];
    self.brewery = brewery;
    self.color = [self colorFromString:color];
    self.imageName = imageName;
  }
  return self;
}

- (NSString *) colorName {
  return [BeerModel colorNameFor:self.color];
}

- (BeerColor) colorFromString:(NSString *) colorName {
  if ([colorName isEqualToString:@"BLONDE"]) {
    return BLONDE;
  } else if ([colorName isEqualToString:@"RED"]) {
    return RED;
  } else if ([colorName isEqualToString:@"DARK"]) {
    return DARK;
  } else {
    return INVALID;
  }
}

+ (NSString *) colorNameFor:(BeerColor) color {
  switch (color) {
    case INVALID: return @"Invalid";
    case RED: return @"Red";
    case BLONDE: return @"Blonde";
    case DARK: return @"Dark";
  }
}

- (NSString *) description {
  return [NSString stringWithFormat:@"Name: %@, %@, %@",
          self.name, self.IBU, [BeerModel colorNameFor:self.color]];
}

@end
