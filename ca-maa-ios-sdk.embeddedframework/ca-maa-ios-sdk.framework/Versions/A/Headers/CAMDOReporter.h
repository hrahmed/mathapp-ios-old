/*
 * Author: Nilesh Agrawal <Nilesh.Agrawal@ca.com>
 *
 * Copyright (c) 2013-2014 CA Technologies
 * All rights reserved.
 *
 */

#import <Foundation/Foundation.h>

@interface CAMDOReporter : NSObject {
    NSString *applicationServiceName;
    NSString *applicationTransactionName;
    BOOL isAPMEnabled;
    BOOL optOut;
}

@property(retain, nonatomic)  NSString *applicationServiceName;
@property(retain, nonatomic)  NSString *applicationTransactionName;
@property BOOL isAPMEnabled;
@property BOOL optOut;


+ (void ) initializeSDK;
+ (CAMDOReporter *) sharedInstance;

- (void) startSession;
- (void)logEvent:(NSString *)eventName value:(NSString *) value attributes:(NSDictionary *)attributes
            time:(NSNumber*) timeStamp isCrash:(BOOL)isCrash;
- (void)appDidEnterBackground;

- (void) enableAPM;
- (void) disableAPM;

-(void) startApplicationService:(NSString *) serviceName;
-(void) startApplicationTransactionWithService:(NSString *)  serviceName withTransactionName:(NSString *)  transactionName;
-(void) stopApplicationService;

-(void)  startApplicationTransaction:(NSString *)  transactionName;
-(void)  stopApplicationTransaction;

@end

