//
//  HomeTravelVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/5.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "HomeTravelVC.h"
#import "TouSuVC.h"
#import "ZXTC_Transition.h"

@interface HomeTravelVC ()<UINavigationControllerDelegate>

@property(nonatomic, strong) HomeTravelModel *model;

//@property (weak, nonatomic) IBOutlet UIImageView *imageV_car;

@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UILabel *addressL;

@property (weak, nonatomic) IBOutlet UILabel *numberL;

@property (weak, nonatomic) IBOutlet UILabel *driverL;

@property (weak, nonatomic) IBOutlet UIButton *callBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headImgV;


// animation
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percent;
@property (nonatomic, strong) UIScreenEdgePanGestureRecognizer *pan;
@property (nonatomic, assign) PushSource source;
@end

@implementation HomeTravelVC



- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (self.source == PushSourceOther) {
        return nil;
    }
    if (operation == UINavigationControllerOperationPop) {
        Transition_Travel *t = [Transition_Travel TransitionWithTransitionType:TransitionTypePop pushsource:self.source];
        return t;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController{
    return self.percent;
}

- (void)addPanGesture{
    self.pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePan:)];
    self.pan.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.pan];
    
}

- (void)edgePan:(UIScreenEdgePanGestureRecognizer *)pan{
    float progress = [pan translationInView:self.view].x / kScreenW;
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.percent = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.percent updateInteractiveTransition:progress];
    } else if (pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.5) {
            [self.percent finishInteractiveTransition];
        } else {
            [self.percent cancelInteractiveTransition];
        }
        self.percent = nil;
    }
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addPanGesture];
    [self loadInfo];
}


- (void)loadInfo{
    
    
    [self.imageV_car sd_setImageWithURL:[NSURL URLWithString:self.model.trip_pic] placeholderImage:img_shunFengChe_default];
    self.timeL.text = [NSString stringWithFormat:@"%@", self.model.trip_time];
    self.addressL.text = self.model.trip_address;
    self.numberL.text = [NSString stringWithFormat:@"%ld人", self.model.trip_people];
    self.driverL.text = self.model.trip_driver;
    [self.callBtn bk_addEventHandler:^(id sender) {
        [self call];
    } forControlEvents:UIControlEventTouchUpInside];
    self.headImgV.layer.cornerRadius = 45;
    self.headImgV.layer.masksToBounds = YES;
    [self.headImgV sd_setImageWithURL:self.model.trip_driver_pic.xd_URL placeholderImage:[UIImage imageNamed:@"54"]];
}



- (IBAction)popVC:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)tousu:(id)sender {
    
    TouSuVC *vc = [[TouSuVC alloc] initWithNibName:@"TouSuVC" bundle:nil];
    vc.trip_id = self.model.trip_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.delegate = nil;
}







- (void)call{
    NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%ld",(long)self.model.trip_phone];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}



- (instancetype)initWithHomeTravelModel:(HomeTravelModel *)model pushSource:(PushSource)source{
    self = [super initWithNibName:NSStringFromClass([HomeTravelVC class]) bundle:nil];
    if (self) {
        self.model = model;
        self.source = source;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
