//
//  MoveCollectionViewController.m
//  Example_OC
//
//  Created by light on 2018/5/24.
//  Copyright © 2018年 light. All rights reserved.
//

#import "MoveCollectionViewController.h"
#import "MoveCollectionViewCell.h"
@interface MoveCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *data;

@property (nonatomic, strong) UICollectionViewCell *thisCell;//当前移动cell 不需要挤走下面cell时使用

//iOS9之前版本使用
@property (nonatomic,strong)NSMutableArray *cellAttributesArray;
@property (nonatomic,assign)BOOL isChange;

@end

@implementation MoveCollectionViewController

#pragma mark ------CircleLife------

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    for (int i = 1; i <= 10; i++) {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [self.data addObject:img];
    }
    [self.collectionView reloadData];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------UICollectionViewDataSource------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MoveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MoveCollectionViewCellID forIndexPath:indexPath];
    cell.img = _data[indexPath.row];
//    if (!@available(iOS 9.0, *)){
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressBeforeiOS9Action:)];
        [cell addGestureRecognizer:longPressGesture];
//    }
    return cell;
    
}

//
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return NO;
    }
    return YES;
}

//当移动结束的时候会调用这个方法。
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath {
    /**
     *sourceIndexPath 原始数据 indexpath
     * destinationIndexPath 移动到目标数据的 indexPath
     */
    
    UIImage *img = _data[sourceIndexPath.row];
    [_data removeObjectAtIndex:sourceIndexPath.row];
    [_data insertObject:img atIndex:destinationIndexPath.row];
    
}

#pragma mark ------iOS < 9.0长按移动------

- (void)longPressBeforeiOS9Action:(UILongPressGestureRecognizer *)longPress {
    MoveCollectionViewCell *cell = (MoveCollectionViewCell *)longPress.view;
    NSIndexPath *cellIndexpath = [_collectionView indexPathForCell:cell];
    
    
    [_collectionView bringSubviewToFront:cell];
    
    _isChange = NO;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            [self.cellAttributesArray removeAllObjects];
            for (int i = 0; i < self.data.count; i++) {
                [self.cellAttributesArray addObject:[_collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
            }
            cell.transform = CGAffineTransformMakeScale(1.5, 1.5);
        }
            
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            cell.center = [longPress locationInView:_collectionView];
            for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
                if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexpath != attributes.indexPath) {
                    _isChange = YES;
                    NSString *imgStr = self.data[cellIndexpath.row];
                    [self.data removeObjectAtIndex:cellIndexpath.row];
                    [self.data insertObject:imgStr atIndex:attributes.indexPath.row];
                    
                    cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
                    [self.collectionView moveItemAtIndexPath:cellIndexpath toIndexPath:attributes.indexPath];
                    cell.transform = CGAffineTransformMakeScale(1.5, 1.5);
                    cell.center = [longPress locationInView:_collectionView];
                    [cell.layer removeAllAnimations];
                }
            }
            
        }
            
            break;
            
        case UIGestureRecognizerStateEnded: {
            if (!_isChange) {
                cell.center = [_collectionView layoutAttributesForItemAtIndexPath:cellIndexpath].center;
            }
            cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
            
            break;
            
        default:
            break;
    }
}

#pragma mark ------iOS > 9.0长按移动------

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    if (@available(iOS 9.0, *)) {
        CGPoint point = [longPress locationInView:_collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
        
        switch (longPress.state) {
            case UIGestureRecognizerStateBegan:
                if (!indexPath) {
                    break;
                }
                
                BOOL canMove = [_collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
                self.thisCell = [_collectionView cellForItemAtIndexPath:indexPath];
                if (!canMove) {
                    break;
                }
                break;
                
            case UIGestureRecognizerStateChanged:
                //不可移动cell 和当前位置cell之间
                if (indexPath.row == 1 || !indexPath){
                    self.thisCell.center = [longPress locationInView:_collectionView];
                    return;
                }
                [_collectionView updateInteractiveMovementTargetPosition:point];
                break;
                
            case UIGestureRecognizerStateEnded:
                [_collectionView endInteractiveMovement];
                self.thisCell = nil;
                break;
                
            default:
                [_collectionView cancelInteractiveMovement];
                self.thisCell = nil;
                break;
        }
    }
}

#pragma mark ------GetterAndSetter------

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(45, 45);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MoveCollectionViewCell class] forCellWithReuseIdentifier:MoveCollectionViewCellID];
        
//        if (@available(iOS 9.0, *)){
//            UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//            [_collectionView addGestureRecognizer:longPressGesture];
//        }
        
    }
    return _collectionView;
}

- (NSMutableArray *)data {
    if(_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (NSMutableArray *)cellAttributesArray {
    if(_cellAttributesArray == nil) {
        _cellAttributesArray = [[NSMutableArray alloc] init];
    }
    return _cellAttributesArray;
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
