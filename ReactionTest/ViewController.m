//
//  ViewController.m
//  ReactionTest
//
//  Created by Victor Ordozgoite on 24/12/22.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UI
    self.view.backgroundColor = [UIColor systemTealColor];
    self.label.text = @"Tap the screen to start!";
    self.label.font = [UIFont fontWithName:@"Helvetica Neue" size:32];
    self.secondaryLabel.text = @"When the screen turns green, click as quickly as you can.";
    
    // LOGIC
    gameStarted = NO;
    attemptsCounter = 0;
    scoreSum = 0;
}

// MARK: - SCREEN TAPPED

- (IBAction)screenTapped:(UIButton *)sender {
    if(gameStarted) {
        if(canTap) {
            if(attemptsCounter >= 5) {
                [self displayAvarageScreen];
            } else {
                [self displayScoreScreen];
            }
        } else {
            [self tappedTooEarlyScreen];
        }
    } else {
        [self startRedScreen];
    }
}

// MARK: - LOGIC METHODS

-(void)generateRandomNumber {
    randomNumber = arc4random_uniform(100) / 10;
}

-(void)getTimeDiff {
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"ssSSS"];
    NSTimeInterval diff = [[NSDate date] timeIntervalSinceDate:startTime];
    NSString *timeCounter = [timeFormat stringFromDate: [NSDate dateWithTimeIntervalSinceReferenceDate:diff]];
    cleanTimeNum = [timeCounter intValue];
    cleanTimeCounter = [NSString stringWithFormat:@"%d", cleanTimeNum];
}

-(void)updateTimer {
    if(canTap) {
        // 🟢 green screen (rate: 1millisec)
        [self getTimeDiff];
        self.secondaryLabel.text = cleanTimeCounter;
    } else {
        // 🔴 red screen (rate: 1sec)
        counter ++;
        if(counter >= randomNumber) {
            [timer invalidate];
            [self startGreenScreen];
        }
    }
}

// MARK: - SCREEN METHODS

-(void)displayAvarageScreen {
    //UI
    self.view.backgroundColor = [UIColor orangeColor];
    self.label.text = [NSString stringWithFormat:@"%@%d", @"Avarage: ", scoreSum/5];
    self.label.font = [UIFont fontWithName:@"Helvetica Neue" size:52];
    self.secondaryLabel.text = @"Tap to star over. 🤩";
    
    [timer invalidate];
    scoreSum = 0;
    attemptsCounter = 0;
    gameStarted = NO;
    canTap = NO;
}

-(void)displayScoreScreen {
    //UI
    self.view.backgroundColor = [UIColor systemTealColor];
    self.label.text = [NSString stringWithFormat:@"%@%@", cleanTimeCounter, @"ms"];
    self.label.font = [UIFont fontWithName:@"Helvetica Neue" size:52];
    self.secondaryLabel.text = @"Click to keep going";
    
    [timer invalidate];
    attemptsCounter ++;
    gameStarted = NO;
    canTap = NO;
    scoreSum += cleanTimeNum;
}

-(void)tappedTooEarlyScreen {
    // UI
    self.view.backgroundColor = [UIColor systemTealColor];
    self.label.text = @"Too soon!";
    self.label.font = [UIFont fontWithName:@"Helvetica Neue" size:52];
    self.secondaryLabel.text = @"Click to try again.";
    
    // LOGIC
    [timer invalidate];
    gameStarted = NO;
}

-(void)startRedScreen {
    // UI
    self.view.backgroundColor = [UIColor redColor];
    self.label.text = @"Wait for green...";
    self.label.font = [UIFont fontWithName:@"Helvetica Neue" size:32];
    self.secondaryLabel.text = @"";
    
    // LOGIC
    counter = 0;
    [self generateRandomNumber];
    gameStarted = YES;
    canTap = NO;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

-(void)startGreenScreen {
    // UI
    self.view.backgroundColor = [UIColor greenColor];
    self.label.text = @"Click!";
    self.label.font = [UIFont fontWithName:@"Helvetica Neue" size:52];
    
    // LOGIC
    canTap = YES;
    startTime = [NSDate date];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.00001 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}
@end
