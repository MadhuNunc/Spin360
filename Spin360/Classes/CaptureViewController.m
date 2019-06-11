//
//  CaptureViewController.m
//  360Video
//
//  Created by apple on 5/23/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CaptureViewController.h"
#import <AVFoundation/AVFoundation.h>

//#import "Capture360Demo-Swift.h"

@interface CaptureViewController ()
@property (assign, nonatomic) BOOL isProceesing;
@property (strong, nonatomic) UIButton *startButton;
@property (strong, nonatomic) UILabel *processLabel;
@property (strong, nonatomic) UIProgressView *progressView;
@property (assign, nonatomic) CGSize screenSize;
    
@end

@implementation CaptureViewController
@synthesize CaptureViewDelegate;
@synthesize captureState;

- (void)viewDidLoad {
    [super viewDidLoad];
    

//    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    appDelegate.restrictRotation = YES;
    
    CGFloat screenwidth;
    CGFloat screenHeight;
    
    self.screenSize = [UIScreen mainScreen].bounds.size;

    screenwidth = self.screenSize.width;
    screenHeight = self.screenSize.height;
    
    if (self.captureState == CAPTURE_360 || self.captureState == PANO_360 || self.captureState ==  PREVIEW_360 || self.captureState == PANO_PREVIEW) {
//        screenwidth = self.screenSize.height;
//        screenHeight = self.screenSize.width;

//        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//        if (!(UIInterfaceOrientationIsLandscape(orientation))){
//            NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationMaskLandscape];
//            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
//        }
        
//        [self landScapeOrientation];

    } else {
//        screenwidth = self.screenSize.width;
//        screenHeight = self.screenSize.height;

//        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
//        if (!(UIInterfaceOrientationIsPortrait(orientation))){
//            NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
//            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
//        }
        
//        [self portraitOrientation];
    }
    

    self.isProceesing = NO;
    
    NSString *cancelImage;
    NSString *startImage;
    if (self.captureState == CAPTURE_360 || self.captureState == PANO_360) {
        cancelImage = @"cancel_icon";
        startImage = @"capture_icon";
    } else if (self.captureState == PROCESS_360) {
        cancelImage = @"cancel_icon";
        startImage = @"process_icon";
    } else if (self.captureState == PREVIEW_360 || self.captureState == PANO_PREVIEW) {
        cancelImage = @"cancel_icon";
//        startImage = @"capture_icon";
    } else if (self.captureState == UPLOAD_360 || self.captureState == PANO_UPLOAD) {
        cancelImage = @"cancel_icon";
        startImage = @"upload_icon";
    }
    
    self.recorderTimeLbl = [[UILabel alloc]initWithFrame:CGRectMake((screenwidth-100)/2, 100, 100, 30)];
    self.recorderTimeLbl.textAlignment = NSTextAlignmentCenter;
    self.recorderTimeLbl.textColor = [UIColor whiteColor];
    [self.view addSubview:self.recorderTimeLbl];
    
    UIView *controlsView = [[UIView alloc]initWithFrame:CGRectMake((screenwidth-150)/2, screenHeight-100, 150, 50)];
//    controlsView.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 50, 50);
//    [cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:cancelImage] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startButton.frame = CGRectMake(cancelButton.frame.origin.x+cancelButton.frame.size.width+30, 0, 50, 50);
//    [startButton setTitle:startTitle forState:UIControlStateNormal];
    [self.startButton setImage:[UIImage imageNamed:startImage] forState:UIControlStateNormal];
    [self.startButton addTarget:self action:@selector(startButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.captureState == PREVIEW_360 || self.captureState == PANO_PREVIEW) {
        self.startButton.hidden = YES;
        cancelButton.frame = CGRectMake((controlsView.frame.size.width-50)/2, 0, 50, 50);
        UIImageView *previewImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenwidth, screenHeight)];
        previewImage.image = [UIImage imageNamed:@"car_icon"];
        previewImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:previewImage];
    }
    
    [self.view addSubview:controlsView];

    [controlsView addSubview:cancelButton];
    [controlsView addSubview:self.startButton];

    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
    self.progressView.progressTintColor = [UIColor grayColor];
    [[self.progressView layer]setFrame:CGRectMake((screenwidth-150)/2, (screenHeight-100)/2, 150, 30)];
    [[self.progressView layer]setBorderColor:[UIColor whiteColor].CGColor];
    self.progressView.trackTintColor = [UIColor whiteColor];
    [[self.progressView layer]setCornerRadius:2.0f];
    [[self.progressView layer]setBorderWidth:2];
    [[self.progressView layer]setMasksToBounds:TRUE];
    self.progressView.clipsToBounds = YES;
    
    [self.progressView setProgress:0.5];
    
    [self.view addSubview:self.progressView];
    
    self.progressView.hidden = YES;

    self.processLabel = [[UILabel alloc]initWithFrame:CGRectMake((screenwidth-200)/2, (screenHeight-30)/2, 200, 30)];
    self.processLabel.textAlignment = NSTextAlignmentCenter;
    self.processLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.processLabel];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //CLSLog(@"EditPlanVC viewWillAppear");
    
