//
//  ViewController.h
//  ReactionTest
//
//  Created by Victor Ordozgoite on 24/12/22.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSTimer *timer;
    BOOL gameStarted;
    BOOL canTap;
    double randomNumber;
    int counter;
    NSDate *startTime;
    NSString *cleanTimeCounter;
    int cleanTimeNum;
    int scoreSum;
    int avarageScore;
    int attemptsCounter;
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *secondaryLabel;

- (IBAction)screenTapped:(UIButton *)sender;

@end

