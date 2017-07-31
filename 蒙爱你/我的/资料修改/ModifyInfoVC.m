//
//  ModifyInfoVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ModifyInfoVC.h"
#import "CorePhotoPickerVCManager.h"
@interface ModifyInfoVC ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIControl *iconControl;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextLabel;

@property (weak, nonatomic) IBOutlet UIButton *MaleBtn;

@property (weak, nonatomic) IBOutlet UIButton *FemaleBtn;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (weak, nonatomic) IBOutlet UIView *nameView;

@property (weak, nonatomic) IBOutlet UIView *genderView;


@end

@implementation ModifyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeCornerRadius];
    [self contentInit];
    [self loaddata];
    
}
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.nameTextLabel resignFirstResponder];
}
-(void)loaddata
{
    
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *token = [userDefault objectForKey:user_key_token];
    NSString *url = [NSString stringWithFormat:get_info,userid,token];
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",  nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"dic-----%@",dic);
        if ([[dic objectForKey:@"code"] intValue]==200) {
            NSDictionary *datadic = [dic objectForKey:@"data"];
            self.nameTextLabel.text = [datadic objectForKey:@"user_nickname"];
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:[datadic objectForKey:@"user_picture"]]];
            
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)makeCornerRadius{
    self.iconControl.layer.cornerRadius = self.iconView.frame.size.width / 2.0;
    self.iconControl.layer.masksToBounds = YES;
    self.nameView.layer.cornerRadius = 5;
    self.nameView.layer.masksToBounds = YES;
    self.genderView.layer.cornerRadius = 5;
    self.genderView.layer.masksToBounds = YES;
    self.finishBtn.layer.cornerRadius = 5;
    self.finishBtn.layer.masksToBounds = YES;
//    self.iconView.layer.cornerRadius = self.iconView.frame.size.width / 2.0;
//    self.iconView.layer.masksToBounds = YES;
}

- (void)contentInit{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"name"]) {
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
        self.nameTextLabel.text = name;
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"icon"]) {
        UIImage *img = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
        self.iconView.image = img;
    } else {
        self.iconView.image = [UIImage imageNamed:@"icon_default"];
    }
    
    /*if ([[NSUserDefaults standardUserDefaults] objectForKey:@"gender"]) {
     NSInteger gender = [[[NSUserDefaults standardUserDefaults] objectForKey:@"gender"] integerValue];
     if (gender == 1) {
     self.MaleBtn.selected = YES;
     self.FemaleBtn.selected = NO;
     self.MaleBtn.enabled = NO;
     self.FemaleBtn.enabled = YES;
     
     } else if (gender == 2){
     self.MaleBtn.selected = NO;
     self.FemaleBtn.selected = YES;
     self.MaleBtn.enabled = YES;
     self.FemaleBtn.enabled = NO;
     }
     } else {
     self.MaleBtn.selected = NO;
     self.FemaleBtn.selected = NO;
     self.MaleBtn.enabled = YES;
     self.FemaleBtn.enabled = YES;
     }*/
    self.MaleBtn.selected = NO;
    self.FemaleBtn.selected = NO;
    self.MaleBtn.enabled = YES;
    self.FemaleBtn.enabled = YES;
}

- (IBAction)finishModifyInfo:(id)sender {
    
    if (!(self.MaleBtn.isSelected || self.FemaleBtn.isSelected)) {
//        [UIAlertView bk_showAlertViewWithTitle:@"错误" message:@"请选择性别" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:nil];
        
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"错误" message:@"请选择性别" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [control addAction:action];
        [self presentViewController:control animated:YES completion:nil];
        return;
    }
    if (!self.nameTextLabel.text) {
//        [UIAlertView bk_showAlertViewWithTitle:@"错误" message:@"请输入昵称" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:nil];
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"错误" message:@"请输入昵称" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [control addAction:action];
        [self presentViewController:control animated:YES completion:nil];
        return;
    }
    
    UIImage *img = self.iconView.image;
    NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    
    
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *token = [userDefault objectForKey:user_key_token];
    
    NSDictionary *para = @{@"user_id":userid,@"api_token":token,@"user_picture":encodedImageStr,@"suffix":@"png",@"user_nickname":self.nameTextLabel.text};
    
    AFHTTPSessionManager*manager =[AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript",@"text/plain",  nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *secssionIDstr  = [userDefault objectForKey:sessionID];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager.requestSerializer setValue:secssionIDstr forHTTPHeaderField:@"cookie"];
    
    
    [manager POST:post_infoedit parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id dic=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"dic-----%@",dic);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    
    NSLog(@"finish btn clicked");
}

- (IBAction)male:(UIButton *)sender {
    self.MaleBtn.selected = YES;
    self.FemaleBtn.selected = NO;
    self.MaleBtn.enabled = NO;
    self.FemaleBtn.enabled = YES;
    
}

- (IBAction)female:(UIButton *)sender {
    self.MaleBtn.selected = NO;
    self.FemaleBtn.selected = YES;
    self.MaleBtn.enabled = YES;
    self.FemaleBtn.enabled = NO;
    
}


- (IBAction)changeIcon:(id)sender {
    //  更换头像  相册、拍照
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:@"请选取" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"相册", nil];
    
    [sheet showInView:self.view];
    
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    CorePhotoPickerVCMangerType type=0;
    
    
    if(buttonIndex==0) type=CorePhotoPickerVCMangerTypeCamera;
    
    if(buttonIndex==1) type=CorePhotoPickerVCMangerTypeSinglePhoto;
    
    if(buttonIndex==2) type=CorePhotoPickerVCMangerTypeMultiPhoto;
    
    CorePhotoPickerVCManager *manager=[CorePhotoPickerVCManager sharedCorePhotoPickerVCManager];
    
    //设置类型
    manager.pickerVCManagerType = type;
    
    //最多可选3张
    manager.maxSelectedPhotoNumber = 1;
    
    //错误处理
    if(manager.unavailableType != CorePhotoPickerUnavailableTypeNone){
        NSLog(@"设备不可用");
        return;
    }
    
    UIViewController *pickerVC = manager.imagePickerController;
    
    //选取结束
    manager.finishPickingMedia = ^(NSArray *medias){
        
        [medias enumerateObjectsUsingBlock:^(CorePhoto *photo, NSUInteger idx, BOOL *stop) {
            NSLog(@"%@",photo.editedImage);
            self.iconView.image = photo.editedImage;
        }];
    };
    
    [self presentViewController:pickerVC animated:YES completion:nil];
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
