#import "Cordova/CDV.h"
#import "Cordova/CDVViewController.h"
#import "CheckInstalledApps.h"
#import <sys/stat.h>
#import <sys/sysctl.h>

@implementation CheckInstalledApps

- (void) checkInstalledApps:(CDVInvokedUrlCommand*)command;
{
    NSString* appScheme = [command.arguments objectAtIndex:0];
    CDVPluginResult *pluginResult;

    @try
    {
        bool isApplicationAvailable = [self isApplicationAvailable:appScheme];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:isApplicationAvailable];
    
    }
    @catch (NSException *exception)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:exception.reason];
    }
    @finally
    {
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

- (bool) isApplicationAvailable:(NSString*)appScheme {
     
    NSURL *appUrl = [NSURL URLWithString:appScheme];

    if ([[UIApplication sharedApplication] canOpenURL:appUrl]) {
        NSLog(@"App is already installed");
        return YES;
    } else {
        NSLog(@"App is not installed");
        return NO;
    }
}
@end
