//
//  AirTapdaq.m
//  AirTapdaq
//
//  Created by Adam Schlesinger on 10/21/15.
//  Copyright © 2015 Freshplanet, Inc. All rights reserved.
//

#import "AirTapdaq.h"
#import "FPANEUtils.h"

@interface AirTapdaq () {
}
@property (nonatomic, assign) FREContext* context;
@property (nonatomic, assign) TDInterstitialAdvert* interstitial;
@property (nonatomic, assign) TDOrientation interstitialOrientation;

@end

@implementation AirTapdaq

@synthesize context, interstitial;

static AirTapdaq *sharedInstance = nil;

+ (AirTapdaq *)sharedInstance {
    
    if (sharedInstance == nil)
        sharedInstance = [[super allocWithZone:NULL] init];
    
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}

- (id)copy {
    return self;
}

#pragma mark - Interstitial delegate

- (void)willDisplayInterstitial {
    FPANE_DispatchEvent(context, @"willDisplayInterstitial");
}

- (void)didDisplayInterstitial {
    FPANE_DispatchEvent(context, @"didDisplayInterstitial");
}

- (void)didCloseInterstitial {
    FPANE_DispatchEvent(context, @"didCloseInterstitial");
}

- (void)didClickInterstitial {
    FPANE_DispatchEvent(context, @"didClickInterstitial");
}

- (void)didFailToLoadInterstitial {
    FPANE_DispatchEvent(context, @"didFailToLoadInterstitial");
}

- (void)hasNoInterstitialsAvailable {
    FPANE_DispatchEvent(context, @"hasNoInterstitialsAvailable");
}

- (void)hasInterstitialsAvailableForOrientation:(TDOrientation)orientation {
    
    FPANE_DispatchEventWithInfo(context, @"hasInterstitialsAvailableForOrientation", nil);
}

#pragma mark - Native ad delegate

- (void)didFailToLoadNativeAdverts {
    FPANE_DispatchEvent(context, @"willDisplayInterstitial");
}

- (void)hasNoNativeAdvertsAvailable {
    FPANE_DispatchEvent(context, @"willDisplayInterstitial");
}

- (void)hasNativeAdvertsAvailableForAdUnit:(TDNativeAdUnit)adUnit
                                      size:(TDNativeAdSize)adSize
                               orientation:(TDOrientation)orientation {
    
    FPANE_DispatchEventWithInfo(context, @"willDisplayInterstitial", nil);
}

@end

#pragma mark - C interface

DEFINE_ANE_FUNCTION(AirTapdaqInit) {
    
    NSString* applicationId = FPANE_FREObjectToNSString(argv[0]);
    NSString* clientKey = FPANE_FREObjectToNSString(argv[1]);
    NSArray* advertTypesEnabled = FPANE_FREObjectToNSArrayOfNSString(argv[2]);
    NSInteger frequencyCap = FPANE_FREObjectToInt(argv[3]);
    BOOL debug = FPANE_FREObjectToBool(argv[4]);
    
    NSLog(@"AirTapdaqInit %@, %@, %@, %lu, %d", applicationId, clientKey, advertTypesEnabled, frequencyCap, debug);
    FPANE_Log(context, @"AirTapdaqInit");
    
    NSMutableDictionary *tapdaqConfig = [[NSMutableDictionary alloc] init];
    [tapdaqConfig setObject:advertTypesEnabled forKey:@"advertTypesEnabled"];
    [tapdaqConfig setObject:[NSNumber numberWithInt:(int)frequencyCap] forKey:@"frequencyCap"];
    
    if (debug)
        [tapdaqConfig setObject:@YES forKey:@"testAdvertsEnabled"];
    
    Tapdaq* tapdaq = [Tapdaq sharedSession];
    
    [tapdaq setApplicationId:applicationId
                   clientKey:clientKey
                      config:tapdaqConfig];
    
    [tapdaq setDelegate:[AirTapdaq sharedInstance]];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqGetInterstitialAdvertForOrientation) {
    
    AirTapdaq* airTapdaq = [AirTapdaq sharedInstance];
    
    TDOrientation orientation = FPANE_FREObjectToInt(argv[0]);
    
    NSLog(@"AirTapdaqGetInterstitialAdvertForOrientation %lu, portrait is %lu", (unsigned long)orientation, TDOrientationPortrait);
    FPANE_Log(context, @"AirTapdaqGetInterstitialAdvertForOrientation");
    
    if (airTapdaq.interstitial == nil || airTapdaq.interstitialOrientation != orientation) {
        
        NSLog(@"AirTapdaq - making an interstitial");
        FPANE_Log(context, @"making an interstitial");
        airTapdaq.interstitial = [[Tapdaq sharedSession] getInterstitialAdvertForOrientation:orientation];
        airTapdaq.interstitialOrientation = orientation;
    }
    
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqShowInterstitial) {
    
    AirTapdaq* airTapdaq = [AirTapdaq sharedInstance];
    
    NSLog(@"AirTapdaqShowInterstitial");
    FPANE_Log(context, @"AirTapdaqShowInterstitial");
    
    if (airTapdaq.interstitial != nil) {
        NSLog(@"AirTapdaq - showing an interstitial");
        FPANE_Log(context, @"showing an interstitial");
        [airTapdaq.interstitial triggerImpression]; // doc says `sendImpression` @ http://support.tapdaq.com/article/39-ios-sdk-advanced-integration
    }
    
    return NULL;
}

#pragma mark - Extension setup

void AirTapdaqContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    
    static FRENamedFunction functions[] = {
        MAP_FUNCTION(AirTapdaqInit, NULL),
        MAP_FUNCTION(AirTapdaqShowInterstitial, NULL),
        MAP_FUNCTION(AirTapdaqGetInterstitialAdvertForOrientation, NULL)
    };
    
    *numFunctionsToTest = sizeof(functions) / sizeof(FRENamedFunction);
    *functionsToSet = functions;
}

void AirTapdaqContextFinalizer(FREContext ctx) {
    
}

void AirTapdaqInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
 
    *extDataToSet = NULL;
    *ctxInitializerToSet = &AirTapdaqContextInitializer;
    *ctxFinalizerToSet = &AirTapdaqContextFinalizer;
}

void AirTapdaqFinalizer(void *extData) {
    
}





