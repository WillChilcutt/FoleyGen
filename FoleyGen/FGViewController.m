//
//  FGViewController.m
//  FoleyGen
//
//  Created by Will Chilcutt on 3/28/12.
//  Copyright (c) 2012 ETSU. All rights reserved.
//

#import "FGViewController.h"

#define TWEET_BUTTON_TAG 101
#define POP_BUTTON_TAG 102
#define BOING_BUTTON_TAG 103


@implementation FGViewController
@synthesize soundSwitch;
@synthesize positionSlider;
@synthesize playButton;
@synthesize timeToCheckPosition = _timeToCheckPosition;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *tweetFilePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tweet" ofType:@"wav"]];
    
    NSURL *popFilePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"pop" ofType:@"wav"]];
    
    NSURL *boingFilePath = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"boing" ofType:@"wav"]];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)tweetFilePath, &tweetSound);
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)popFilePath, &popSound);

    AudioServicesCreateSystemSoundID((__bridge CFURLRef)boingFilePath, &boingSound);

    recordedFile = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"iHaveUnderstanding" ofType:@"wav"]];
    
    NSError *error;
    longerTrack = [[AVAudioPlayer alloc] initWithContentsOfURL:recordedFile error:&error];
    
    if (longerTrack==nil) {
        NSLog(@"Error %@", [error description]);
    }
    
    longerTrack.delegate = self;
    
    self.timeToCheckPosition = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(checkPosition) userInfo:nil repeats:YES];
}

- (void) checkPosition
{
    positionSlider.value = longerTrack.currentTime/longerTrack.duration;
}

- (void)viewDidUnload
{
    [self setSoundSwitch:nil];
    longerTrack = nil;
    recordedFile = nil;
    [self setPositionSlider:nil];
    [self setPlayButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)volumeChangedBy:(UISlider *)sender 
{
    longerTrack.volume = sender.value;
}

- (IBAction)positionChangedBy:(UISlider *)sender 
{
    longerTrack.currentTime = sender.value * longerTrack.duration;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [playButton setTitle:@"Play" forState:UIControlStateNormal];
}


- (IBAction)playPauseSound:(UIButton *)sender 
{
    if ([longerTrack isPlaying]) 
    {
        [longerTrack pause];
        [sender setTitle:@"Play" forState:UIControlStateNormal];
    }
    else
    {
        [longerTrack play];
        [sender setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

- (IBAction)loopSound:(UIButton *)sender 
{
    if (longerTrack.numberOfLoops == -1) 
    {//LOOPING
        longerTrack.numberOfLoops = 0;
        [sender setTitle:@"Loop" forState:UIControlStateNormal];
    }
    else
    {//PLAYING ONCE
        longerTrack.numberOfLoops = -1;
        [sender setTitle:@"Play Once" forState:UIControlStateNormal];
    }
}

- (IBAction)playSound:(UIButton *)sender 
{
    if (soundSwitch.isOn) 
    {
    
    switch (sender.tag) {
            
        case TWEET_BUTTON_TAG:
            
            AudioServicesPlaySystemSound(tweetSound);
            break;
            
        case POP_BUTTON_TAG:
            
            AudioServicesPlaySystemSound(popSound);
            break;
            
        case BOING_BUTTON_TAG:
            
            AudioServicesPlaySystemSound(boingSound);
            break;
            
        default:
            break;
    }
    }
    else
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        
        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"((( Vibrate )))" message:@"We are suppose to feel something now." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        
        [alert show];
        
        alert = nil;
    }
}
@end
