//
//  BeerTableViewCell.h
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/26/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeerModel.h"


@interface BeerTableViewCell : UITableViewCell

- (void) setUpWithBeer:(BeerModel *)beer;

+ (NSString *) identifier;
+ (NSString *) nibName;
+ (CGFloat) height;

@end
