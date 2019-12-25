//
//  ViewController.m
//  MengCollectionViewSort
//
//  Created by menglingchao on 2019/12/25.
//  Copyright © 2019 MengLingChao. All rights reserved.
//

#import "ViewController.h"
#import "LCCollectionViewCell.h"
#import "Masonry.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;//
@property (nonatomic, strong) NSMutableArray *titles;//cell的标题

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UICollectionView拖拽排序";
    [self collectionView];
}
#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(85, 85);
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[LCCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LCCollectionViewCell class])];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];
        [_collectionView addGestureRecognizer:longPress];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            } else {
                make.top.equalTo(self.mas_topLayoutGuideBottom);
            }
//            if (@available(iOS 11.0, *)) {
//                _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//            } else {
//                self.automaticallyAdjustsScrollViewInsets = NO;
//            }
        }];
    }
    return _collectionView;
}
- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
        [_titles addObjectsFromArray:@[@"湖人", @"雷霆", @"勇士", @"凯尔特人", @"骑士",
                                       @"热火", @"76人", @"魔术", @"开拓者", @"篮网",
                                       @"森林狼", @"快船", @"公牛", @"老鹰", @"尼克斯",
                                       @"国王", @"活塞", @"太阳", @"独行侠", @"马刺",
                                       @"灰熊", @"掘金", @"爵士", @"奇才", @"火箭",
                                       @"猛龙", @"鹈鹕", @"雄鹿", @"步行者", @"黄蜂",
        ]];
    }
    return _titles;
}
#pragma mark - Event
- (void)handleLongPressGestureRecognizer:(UILongPressGestureRecognizer *)longPress {
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
                //手势开始
                //判断手势落点位置是否在row上
                NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
                if (indexPath == nil) {
                    break;
                }
                //iOS9 方法 移动cell
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
            break;
        case UIGestureRecognizerStateChanged: {
                //iOS9 方法 移动过程中随时更新cell位置
                [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:self.collectionView]];
            }
            break;
        case UIGestureRecognizerStateEnded: {
                //手势结束
                //iOS9方法 移动结束后关闭cell移动
                [self.collectionView endInteractiveMovement];
            }
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LCCollectionViewCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    
    return cell;
}
//开启collectionView可以移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//处理collectionView移动过程中的数据操作
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //取出移动row 数据
    NSString *title = self.titles[sourceIndexPath.row];
    //从数据源中移除该数据
    [self.titles removeObject:title];
    //将数据插入到数据源中目标位置
    [self.titles insertObject:title atIndex:destinationIndexPath.row];
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.titles[indexPath.row];
    NSLog(@"title = %@", title);
}

@end
