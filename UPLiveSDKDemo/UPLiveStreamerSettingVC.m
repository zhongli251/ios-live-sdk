//
//  UPLiveStreamerSettingVC.m
//  UPLiveSDKDemo
//
//  Created by DING FENG on 5/20/16.
//  Copyright © 2016 upyun.com. All rights reserved.
//

#import "UPLiveStreamerSettingVC.h"

@interface UPLiveStreamerSettingVC ()<UITextFieldDelegate>
{
    Settings *_settings;
}


@property (weak, nonatomic) IBOutlet UITextField *pushPathField;
@property (weak, nonatomic) IBOutlet UITextField *playPathField;

@property (weak, nonatomic) IBOutlet UILabel *fpsLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *resolutionSelectBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cameraSelectBtn;

@property (weak, nonatomic) IBOutlet UISegmentedControl *filterLevelSelect;



@property (weak, nonatomic) IBOutlet UISwitch *filterSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *streamingSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *flashSwitch;


@property (weak, nonatomic) IBOutlet UIStepper *fpsStepper;

@end


@implementation UPLiveStreamerSettingVC

- (void)viewDidLoad {
    _settings = self.demoVC.settings;
    self.pushPathField.delegate = self;
    self.playPathField.delegate = self;

    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    self.pushPathField.text = _settings.rtmpServerPushPath;
    self.playPathField.text = _settings.rtmpServerPlayPath;
    
    self.fpsStepper.value = _settings.fps;
    self.fpsLabel.text = [NSString stringWithFormat:@"%d", _settings.fps];

    self.resolutionSelectBtn.selectedSegmentIndex = _settings.level;
    
    if (_settings.filterLevel == 0) {
        self.filterLevelSelect.selectedSegmentIndex = 0;
    } else {
        self.filterLevelSelect.selectedSegmentIndex = _settings.filterLevel -1;
    }
    
    if (_settings.camaraPosition <= 1) {
        self.cameraSelectBtn.selectedSegmentIndex = 0;
    } else {
        self.cameraSelectBtn.selectedSegmentIndex = 1;
    }
    
    self.filterSwitch.on = _settings.filter;
    self.streamingSwitch.on = _settings.streamingOnOff;
    self.flashSwitch.on = _settings.camaraTorchOn;
    
    
    
}

- (IBAction)closeBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveBtn:(id)sender {
    self.demoVC.settings = _settings;
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)filterSwitch:(UISwitch *)sender {
    _settings.filter = sender.on;

}
- (IBAction)streamingSwitch:(UISwitch *)sender {
    _settings.streamingOnOff = sender.on;
}
- (IBAction)flashSwitch:(UISwitch *)sender {
    _settings.camaraTorchOn = sender.on;
}

- (IBAction)fpsBtn:(UIStepper *)sender {
    _settings.fps = (int)self.fpsStepper.value;
    self.fpsLabel.text = [NSString stringWithFormat:@"%d", _settings.fps];
}
- (IBAction)resolutionSelectBtn:(UISegmentedControl *)sender {
    _settings.level = sender.selectedSegmentIndex;
}

- (IBAction)cameraSelectBtn:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 1) {
        _settings.camaraPosition = AVCaptureDevicePositionFront;
    } else {
        _settings.camaraPosition = AVCaptureDevicePositionBack;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    _settings.rtmpServerPushPath = self.pushPathField.text;
    _settings.rtmpServerPlayPath = self.playPathField.text;

    return YES;
}

- (IBAction)filterLevelSelect:(UISegmentedControl *)sender {
    _settings.filterLevel = sender.selectedSegmentIndex + 1;
}


@end
