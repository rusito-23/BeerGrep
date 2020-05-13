//
//  BeerModel.h
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/25/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BeerColor) {
  INVALID,
  RED,
  BLONDE,
  DARK
};

@interface BeerModel : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *tasteDescription;
@property (nonatomic) NSNumber *IBU;
@property (nonatomic) NSString *brewery;
@property (nonatomic) BeerColor color;
@property (nonatomic) NSString *imageName;

- (instancetype) initWithName:(NSString *) name
               andDescription:(NSString *) description
                       andIBU:(NSString *) IBU
                   andBrewery:(NSString *) brewery
                     andColor:(NSString *) color
                 andImageName:(NSString *) imageName;

- (NSString *) colorName;

@end
