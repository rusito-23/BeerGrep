//
//  NSString+Localizable.m
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/26/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import "NSString+Localizable.h"


@implementation NSString (Localizable)

- (NSString *) localized {
  return NSLocalizedString(self, @"");
}

@end
