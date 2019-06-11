//
//  CaptureViewController.h
//  360Video
//
//  Created by apple on 5/23/19.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum captureStateTypes
{
    CAPTURE_360 = 1,
    PROCESS_360,
    PREVIEW_360,
    UPLOAD_360,
    PANO_360,
    PANO_PREVIEW,
    PANO_UPLOAD
} CaptureState;

@protocol CaptureViewControllerDelegate <NSObject>

@optional
-(void)cancelButtonAction:(NSString*)message;
-(void)stopButtonAction:(NSString*)message;
@end

@interface CaptureViewController : UIViewController {
    int timeInSeconds;
}

@property (nonatomic, weak) id<CaptureViewControllerDelegate> CaptureViewDelegate;
@property (assign, nonatomic) NSInteger captureState;
@property (strong, nonatomic) UILabel *recorderTimeLbl;
@property(nonatomic,strong)NSTimer *updateTimer;

@end

NS_ASSUME_NONNULL_END
