//
//  HDBaseCell.m
//  HotDaily
//
//  Created by weizhou on 3/14/15.
//  Copyright (c) 2015 fengweizhou. All rights reserved.
//

#import "HDBaseCell.h"
#import "MustOverride.h"

@implementation HDBaseCell

- (void)awakeFromNib {
    // Initialization code
}

+ (UINib *)cellNib {
    return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

- (void)configureWithViewModel:(HDBaseViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath {
    SUBCLASS_MUST_OVERRIDE;
}
@end
