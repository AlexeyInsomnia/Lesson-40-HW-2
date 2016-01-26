//
//  ViewController.m
//  Lesson 40 HW 2
//
//  Created by Alex on 26.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (assign, nonatomic) APStudentGender gender;
@property (strong, nonatomic) APStudent* student;

@end

@implementation ViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gender = (arc4random() % 2) ? APStudentGenderFemale : APStudentGenderMale;
    
    self.student = [APStudent createNewStudent:self.gender ];
    
    [self showStaticTable];
    
  
    NSLog(@"viewDidLoad of ViewController started");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private methods -

- (void)showStaticTable
{
    
    // for making cell
    
    self.segmentedControlValue.selectedSegmentIndex = self.student.gender;
    self.firstNameField.text = self.student.firstName;
    self.lastNameField.text = self.student.lastName;
    
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    self.birthdayField.text = [dateFormatter stringFromDate:self.student.birthday];
    
    self.gradeField.text = [NSString stringWithFormat:@"%1.2f", self.student.grade];
    
    
    NSLog(@"showStaticTable started");
}

- (void) clearStaticTable {
    // for clearing data in cell
    
    for (UITextField* textField in self.collectionTextFields) {
        textField.text = nil;
    }
    
}




#pragma mark - Actions -

- (IBAction)segmentedControlChangeValue:(UISegmentedControl *)sender
{
    
    // if U tap M or Ж - code will make a new student with new properties for the gender U chosen
        
    
    [self clearStaticTable];
    self.gender = (sender.selectedSegmentIndex) ? APStudentGenderFemale : APStudentGenderMale;
    
    for (UITextField *textField in self.collectionTextFields)
    {
        NSString *keyPath = textField.accessibilityLabel; // very important to set in storyboard! firstName lastName birthday grade
        NSLog(@" accessibilityLabel - %@", keyPath );
        
        [self startObserver:self.student forKeyPath:keyPath];
        [self.student clearProperty:keyPath]; // 5. Также сделайте метод "сброс", который сбрасывает все пропертисы, а в самом методе не используйте сеттеры, сделайте все через айвары, но сделайте так, чтобы обсервер узнал когда и что меняется. (типо как в уроке)
        [self stopObserver:self.student forKeyPath:keyPath];
        
    }
    
    self.student = [APStudent createNewStudent:self.gender];
    [self showStaticTable];

    NSLog(@"segmentedControlChangeValue started - new Student is randomizing");
}

- (IBAction)actionTapFirstNameButton:(UIButton *)sender
{
    
    
    // changing name
    
    [self startObserver:self.student forKeyPath:@"firstName"];
    
    [self.student createForStudent:self.student firstName:self.gender];
    
    self.firstNameField.text = self.student.firstName;
    
     [self stopObserver:self.student forKeyPath:@"firstName"];
    
    NSLog(@"actionTapFirstNameButton started");
}

- (IBAction)actionTapLastNameButton:(UIButton *)sender
{
    
    // changing last name
    [self startObserver:self.student forKeyPath:@"lastName"];
    [self.student createForStudent:self.student lastName:self.gender];
    self.lastNameField.text = self.student.lastName;
    [self stopObserver:self.student forKeyPath:@"lastName"];
    NSLog(@"actionTapLastNameButton started");
}

- (IBAction)actionTapBirthdayButton:(UIButton *)sender
{
    
    // changing birthday
    
    [self startObserver:self.student forKeyPath:@"birthday"];
    [self.student createForStudentDateOfBirth:self.student];
    
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    self.birthdayField.text = [dateFormatter stringFromDate:self.student.birthday];
    [self stopObserver:self.student forKeyPath:@"birthday"];
    
    NSLog(@"actionTapBirthdayButton started");
}

- (IBAction)actionTapGradeButton:(UIButton *)sender
{
    
    // changing grade
    [self startObserver:self.student forKeyPath:@"grade"];
    [self.student createForStudentGrade:self.student];
    self.gradeField.text = [NSString stringWithFormat:@"%1.2f", self.student.grade];
     [self stopObserver:self.student forKeyPath:@"grade"];
    NSLog(@"actionTapGradeButton started");
}

#pragma mark - Private methods -

- (void)startObserver:(id)sender forKeyPath:(NSString *)keyPath
{
    [sender addObserver:self
             forKeyPath:keyPath
                options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                context:nil];
}

- (void)stopObserver:(id)sender forKeyPath:(NSString *)keyPath
{
    [sender removeObserver:self forKeyPath:keyPath];
}


#pragma mark - Observing -


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"\n observeValueForKeyPath: %@ \n change: %@", keyPath, change);
}


@end