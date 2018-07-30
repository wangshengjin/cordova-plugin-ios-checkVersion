#import "NBCheckVersion.h"
#import <Cordova/CDV.h>

@implementation NBCheckVersion
static NSString *appTrackId=@"";
- (void)check:(CDVInvokedUrlCommand*)command {
    NSString* httpurl = @"http://itunes.apple.com";
    @try{
        NSString* arg1 = command.arguments[0];
        httpurl = arg1;
    }
    @catch (NSException *exception)
    {
        
    }
    
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appID = infoDictionary[@"CFBundleIdentifier"];
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/lookup?bundleId=%@", httpurl ,appID]];
    NSData* data = [NSData dataWithContentsOfURL:url];
    
    @try
    {
      //    https://stackoverflow.com/questions/9717159/get-itunes-app-store-id-of-an-app-itself
        NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSArray* arraytest = [[NSArray alloc] init];
        appTrackId = lookup[@"results"][0][@"trackId"];
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
    @catch (NSException *exception)
    {
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:NO];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        return;
    }
    
}

- (void)toUpdate:(CDVInvokedUrlCommand*)command {
    NSString *string1 = @"itms-apps://itunes.apple.com/us/app/apple-store/id";
    NSString *string2 = @"?mt=8";
//    NSString *iTunesLink = @"itms-apps://itunes.apple.com/us/app/apple-store/id%@?mt=8";
    NSString *iTunesLink = [NSString stringWithFormat:@"%@%@%@",string1,appTrackId,string2];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}

@end
