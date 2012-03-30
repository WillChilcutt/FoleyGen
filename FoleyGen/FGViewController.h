//
//  FGViewController.h
//  FoleyGen
//
//  Created by Will Chilcutt on 3/28/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface FGViewController : UIViewController <AVAudioPlayerDelegate, AVAudioRecorderDelegate>
{
    AVAudioPlayer *longerTrack;
    NSURL *recordedFile;
    
    NSTimer *timeToCheckPosition;

    SystemSoundID tweetSound;
    SystemSoundID popSound;
    SystemSoundID boingSound;
}

@property (strong, nonatomic) NSTimer *timeToCheckPosition;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;
@property (weak, nonatomic) IBOutlet UISlider *positionSlider;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

- (IBAction)volumeChangedBy:(UISlider *)sender;

- (IBAction)positionChangedBy:(UISlider *)sender;
- (IBAction)playPauseSound:(UIButton *)sender;
- (IBAction)loopSound:(UIButton *)sender;

- (IBAction)playSound:(UIButton *)sender;

@end
