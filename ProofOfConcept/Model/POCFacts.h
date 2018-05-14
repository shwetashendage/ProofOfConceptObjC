//
//  POCFacts.h
//  ProofOfConcept
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POCFacts : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic, strong) NSString *imageHref;

- (id)initWithTitle:(NSString*)title description:(NSString*)description imageHref:(NSString*)imageHref;

@end
