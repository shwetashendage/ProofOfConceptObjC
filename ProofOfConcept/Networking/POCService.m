//
//  POCService.m
//  ProofOfConcept
//
//  Created by Shweta Shendage on 14/05/18.
//  Copyright © 2018 Shweta Shendage. All rights reserved.
//

#import "POCService.h"
#import "POCConstants.h"
#import "POCFacts.h"
@interface POCService ()

@property (nonatomic, strong) NSOperationQueue *backgroundqueue;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *headerTitle;

@end

@implementation POCService

@synthesize backgroundqueue;
@synthesize request;
@synthesize url;

- (void)getDataWithCompletionHandler:(void (^) (NSMutableArray *, NSString *, NSString *)) completion{
    
    self.factsArray = [[NSMutableArray alloc] init];
    
    if (!url) {
        url = [NSURL URLWithString:POCUrl];
    }
    if (!request) {
        request = [[NSMutableURLRequest alloc] initWithURL:url];
    }
    
    if (!backgroundqueue) {
        backgroundqueue = [[NSOperationQueue alloc] init];
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:backgroundqueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        
        if (error != nil || data.length == 0) {
            NSLog(@"%@",error);
            
            //On main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(nil, nil, error.localizedDescription);
            });
            
        }
        else if (httpResponse.statusCode == 200 && data.length > 0){
            
            //Parse JSON data
            [self createFactsArray:data];
            
            //On main queue
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(self.factsArray, self.headerTitle, error.localizedDescription);
            });
        }
        
    }];
    
}

- (void)createFactsArray:(NSData*)data{
    
    //Always empty array
    [self.factsArray removeAllObjects];
    
    NSError *parseError = nil;
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
    NSData *encodedData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:encodedData options:NSJSONReadingMutableContainers error:&parseError];
    
    //Update header title
    if ([jsonDictionary objectForKey:@"title"] != nil) {
        self.headerTitle = [jsonDictionary objectForKey:@"title"];
    }
    
    //Create array
    if ([jsonDictionary objectForKey:@"rows"] != nil && [[jsonDictionary objectForKey:@"rows"] isKindOfClass:[NSArray class]] && [[jsonDictionary objectForKey:@"rows"] count] > 0) {
        
        [[jsonDictionary objectForKey:@"rows"] enumerateObjectsUsingBlock:^(NSDictionary *factsDictinary, NSUInteger index, BOOL *stop){
            
            
            if ([factsDictinary objectForKey:@"title"] != nil) {
                
                [self.factsArray addObject:[[POCFacts alloc] initWithTitle:[factsDictinary objectForKey:@"title"] description:[factsDictinary objectForKey:@"description"] imageHref:[factsDictinary objectForKey:@"imageHref"]]];
                
            }
            
            
        }];
    }
    
}
@end
