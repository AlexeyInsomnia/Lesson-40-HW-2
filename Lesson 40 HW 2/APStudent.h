//
//  APStudent.h
//  Lesson 40 HW 2
//
//  Created by Alex on 26.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>




typedef enum
{
    APStudentGenderMale,
    APStudentGenderFemale
} APStudentGender;


@interface APStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *birthday;
@property (assign, nonatomic) APStudentGender gender;
@property (assign, nonatomic) float grade;



+ (APStudent *)createNewStudent:(APStudentGender)gender;




- (void)createForStudent:(APStudent *)student firstName:(APStudentGender)gender;
- (void)createForStudent:(APStudent *)student lastName:(APStudentGender)gender;
- (void)createForStudentDateOfBirth:(APStudent *)student;
- (void)createForStudentGrade:(APStudent *)student;
 
 
- (void)clearProperty:(NSString *)propertyName;


// for master mode
@property (weak, nonatomic) APStudent* friend;




@property (weak, nonatomic) NSString *keyPath;
- (APStudent *)defineFriend:(NSMutableArray *)studentsArray;



@end
