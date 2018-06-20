#import <Cordova/CDV.h>

@interface NBCheckVersion : CDVPlugin

- (void)check:(CDVInvokedUrlCommand*)command;
- (void)toUpdate:(CDVInvokedUrlCommand*)command;

@end