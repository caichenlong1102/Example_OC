//
//  TableViewController.m
//  Example_OC
//
//  Created by light on 2018/5/10.
//  Copyright © 2018年 light. All rights reserved.
//

#import "TableViewController.h"

#import "TextViewTableViewCell.h"

@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic) NSInteger selectedIndex;

@end

@implementation TableViewController

#pragma mark ------LifeCircle------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TbaleViewTest";
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------UITableViewDataSource------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TextViewTableViewCell *cell = (TextViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TextViewTableViewCellID" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark ------UITableViewDelegate------
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == (long)self.selectedIndex){
//        return  65.0;
//    }
//    return  44.0;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    self.selectedIndex = indexPath.row;
    [tableView beginUpdates];
    [tableView endUpdates];
}

#pragma mark ------PrivateAndSetUI

- (void)setUI{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 400)];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[TextViewTableViewCell class] forCellReuseIdentifier:@"TextViewTableViewCellID"];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.separatorColor = [UIColor colorWithHex:0xE5E5E5];
    _tableView.backgroundColor = [UIColor colorWithHex:0xF3F3F3];
    _tableView.estimatedRowHeight = 44;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
