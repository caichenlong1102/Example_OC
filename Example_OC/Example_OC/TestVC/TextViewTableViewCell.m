//
//  TextViewTableViewCell.m
//  Example_OC
//
//  Created by light on 2018/5/10.
//  Copyright © 2018年 light. All rights reserved.
//

#import "TextViewTableViewCell.h"
#import <Masonry/Masonry.h>

NSString * const TextViewTableViewCellID = @"TextViewTableViewCellID";

@interface TextViewTableViewCell() <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end

@implementation TextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, 280, 20)];
    self.textView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.textView];
    self.textView.delegate = self;
    
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(20, 0, 280, 20)];
        _textView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_textView];
        _textView.delegate = self;
        
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.greaterThanOrEqualTo(@25);
        }];
        
        [self changeSizeWithTextView:_textView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)textViewDidChange:(UITextView *)textView {
    [self changeSizeWithTextView:textView];
}

- (void)changeSizeWithTextView:(UITextView *)textView {
    //获得textView的初始尺寸
    CGFloat width = CGRectGetWidth(textView.frame);
//    CGFloat height = CGRectGetHeight(textView.frame);
    CGSize newSize = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmax(width, newSize.width), newSize.height);
    //    newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
    textView.frame= newFrame;
//    [textView setContentOffset:CGPointZero animated:NO];
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.greaterThanOrEqualTo(@(newSize.height));
    }];
    
//    //TableViewcCell 自适应高度
//    if ([self.superview isKindOfClass:[UITableView class]]) {
//        UITableView *tableView = (UITableView *)self.superview;
//        [tableView beginUpdates];
//        [tableView endUpdates];
//
//        //自适应后，修改_UITextContainerView 滚回顶部问题
//        [textView setContentOffset:CGPointZero animated:YES];
//    }
//    if ([self.superview.superview isKindOfClass:[UITableView class]]){
//        UITableView *tableView = (UITableView *)self.superview.superview;
//        [tableView beginUpdates];
//        [tableView endUpdates];
//
//        //自适应后，修改_UITextContainerView 滚回顶部问题
//        [textView setContentOffset:CGPointZero animated:YES];
//    }
    
    UIView *view = self;
    do {
        view = view.superview;
    }while (![view isKindOfClass:[UITableView class]] && view);
    
    if ([view isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)view;
        [tableView beginUpdates];
        [tableView endUpdates];

        //自适应后，修改_UITextContainerView 滚回顶部问题
        [textView setContentOffset:CGPointZero animated:YES];
    }
    
}

@end