//    if (self.captureState == CAPTURE_360 || self.captureState == PANO_360 || self.captureState ==  PREVIEW_360 || self.captureState == PANO_PREVIEW) {
//        [self landScapeOrientation];
//    } else {
//        [self portraitOrientation];
//    }
//    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    appDelegate.restrictRotation = YES;
    
//    if (self.captureState == CAPTURE_360 || self.captureState == PANO_360 || self.captureState ==  PREVIEW_360 || self.captureState == PANO_PREVIEW) {
//        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        appDelegate.restrictRotation = YES;
//    } else {
//        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        appDelegate.restrictRotation = NO;
//    }
}

//-(void)portraitOrientation {
//    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
//    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
//    
//    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    appDelegate.restrictRotation = NO;
//}
//
//-(void)landScapeOrientation {
//    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationMaskLandscape];
//    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
//    
//    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    appDelegate.restrictRotation = YES;
//}

-(void)viewWillDisappear:(BOOL)animated {
//    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
//    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
//
//    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    appDelegate.restrictRotation = NO;
    
    [super viewWillDisappear:animated];
    //CLSLog(@"EditPlanVC viewWillDisappear");
    
    
    
//    if (self.captureState == CAPTURE_360 || self.captureState == PANO_360 || self.captureState ==  PREVIEW_360 || self.captureState == PANO_PREVIEW) {
//        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        appDelegate.restrictRotation = NO;
//    } else {
//        AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        appDelegate.restrictRotation = NO;
//    }
}

-(void)createButton {
    
}

//-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//        //CLSLog(@"AppDelegate supportedInterfaceOrientationsForWindow");
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//}

-(void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.CaptureViewDelegate && [self.CaptureViewDelegate respondsToSelector:@selector(stopButtonAction:)]) {
            NSString *message;
            if (self.captureState == CAPTURE_360)
                message = @"Capturing completed";
            else if (self.captureState == PROCESS_360)
                message = @"Processing completed";
            else if (self.captureState == PREVIEW_360)
                message = @"Preview 360";
            else if (self.captureState == UPLOAD_360)
                message = @"Uploading Completed";
            else if (self.captureState == PANO_360)
                message = @"Pano Completed";
            else if (self.captureState == PANO_PREVIEW)
                message = @"Pano Preview Completed";
            else
                message = @"Pano Uploading Completed";
            
            [self.CaptureViewDelegate stopButtonAction:message];
        }
    }];
}

