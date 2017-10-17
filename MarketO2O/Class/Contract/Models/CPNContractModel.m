//
//  CPNContractModel.m
//  MarketO2O
//
//  Created by satyapeng on 17/10/2017.
//  Copyright © 2017 Maket. All rights reserved.
//

#import "CPNContractModel.h"

@implementation CPNContractModel

- (void)mj_keyValuesDidFinishConvertingToObject{
 
    self.contractUrl = [NSString stringWithFormat:@"http://www.lifva.com/%@", self.contractUrl];

}
@end
