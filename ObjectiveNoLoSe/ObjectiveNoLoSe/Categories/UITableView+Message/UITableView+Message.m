//
//  UITableView+Message.m
//  ObjectiveNoLoSe
//
//  Created by Igor Andruskiewitsch on 4/26/20.
//  Copyright © 2020 rusito23. All rights reserved.
//

#import "UITableView+Message.h"


@implementation UITableView (Message)

- (void) showMessage:(NSString *)message {
  UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
  [messageLabel setText:message];
  [messageLabel setTextColor:UIColor.blackColor];
  [messageLabel setFont:[UIFont systemFontOfSize:23]];
  [messageLabel setNumberOfLines:0];
  [messageLabel setTextAlignment:NSTextAlignmentCenter];
  [messageLabel sizeToFit];

  [self setBackgroundView:messageLabel];
  [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void) clearMessage {
  self.backgroundView = nil;
}

@end
