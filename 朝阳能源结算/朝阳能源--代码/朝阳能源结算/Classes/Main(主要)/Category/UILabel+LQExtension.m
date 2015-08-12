//
//  UILabel+LQExtension.m
//  朝阳能源结算
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 dieshang. All rights reserved.
//

#import "UILabel+LQExtension.h"

@implementation UILabel (LQExtension)

/**
 *  设置Label行间距
 */
-(void)setLabelLineSpacing:(float)lineSpacing
{
    //富文本设置文字行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = lineSpacing;
    
    NSDictionary *attributes = @{ NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paragraphStyle};
    self.attributedText = [[NSAttributedString alloc]initWithString:self.text attributes:attributes];
}

- (void)setText:(NSString *)text lineSpacing:(float)lineSpacing
{
    self.text = text;
    [self setLabelLineSpacing:lineSpacing];
}

@end
