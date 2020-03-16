//
//  Flashcard.h
//  Flashcard_HW5
//
//  Created by Mana Mehraein on 3/13/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flashcard : NSObject

@property (weak, nonatomic, readonly) NSString* question;
@property (weak, nonatomic, readonly) NSString* answer;
@property (nonatomic) BOOL isFavorite;

// Initializing the flashcard
- (instancetype) initWithQuestion: (NSString *) question
                           answer: (NSString *) ans;
- (instancetype) initWithQuestion: (NSString *) question
                           answer: (NSString *) ans
                       isFavorite: (BOOL) isFav;

- (NSDictionary *) convertToDictionary;
@end
