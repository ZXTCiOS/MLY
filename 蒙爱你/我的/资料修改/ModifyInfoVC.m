//
//  ModifyInfoVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/26.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "ModifyInfoVC.h"
#import "CorePhotoPickerVCManager.h"
#import "myinfoCell0.h"
#import "myinfoCell1.h"
#import "strisNull.h"

#import "MBProgressHUD+XMG.h"
@interface ModifyInfoVC ()<UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>



@property (nonatomic,strong) UITableView *infoTableview;
@property (nonatomic,strong) UIButton *saveBtn;
@end

static NSString *infoidentfid0 = @"infoidentfid0";
static NSString *infoidentfid1 = @"infoidentfid1";
static NSString *infoidentfid2 = @"infoidentfid2";

@implementation ModifyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dh-fh.png"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithHexString:@"333333"];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    [self loaddata];
    
    
    self.infoTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.infoTableview];
    
    [self.view addSubview:self.saveBtn];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
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
        
        
        if ([[dic objectForKey:@"code"] intValue]==400) {
            loginVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
            vc.relogin = @"1";
            ZXTCNavigationViewController *navi = [[ZXTCNavigationViewController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:navi animated:YES completion:^{
                
            }];
        }
        
        if ([[dic objectForKey:@"code"] intValue]==200) {
            NSDictionary *datadic = [dic objectForKey:@"data"];
            UIImageView *img = [self.infoTableview viewWithTag:201];
            UITextField *text1 = [self.infoTableview viewWithTag:202];
            UITextField *text2 = [self.infoTableview viewWithTag:203];
            text1.text = [datadic objectForKey:@"user_nickname"];
            text2.text = [datadic objectForKey:@"user_phone"];
            [img sd_setImageWithURL:[NSURL URLWithString:[datadic objectForKey:@"user_picture"]] placeholderImage:[UIImage imageNamed:@"1"]];
            [self.infoTableview reloadData];
            
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

#pragma mark - getters


-(UITableView *)infoTableview
{
    if(!_infoTableview)
    {
        _infoTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _infoTableview.dataSource = self;
        _infoTableview.delegate = self;
        _infoTableview.scrollEnabled = NO;
        UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
        TapGestureTecognizer.cancelsTouchesInView=NO;
        [self.infoTableview addGestureRecognizer:TapGestureTecognizer];
    }
    return _infoTableview;
}


-(UIButton *)saveBtn
{
    if(!_saveBtn)
    {
        _saveBtn = [[UIButton alloc] init];
        [_saveBtn setImage:[UIImage imageNamed:@"dd-btn-bcxg"] forState:normal];
        _saveBtn.frame = CGRectMake(40, 400*HEIGHT_SCALE, kScreenW-80, 40);
        [_saveBtn addTarget:self action:@selector(finishModifyInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        myinfoCell0 *cell = [tableView dequeueReusableCellWithIdentifier:infoidentfid0];
        if (!cell) {
            cell = [[myinfoCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoidentfid0];
            cell.infoimg.tag = 201;
            cell.textLabel.text = @"头像";
            cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
    if (indexPath.row==1) {
        myinfoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:infoidentfid1];
        if (!cell) {
            cell = [[myinfoCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoidentfid1];
            cell.infotext.tag = 202;
            cell.infotext.delegate = self;
            cell.typelab.text = @"昵称";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==2) {
        myinfoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:infoidentfid2];
        if (!cell) {
            cell = [[myinfoCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:infoidentfid2];
            cell.infotext.tag = 203;
            cell.infotext.enabled = NO;
            cell.infotext.delegate = self;
            cell.typelab.text = @"手机号码";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        [self changeIcon];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 120;
    }else
    {
        return 50;
    }
}

- (void)finishModifyInfo {

    UIImageView *imgv = [self.infoTableview viewWithTag:201];
    UIImage *img = imgv.image;
    NSData *imageData = UIImageJPEGRepresentation(img, 1.0);
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSString *userid = [userDefault objectForKey:user_key_user_id];
    NSString *token = [userDefault objectForKey:user_key_token];
    
    UITextField *text1 = [self.infoTableview viewWithTag:202];
    //UITextField *text2 = [self.infoTableview viewWithTag:203];
    
    if (![strisNull isNullToString:encodedImageStr]&&![strisNull isNullToString:text1.text]) {
        NSDictionary *para = @{@"user_id":userid,@"api_token":token,@"user_picture":encodedImageStr,@"suffix":@"png",@"user_nickname":text1.text};
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
            
            if ([[dic objectForKey:@"code"] intValue]==400) {
                loginVC *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
                vc.relogin = @"1";
                ZXTCNavigationViewController *navi = [[ZXTCNavigationViewController alloc] initWithRootViewController:vc];
                [self.navigationController presentViewController:navi animated:YES completion:^{
                    
                }];
            }

            
            if ([[dic objectForKey:@"code"] intValue]==200) {
                [self loaddata];
                [MBProgressHUD showSuccess:@"修改成功"];
            }
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        }];
        

    }else
    {
        [MBProgressHUD showSuccess:@"请检查输入"];
    }
    
    

        NSLog(@"finish btn clicked");
}


- (void)changeIcon{
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


            UIImageView *img = [self.infoTableview viewWithTag:201];
            img.image = photo.editedImage;
            [self.infoTableview reloadData];
            
        }];
    };
    
    [self presentViewController:pickerVC animated:YES completion:nil];
    
    
}



-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)keyboardHide
{
    UITextField *text1 = [self.infoTableview viewWithTag:202];
    UITextField *text2 = [self.infoTableview viewWithTag:203];
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
}

@end
