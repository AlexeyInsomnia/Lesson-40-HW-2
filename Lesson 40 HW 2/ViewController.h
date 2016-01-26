//
//  ViewController.h
//  Lesson 40 HW 2
//
//  Created by Alex on 26.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APStudent.h"

@interface ViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlValue;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
@property (weak, nonatomic) IBOutlet UITextField *gradeField;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *collectionTextFields;



- (IBAction)segmentedControlChangeValue:(UISegmentedControl *)sender;
- (IBAction)actionTapFirstNameButton:(UIButton *)sender;
- (IBAction)actionTapLastNameButton:(UIButton *)sender;
- (IBAction)actionTapBirthdayButton:(UIButton *)sender;
- (IBAction)actionTapGradeButton:(UIButton *)sender;


- (void)showStaticTable;
- (void)clearStaticTable;


@end