-(void)startButtonTapped:(UIButton*)canelButton {
    if (self.captureState == CAPTURE_360 || self.captureState == PANO_360) {
        if (!self.isProceesing) {
            self.isProceesing = YES;
            [self startTimer];
            [self.startButton setImage:[UIImage imageNamed:@"stop_icon"] forState:UIControlStateNormal];
        } else
            [self dismissVC];
    } else {
       if (self.captureState == PROCESS_360 || self.captureState == UPLOAD_360 || self.captureState == PANO_UPLOAD) {
           if (self.captureState == PROCESS_360) {
//               self.isProceesing = YES;
               [self startTimer];
                self.processLabel.text = @"Processing 360... (20)";
//               self.processLabel.text = @"Processing 360... (70%)";
           }
           else if (self.captureState == UPLOAD_360) {
               [self startTimer];
               self.progressView.hidden = NO;
               self.processLabel.text = @"Uploading 360... (50%)";
           }
           else {
               [self startTimer];
               self.progressView.hidden = NO;
               self.processLabel.text = @"Uploading Pano... (50%)";
           }

           if (!self.isProceesing) {
               self.isProceesing = YES;
               [self.startButton setImage:[UIImage imageNamed:@"stop_icon"] forState:UIControlStateNormal];
           } else
               [self dismissVC];

       } else
           [self dismissVC];
    }
}

-(void)startTimer {
    if (_updateTimer != nil)
        [_updateTimer invalidate];
    
    timeInSeconds = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        self->_updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateTimeDisplay) userInfo:nil repeats:YES];
        [self->_updateTimer fire];
        
    });
}

-(void)endTimer {
    if (_updateTimer != nil)
        [_updateTimer invalidate];
}

-(void)updateTimeDisplay {
    dispatch_async(dispatch_get_main_queue(), ^{
        int time = self->timeInSeconds+1;
        if (self.captureState == PROCESS_360) {
            if ((20-time) == 0) {
                [self endTimer];
                [self dismissVC];
            }
            self.processLabel.text = [NSString stringWithFormat:@"Processing 360... (%d)",20-time];
        } else if (self.captureState == UPLOAD_360) {
            if ((20-time) == 0) {
                [self endTimer];
                [self dismissVC];
            }
            float percentage = (float)time/20;
            [self.progressView setProgress:percentage];
            self.processLabel.text = [NSString stringWithFormat:@"Uploading 360... (%d%%)", (int)(percentage*100)];
        } else if (self.captureState == PANO_UPLOAD) {
            if ((20-time) == 0) {
                [self endTimer];
                [self dismissVC];
            }
            float percentage = (float)time/20;
            [self.progressView setProgress:percentage];
            self.processLabel.text = [NSString stringWithFormat:@"Uploading Pano... (%d%%)", (int)(percentage*100)];
        } else {
            self.recorderTimeLbl.text = [self formattedCurrentTime:time];
        }
        self->timeInSeconds = time;
    });
}

-(NSString *)formattedCurrentTime:(int)time {
    int hours = time / 3600;
    int minutes = (time / 60) % 60;
    int seconds = time % 60;
    return [NSString stringWithFormat:@"%02i:%02i:%02i",hours,minutes,seconds];
}

-(void)cancelButtonTapped:(UIButton*)canelButton {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.CaptureViewDelegate && [self.CaptureViewDelegate respondsToSelector:@selector(cancelButtonAction:)]) {
            NSString *message;
            if (self.captureState == CAPTURE_360) {
                message = @"Capturing cancelled";
            } else if (self.captureState == PROCESS_360) {
                message = @"Processing cancelled";
            } else if (self.captureState == PREVIEW_360) {
                message = @"Preview closed";
            } else if (self.captureState == UPLOAD_360){
                message = @"Uploading cancelled";
            } else if (self.captureState == PANO_360) {
                message = @"Pano cancelled";
            } else if (self.captureState == PANO_PREVIEW) {
                message = @"Pano Preview closed";
            } else if (self.captureState == PANO_UPLOAD) {
                message = @"Pano Upload cancelled";
            }
            [self.CaptureViewDelegate cancelButtonAction:message];
        }
    }];
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
