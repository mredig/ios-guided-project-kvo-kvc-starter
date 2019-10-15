//
//  LSIIRS.m
//  KVO KVC
//
//  Created by Michael Redig on 10/15/19.
//  Copyright © 2019 Lambda, Inc. All rights reserved.
//

#import "LSIIRS.h"
#import "LSIEmployee.h"

@interface LSIIRS()

@property (nonatomic, strong) NSMutableArray *monitoredEmployees;

@end

@implementation LSIIRS

- (instancetype)init {
	if (self = [super init]) {
		_monitoredEmployees = [NSMutableArray array];
	}
	return self;
}

- (void)startMonitoringEmployee:(LSIEmployee *)employee {
	[employee addObserver:self forKeyPath:@"salary" options:0 context:NULL];

	[self.monitoredEmployees addObject:employee];
}

- (void)stopMonitoringEmployee:(LSIEmployee *)employee {
	[employee removeObserver:self forKeyPath:@"salary" context:NULL];

	[self.monitoredEmployees removeObject:employee];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

	if ([keyPath isEqualToString:@"salary"]) {
		LSIEmployee *employee = object;
		NSLog(@"%@'s %@ is %@", employee.name, keyPath, [employee valueForKeyPath:keyPath]);
	}
}

@end
