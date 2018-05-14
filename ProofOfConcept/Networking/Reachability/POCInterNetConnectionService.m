//
//  POCInterNetConnectionService.m
//  ProofOfConcept
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import "POCInterNetConnectionService.h"
#import "Reachability_Internet.h"

@implementation POCInterNetConnectionService


- (BOOL)checkFornetConnection {
    
    Reachability_Internet* wifiReach = [Reachability_Internet reachabilityForInternetConnection];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
    if (netStatus == NotReachable)
    {
        return FALSE;
    }
    return TRUE;
}

@end
