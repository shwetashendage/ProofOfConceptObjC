//
//  POCService.h
//  ProofOfConcept
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POCService : NSObject

@property (nonatomic, strong) NSMutableArray *factsArray;

- (void)getDataWithCompletionHandler:(void (^) (NSMutableArray *, NSString *, NSString *)) completion;

@end
