//
//  POCFacts.m
//  ProofOfConcept
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import "POCFacts.h"
#import "POCConstants.h"
@implementation POCFacts

- (id)initWithTitle:(NSString*)title description:(NSString*)description imageHref:(NSString*)imageHref{
    self = [super init];
    if(self){
        self.title = title;
        
        if(description != nil){
            self.descriptionString = description;
        }else{
            self.descriptionString = @"";
            
        }
        
        if(imageHref != nil){
            self.imageHref = imageHref;
        }else{
            self.imageHref = POCNoImage;
            
        }
    }
    return self;
}

@end
