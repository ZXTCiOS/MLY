//
//  TouSuVC.m
//  蒙爱你
//
//  Created by mahaibo on 17/7/19.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "TouSuVC.h"

@interface TouSuVC ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameL;


@property (weak, nonatomic) IBOutlet UITextView *textView;

@property (weak, nonatomic) IBOutlet UILabel *countL;

@end

@implementation TouSuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.textView.layer.cornerRadius = 5;
    self.textView.layer.masksToBounds = YES;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"#d6d6d6"].CGColor;
    self.textView.delegate = self;
    
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"dh-fh"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    back.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = back;
    self.title = @"投诉司机";
    
    
}


- (IBAction)submitBtnClicked:(id)sender {
    
    
    
    
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 200) {
        NSString *str = [textView.text substringToIndex:199];
        textView.text = str;
    }
    self.countL.text = [NSString stringWithFormat:@"%ld/200", textView.text.length];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
