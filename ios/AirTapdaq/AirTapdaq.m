//
//  AirTapdaq.m
//  AirTapdaq
//
//  Created by Adam Schlesinger on 10/21/15.
//  Copyright © 2015 Freshplanet, Inc. All rights reserved.
//

#import "AirTapdaq.h"
#import "FPANEUtils.h"

@implementation AirTapdaq

- (id)initWithContext:(FREContext*)extensionContext {
    
    if ((self = [super init])) {
        _context = extensionContext;
    }
    
    return self;
}

#pragma mark - Interstitial delegate

- (void)willDisplayInterstitial {
    FPANE_DispatchEvent(_context, @"willDisplayInterstitial");
}

- (void)didDisplayInterstitial {
    FPANE_DispatchEvent(_context, @"didDisplayInterstitial");
}

- (void)didCloseInterstitial {
    FPANE_DispatchEvent(_context, @"didCloseInterstitial");
}

- (void)didClickInterstitial {
    FPANE_DispatchEvent(_context, @"didClickInterstitial");
}

- (void)didFailToLoadInterstitial {
    FPANE_DispatchEvent(_context, @"didFailToLoadInterstitial");
}

- (void)hasNoInterstitialsAvailable {
    FPANE_DispatchEvent(_context, @"hasNoInterstitialsAvailable");
}

- (void)hasInterstitialsAvailableForOrientation:(TDOrientation)orientation {
    
    FPANE_DispatchEventWithInfo(_context, @"hasInterstitialsAvailableForOrientation", nil);
}

#pragma mark - Native ad delegate

- (void)didFailToLoadNativeAdverts {
    FPANE_DispatchEvent(_context, @"willDisplayInterstitial");
}

- (void)hasNoNativeAdvertsAvailable {
    FPANE_DispatchEvent(_context, @"willDisplayInterstitial");
}

- (void)hasNativeAdvertsAvailableForAdUnit:(TDNativeAdUnit)adUnit
                                      size:(TDNativeAdSize)adSize
                               orientation:(TDOrientation)orientation {
    
    FPANE_DispatchEventWithInfo(_context, @"willDisplayInterstitial", nil);
}

@end

#pragma mark - C interface

DEFINE_ANE_FUNCTION(AirTapdaqInit) {
    
    NSString* applicationId = FPANE_FREObjectToNSString(argv[0]);
    NSString* clientKey = FPANE_FREObjectToNSString(argv[1]);
    BOOL debug = FPANE_FREObjectToBool(argv[2]);
    
    NSMutableDictionary *tapdaqConfig = [[NSMutableDictionary alloc] init];
    
    if (debug)
        [tapdaqConfig setObject:@YES forKey:@"testAdvertsEnabled"];
    
    [[Tapdaq sharedSession] setApplicationId:applicationId
                                   clientKey:clientKey
                                      config:tapdaqConfig];
    
    AirTapdaq* airTapdaq = [[AirTapdaq alloc] initWithContext:context];

    
    [[Tapdaq sharedSession] setDelegate:airTapdaq];
    
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqGetInterstitialAdvert) {
    
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqShowInterstitial) {
    
    [[Tapdaq sharedSession] showInterstitial];
    
    return NULL;
}

#pragma mark - Extension setup

void AirTapdaqContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    
    static FRENamedFunction functions[] = {
        MAP_FUNCTION(AirTapdaqInit, NULL),
        MAP_FUNCTION(AirTapdaqShowInterstitial, NULL)
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





