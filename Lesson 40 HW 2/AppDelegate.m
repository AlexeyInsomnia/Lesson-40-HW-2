//
//  AppDelegate.m
//  Lesson 40 HW 2
//
//  Created by Alex on 26.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (strong, nonatomic) APStudent *student;
@property (strong, nonatomic) NSMutableArray *studentsArray;
@property (strong, nonatomic) NSMutableArray *studentsTempArray;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
     6. Создайте несколько студентов и положите их в массив, но обсервер оставьте только на одном из них
     7. У студентов сделайте weak проперти "friend". Сделайте цепочку из нескольких студентов, чтобы один был друг второму, второй третьему, тот четвертому, а тот первому :)
     8. Используя метод setValue: forKeyPath: начните с одного студента (не того, что с обсервером) и переходите на его друга, меняя ему проперти, потом из того же студента на друга его друга и тд (то есть путь для последнего студента получится очень длинный)
     9. Убедитесь что на каком-то из друзей, когда меняется какой-то проперти, срабатывает ваш обсервер
     */
    
    NSLog(@"SUPERMAN IS ON **********************************************");
    
    
    
    
    
    self.studentsArray = [NSMutableArray array];
    
    for (NSInteger iStudent = 0; iStudent < 201; iStudent++)
    {
        APStudentGender gender = (arc4random() % 2) ? APStudentGenderFemale : APStudentGenderMale;
        self.student = [APStudent createNewStudent:gender];
        
        [self.studentsArray addObject:self.student];
    }
    
    NSArray *studentNamesArray = [self.studentsArray valueForKeyPath:@"@distinctUnionOfObjects.firstName"];
    
    NSDate *dateOfBirthMin = [self.studentsArray valueForKeyPath:@"@min.birthday"];
    NSDate *dateOfBirthMax = [self.studentsArray valueForKeyPath:@"@max.birthday"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    NSNumber *gradeSum = [self.studentsArray valueForKeyPath:@"@sum.grade"];
    NSNumber *gradeAvg = [self.studentsArray valueForKeyPath:@"@avg.grade"];
    
    NSLog(@"countNames = %ld, \n %@", [studentNamesArray count], studentNamesArray);
    NSLog(@"dateOfBirthMin = %@, dateOfBirthMax = %@", [dateFormatter stringFromDate:dateOfBirthMin], [dateFormatter stringFromDate:dateOfBirthMax]);
    NSLog(@"gradeSum = %@", gradeSum);
    NSLog(@"gradeAvg = %@", gradeAvg);
    
    NSLog(@"SUPERMAN IS OFF  **********************************************");
    
    
    
    
    
    
    
    
    
   
   NSLog(@"MASTER IS ON **********************************************");
    
    self.studentsArray = [NSMutableArray array];
    NSInteger iStudent = -1;
    
    for (iStudent = 0; iStudent < 7; iStudent++)
    {
        APStudentGender gender = (arc4random() % 2) ? APStudentGenderFemale : APStudentGenderMale;
        self.student = [APStudent createNewStudent:gender];
        
        [self.studentsArray addObject:self.student];
    }

    
    self.studentsTempArray = [NSMutableArray array];
    
    NSInteger studentRandomIndex = (arc4random() % ([self.studentsArray count] - 3)) + 3;
    self.student = [self.studentsArray objectAtIndex:studentRandomIndex];
    

    [self.student addObserver:self
                   forKeyPath:@"grade"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:NULL];
    
    NSLog(@"Observer BIG BROTHER installed for student %@ %@", self.student.firstName, self.student.lastName);
    
    [self.studentsTempArray addObjectsFromArray:self.studentsArray];
    
    APStudent* friend = [self.studentsArray objectAtIndex:0];
    
    NSInteger countTempArray = [self.studentsTempArray count];
    
    while (countTempArray > 0)
    {
        iStudent = [self.studentsArray indexOfObject:friend];
        self.student = [self.studentsArray objectAtIndex:iStudent];
        
        if (iStudent == 0)
        {
            friend = [self.student defineFriend:self.studentsTempArray];
            [self.studentsTempArray removeObject:self.student];
        }
        
        else if (countTempArray == 2)
        {
            [[self.studentsTempArray objectAtIndex:0] setValue:[self.studentsTempArray objectAtIndex:1] forKey:@"friend"];
            [[self.studentsTempArray objectAtIndex:1] setValue:[self.studentsArray objectAtIndex:0] forKey:@"friend"];
            
            [self.studentsTempArray removeAllObjects];
        }
        
        else
        {
            friend = [self.student defineFriend:self.studentsTempArray];
            [self.studentsTempArray removeObject:self.student];
        }
        
        countTempArray = [self.studentsTempArray count];
    }
    
    NSLog(@"---цепочкa из студентов, чтобы один был друг второму, второй третьему, и тп, а тот первому---");
    
    NSLog(@"\n %@", self.studentsArray);
    
    self.student = [self.studentsArray objectAtIndex:0];
    
    
    NSString *firstName = @"firstName";
    NSString *lastName = @"lastName";
    NSString *grade = @"grade";
    
    for (iStudent = 0; iStudent < [self.studentsArray count]; iStudent++)
    {
        firstName = [@"friend." stringByAppendingString:firstName]; // !!! very nice sintax for ADDONG STRINGS
        lastName = [@"friend." stringByAppendingString:lastName];
        grade = [@"friend." stringByAppendingString:grade];
        
        //NSLog(@"\n valueForKeyPath is -%@, -%@", firstName, lastName);
        
        if (iStudent == 0)
        {
            NSLog(@"Student %@ %@ has a friend %@ %@", self.student.firstName, self.student.lastName,
                  [self.student valueForKeyPath:firstName], [self.student valueForKeyPath:lastName]);
            
        
        }
        
        else
        {
  
            
            NSLog(@"student with name in upper log string has a friend %@ %@",
                  
                  [self.student valueForKeyPath:firstName], [self.student valueForKeyPath:lastName]);
     
        }
        
        CGFloat gradeNew = ((CGFloat)((arc4random() % 301) + 200)) / 100;
        
        //NSLog(@"\n lets change grade forKeyPath is -%@", grade);
        [self.student setValue:@(gradeNew) forKeyPath:grade]; // здесь меняет проперти grade на новое рандомное
    }
   

    NSLog(@"MASTER IS OFF **********************************************");

 
    
    

    
    return YES;
}


- (void) dealloc
{
    [self.student removeObserver:self forKeyPath:@"grade"];
}


#pragma mark - Observing -
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"OBSERVER BIG BROTHER SHOWS ALERT: At student %@ %@ property %@ changed: \n %@", [object firstName], [object lastName], keyPath, change);
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
