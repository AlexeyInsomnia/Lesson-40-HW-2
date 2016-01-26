//
//  APStudent.m
//  Lesson 40 HW 2
//
//  Created by Alex on 26.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//




#import "APStudent.h"




@interface APStudent ()


@property (strong, nonatomic) NSArray* firstNameMale;
@property (strong, nonatomic) NSArray* firstNameFemale;
@property (strong, nonatomic) NSArray* lastNameMale;
@property (strong, nonatomic) NSArray* lastNameFemale;


@end

@implementation APStudent

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.firstNameMale = [[NSArray alloc] initWithObjects:@"Andrey",      @"Boris",       @"Vasilily",       @"Viktor",
        @"Vladimir", 	@"Dmitriy",      @"Ivan",        @"Igor",
        @"Kyrylo",      @"Kostyantyn",	@"Leonid",      @"Maksim",
        @"Mitya",      @"Mikhail", 	@"Aleksandr", 	@"Aleksey",
        @"Pavel",       @"Petr",       @"Roman",       @"Ruslan",
        @"Sergey",      @"Stanislav", 	@"Yury", nil];
 
        self.firstNameFemale = [[NSArray alloc] initWithObjects:@"Anastasiya", 	@"Vasylyna", 	@"Vira",        @"Hanna",
                                @"Kateryna", 	@"Luba",        @"Mariya",      @"Nadiya",
                                @"Nataliya", 	@"Oksana",      @"Aleksandra", 	@"Alena",
                                @"Olga",        @"Romana",      @"Ruslana", 	@"Svetlana",
                                @"Sofiya",      @"Tatyana",     @"Yulia",       @"Snezhana",
                                @"Zoryana", 	@"Myroslava", 	@"Yaroslava", nil];
        
        self.lastNameMale = [[NSArray alloc] initWithObjects: @"Pinoff", 	@"Barabash", 	@"Nazarenko", 	@"Oliynyk",
                             @"Parkhomenko", @"Petrenko",	@"Chornovil", 	@"Shevchenko",
                             @"Holub",       @"Zavgorodniy", @"Yehorenko", 	@"Yevtushenko",
                             @"Salenko", 	@"Dovzhenko", 	@"Kondratyuk", 	@"Kovalenko",
                             @"Klimenko", 	@"Melnik",      @"Mykytiuk", 	@"Litovchenko",
                             @"Glushenko",	@"Vynnychenko",	@"Vovk", nil];
        
        
        self.lastNameFemale = [[NSArray alloc] initWithObjects: @"Katyuk",      @"Kluka",       @"Kozbur",      @"Teterya",
                               @"Skrobala", 	@"Pavlyuk",     @"Orlyk",       @"Panchak",
                               @"Mayko",       @"Lazarenko", 	@"Loboda",      @"Matviyenko",
                               @"Yevtushok", 	@"Yelenyuk", 	@"Gurka",       @"Doroshenko",
                               @"Hubenko", 	@"Chachula",	@"Tymoshenko", 	@"Yurchenko",
                               @"Yarmoluk", 	@"Voitenko", 	@"Hordiyenko", nil];
        
    }
    return self;
}


+ (APStudent *)createNewStudent:(APStudentGender)gender
{
    APStudent *student = [[APStudent alloc] init];
    
    student.gender = gender;
    
    [student createForStudent:student firstName:gender];
    [student createForStudent:student lastName:gender];
    
    [student createForStudentDateOfBirth:student];
    [student createForStudentGrade:student];
    
    return student;
}

- (void)createForStudent:(APStudent *)student firstName:(APStudentGender)gender
{
    
    student.firstName = (gender == APStudentGenderMale) ?  [self.firstNameMale objectAtIndex:(arc4random() % [self.firstNameMale count])] :
        [self.firstNameFemale objectAtIndex:(arc4random() % [self.firstNameFemale count])];
}

- (void)createForStudent:(APStudent *)student lastName:(APStudentGender)gender
{
    student.lastName = (gender == APStudentGenderMale) ?   [self.lastNameMale objectAtIndex:(arc4random() % [self.lastNameMale count])] :
    [self.lastNameFemale objectAtIndex:(arc4random() % [self.lastNameFemale count])];
}


- (void)createForStudentDateOfBirth:(APStudent *)student
{
    NSDate *dateCurrent = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:dateCurrent];
    NSInteger yearCurrent = [components year];
    NSInteger birthdateYear = yearCurrent - (arc4random() % 25 + 18);
    NSInteger birthdateDay = arc4random() % 31 + 1;
    NSInteger birthdateMonth = arc4random() % 12 + 1;
    
    [components setDay:birthdateDay];
    [components setMonth:birthdateMonth];
    [components setYear:birthdateYear];
    
    student.birthday = [calendar dateFromComponents:components];
}

- (void)createForStudentGrade:(APStudent *)student
{
    student.grade = ((float)((arc4random() % 301) + 200)) / 100;
}


- (void)clearProperty:(NSString *)propertyName
{
    
        NSLog(@"clearProperty started...");
    
    [self willChangeValueForKey:propertyName]; // если не указать willChangeValueForKey и didChangeValueForKey то обсервер не увидит _firstName = nil, надо было бы self.firstname
    
    if ([propertyName isEqualToString:@"firstName"]) {
        _firstName = nil;
    }
    
    else if ([propertyName isEqualToString:@"lastName"]) {
        _lastName = nil;
    }
    
    else if ([propertyName isEqualToString:@"birthday"]) {
        _birthday = nil;
    }
    
    else
    {
        _grade = 0;
    }
    
    [self didChangeValueForKey:propertyName]; // если не указать willChangeValueForKey и didChangeValueForKey то обсервер не увидит _firstName = nil, надо было бы self.firstname
    

}

// for master mode


- (NSString *)description
{
    return [NSString stringWithFormat:@"student %@ %@ has a friend %@ %@",
            self.firstName, self.lastName, self.friend.firstName, self.friend.lastName];
}


- (APStudent *)defineFriend:(NSMutableArray *)studentsArray
{
    NSInteger studentsCount = [studentsArray count] - 1;
    
    NSInteger friendIndex = arc4random() % studentsCount;
    APStudent *friend = [studentsArray objectAtIndex:friendIndex];
    
    if ([self isEqual:friend])
    {
        [self defineFriend:studentsArray];
    }
    
    else
    {
        [self setValue:friend forKey:@"friend"];
    }
    
    return friend;
}
 


@end
