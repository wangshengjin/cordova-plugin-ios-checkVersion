#import "NBCheckVersion.h"
#import <Cordova/CDV.h>

@implementation NBCheckVersion

- (void)check:(CDVInvokedUrlCommand*)command {
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appID = infoDictionary[@"CFBundleIdentifier"];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appID]];
    NSData* data = [NSData dataWithContentsOfURL:url];
    NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    BOOL resu = NO;
   if ([lookup[@"resultCount"] integerValue] == 1)
   {
       NSString* appStoreVersion = lookup[@"results"][0][@"version"];
       NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
       if (![appStoreVersion isEqualToString:currentVersion])
       {
           resu = YES;
           NSLog(@"Need to update [%@ != %@]", appStoreVersion, currentVersion);
       }
    }
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:resu];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)toUpdate:(CDVInvokedUrlCommand*)command {
    NSString *string1 = @"itms-apps://itunes.apple.com/us/app/apple-store/id";
    NSString *string2 = @"?mt=8";
//    NSString *iTunesLink = @"itms-apps://itunes.apple.com/us/app/apple-store/id%@?mt=8";
    NSString *iTunesLink = [NSString stringWithFormat:@"%@%@%@",string1,appTrackId,string2];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

@end