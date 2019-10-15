//
//  LSIHRDepartment.m
//  KVO KVC Demo
//
//  Created by Paul Solt on 4/9/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIHRController.h"
#import "LSIDepartment.h"
#import "LSIEmployee.h"

@interface LSIHRController ()

@property (nonatomic) NSMutableArray <LSIDepartment *> *internalDepartments;
@end


@implementation LSIHRController

- (instancetype)init {
    self = [super init];
    if (self) {
        _internalDepartments = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addDepartment:(LSIDepartment *)department {
    [self.internalDepartments addObject:department];
}

- (NSArray<LSIDepartment *> *)departments {
    return [self.internalDepartments copy];
}



- (NSString *)description {
    
    NSMutableString *output = [[NSMutableString alloc] init];
    
    [output appendString:@"Departments:\n"];
    for (LSIDepartment *department in self.departments) {
        [output appendFormat:@"%@", department];
    }
    return output;
}

- (NSArray<LSIEmployee *> *)allEmployees {

	NSMutableArray *allEmployees = [NSMutableArray array];
	for (LSIDepartment *department in self.internalDepartments) {
		[allEmployees addObjectsFromArray:department.employees];
	}

	return allEmployees;
}

- (NSInteger)highestPaidEmployee {
    LSIEmployee *highestPaid = nil;
    for (LSIEmployee *employee in self.allEmployees) {
        if (employee.salary > highestPaid.salary) {
            highestPaid = employee;
        }
    }
    return highestPaid.salary;
}

// key value option
//- (NSInteger)highestSalary {
//    return [[[self valueForKeyPath:@"departments.@unionOfArrays.employees"] valueForKeyPath:@"@max.salary"] integerValue];
//}

@end
