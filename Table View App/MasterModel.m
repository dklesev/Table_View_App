//
//  MasterModel.m
//  Table View App
//
//  Created by Admin on 28.12.13.
//  Copyright (c) 2013 macVM. All rights reserved.
//

#import "MasterModel.h"

@implementation MasterModel


- (id)init
{
    self = [super init];
    if (self) {
        if (!self.objects) {
            self.objects = [[NSMutableArray alloc] init];
            
            [self.objects insertObject:@"The Beatles" atIndex:0];
            //[self.objects insertObject:@"The Who" atIndex:1];
            //[self.objects insertObject:@"The Kings" atIndex:2];
            //[self.objects insertObject:@"The Doors" atIndex:3];
            //[self.objects insertObject:@"Jimi Hendrix" atIndex:4];
            //[self.objects insertObject:@"Bee Gees" atIndex:5];
            //[self.objects insertObject:@"Iggy Pop" atIndex:6];
            //[self.objects insertObject:@"Stevie Wonder" atIndex:7];
            //[self.objects insertObject:@"BLaBelle" atIndex:8];
        }
    }
    return self;
}
@end
