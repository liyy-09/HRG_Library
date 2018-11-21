//
//  MsgPlaySound.m
//  SHAREMEDICINE_EMPLOYEE_iOS
//
//  Created by lyy on 2018/11/19.
//  Copyright © 2018 HRG. All rights reserved.
//

#import "MsgPlaySound.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

static SystemSoundID sound;    // 系统声音的id 取值范围为：1000-2000

@interface MsgPlaySound()

@property (nonatomic, strong) AVAudioPlayer *audioPlay;

@end

@implementation MsgPlaySound

- (instancetype) init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)playVibrate {
    sound = kSystemSoundID_Vibrate;//震动
    
    AudioServicesAddSystemSoundCompletion(sound, NULL, NULL, systemAudioCallback, NULL);
    AudioServicesPlaySystemSound(sound);
}

- (void)playMusic {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"phone" ofType:@"wav"];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    // 初始化播放器对象
    self.audioPlay = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    // 设置声音的大小
    self.audioPlay.volume = 1;//范围为（0到1）；
    // 设置循环次数，如果为负数，就是无限循环
    self.audioPlay.numberOfLoops = -1;
    // 设置播放进度
    self.audioPlay.currentTime = 0;
    
    // 设置锁屏仍能继续播放
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
    // 准备播放
    [self.audioPlay prepareToPlay];
    [self.audioPlay play];
}

- (void) dispose {
    if (sound == kSystemSoundID_Vibrate) {
        sound = -1;
        AudioServicesDisposeSystemSoundID(sound);
    }
    
    if (self.audioPlay) {
        [self.audioPlay stop];
    }
}

#pragma mark - private

void systemAudioCallback() {
    if (sound == -1) {
        return;
    }
    
    AudioServicesPlaySystemSound(sound);
}

@end
