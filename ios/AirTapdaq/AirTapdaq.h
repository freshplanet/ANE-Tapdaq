//
//  AirTapdaq.h
//  AirTapdaq
//
//  Created by Adam Schlesinger on 10/21/15.
//  Copyright © 2015 Freshplanet, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Adobe AIR/Adobe AIR.h>
#import <Tapdaq/Tapdaq.h>

@interface AirTapdaq : NSObject <TapdaqDelegate>

@end

void AirTapdaqContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);
void AirTapdaqContextFinalizer(FREContext ctx);
void AirTapdaqInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
void AirTapdaqFinalizer(void *extData);