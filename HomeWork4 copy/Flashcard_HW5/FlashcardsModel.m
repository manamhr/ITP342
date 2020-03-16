//
//  FlashcardsModel.m
//  Flashcard_HW5
//
//  Created by Mana Mehraein on 3/13/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import "FlashcardsModel.h"
#import "Flashcard.h"
#import <stdlib.h>
#import <time.h>

@interface FlashcardsModel()
@property (strong, nonatomic) NSMutableArray* flashcards;

// filepath
@property (strong, nonatomic) NSString* filepath;

@end

@implementation FlashcardsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // find the Documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = paths[0];
        NSLog(@"docDir = %@", documentsDirectory);
        self.filepath = [documentsDirectory stringByAppendingPathComponent:@"flashcards.plist"];
        NSLog(@"filepath = %@", self.filepath);
        NSMutableArray *data = [NSMutableArray arrayWithContentsOfFile: self.filepath];
        
        self.flashcards = [[NSMutableArray alloc] init];
        
//        Flashcard* f1=[[Flashcard alloc]
//                       initWithQuestion: @"What is instance variable?" answer: @"specify types of data to be stored in your class along with the names of those data types" isFavorite:NO ];
//        Flashcard* f2=[[Flashcard alloc]
//                       initWithQuestion: @"What is a class?" answer: @"Objective C Type, a class object pointed to the class data structure" isFavorite:NO];
//        Flashcard* f3=[[Flashcard alloc]
//                       initWithQuestion: @"What is SEL?" answer: @"Objective C Type, a selector is a compiler assigned code that identifies a method name" isFavorite:NO];
//        Flashcard* f4=[[Flashcard alloc]
//                       initWithQuestion: @"What is IMP?" answer: @"Objective C Type, a pointer to a method implementation that returns an id." isFavorite:NO];
//        Flashcard* f5=[[Flashcard alloc]
//                       initWithQuestion: @"What is BOOL?" answer: @"Objective C Type, returns YES or NO" isFavorite:NO];
//
//        self.flashcards = [NSMutableArray arrayWithObjects: f1,f2,f3,f4,f5,nil];
        
        if (!data) { // file doesn't exit
            // alloc & init any properties
            // ivar _propertyName
            Flashcard* f1=[[Flashcard alloc]
                           initWithQuestion: @"What is instance variable?" answer: @"specify types of data to be stored in your class along with the names of those data types" isFavorite:NO ];
            Flashcard* f2=[[Flashcard alloc]
                           initWithQuestion: @"What is a class?" answer: @"Objective C Type, a class object pointed to the class data structure" isFavorite:NO];
            Flashcard* f3=[[Flashcard alloc]
                           initWithQuestion: @"What is SEL?" answer: @"Objective C Type, a selector is a compiler assigned code that identifies a method name" isFavorite:NO];
            Flashcard* f4=[[Flashcard alloc]
                           initWithQuestion: @"What is IMP?" answer: @"Objective C Type, a pointer to a method implementation that returns an id." isFavorite:NO];
            Flashcard* f5=[[Flashcard alloc]
                           initWithQuestion: @"What is BOOL?" answer: @"Objective C Type, returns YES or NO" isFavorite:NO];

            self.flashcards = [NSMutableArray arrayWithObjects: f1,f2,f3,f4,f5,nil];
            // hard-code some data
            
        } else {
            self.flashcards = [[NSMutableArray alloc] init];
            for (NSDictionary* dict in data) {
                
                // NSDictionary object to Flashcard object
                Flashcard* flashcard = [[Flashcard alloc] initWithQuestion: dict[@"qKey"] answer:dict[@"ansKey"]];
                [self.flashcards addObject: flashcard];
            }
        }
        
       
//                NSLog(@"%d", _flashcards.count);
//        self.flashcards=[NSMutableDictionary dictionaryWithObjectsAndKeys:
//
//                         @"What is instance variable?",@"specify types of data to be stored in your class along with the names of those data types",
//                         @"What is a class?" , @"Objective C Type, a class object pointed to the class data structure",
//                         nil];
        
        //Initialize the currentIndex to 0.
        _currentIndex=0;
        
    }
    return self;
}

// Creating the model
+ (instancetype) sharedModel{
    //method body
    static FlashcardsModel *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once - thread safe version
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}
// Accessing number of flashcards in model
- (NSUInteger) numberOfFlashcards{
    //method body
    return self.flashcards.count;
    
}
// Accessing a flashcard – sets currentIndex appropriately
- (Flashcard *) randomFlashcard{
    //method body
    //        Flashcard* random = _flashcards[self.currentIndex];
    //    NSLog(@"%@ %d", random.answer, self.currentIndex);
    
    _currentIndex=random() % (self.flashcards.count);
    return self.flashcards[_currentIndex];
    
}
- (Flashcard *) flashcardAtIndex: (NSUInteger) index{
    //method body
    //check if the index is inbound
    if (index<=self.numberOfFlashcards-1)
    {
        return self.flashcards[index];
    }
    else
    {
        return nil;
    }
    
}
- (Flashcard *) nextFlashcard{
    //method body
    
    if (self.flashcards.count==0)
    {
        return nil;
        
    }
    
    if (_currentIndex == self.flashcards.count-1 )
    {
        _currentIndex=0;
    }
    else
    {
        _currentIndex+=1;
        
    }
    
    
    return self.flashcards[self.currentIndex];
}
- (Flashcard *) prevFlashcard{
    //method body
    if (self.flashcards.count==0)
    {
        return nil;
    }
    
    if (_currentIndex==0)
    {
        _currentIndex = self.flashcards.count-1;
    }
    else
    {
        _currentIndex -=1;
    }
    
    return self.flashcards[self.currentIndex];
    
}
// Inserting a flashcard
- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL) fav{
    //method body
    //create
    Flashcard* newcard = [[Flashcard alloc] initWithQuestion: question answer: ans isFavorite:fav];
    
    [self.flashcards addObject:newcard];
     [self save];
    
}

- (void) insertWithQuestion: (NSString *) question
                     answer: (NSString *) ans
                   favorite: (BOOL) fav
                    atIndex: (NSUInteger) index{
    
    //make the card
    Flashcard* newcard = [[Flashcard alloc] initWithQuestion: question answer: ans isFavorite:fav];
    //check the index
    if (index <= [self numberOfFlashcards]) {
        [self.flashcards insertObject:newcard atIndex:index];
    }
     [self save];
}
// Removing a flashcard
- (void) removeFlashcard{
    //method body
    if ([self numberOfFlashcards] > 0) {
        [self.flashcards removeLastObject];
    }
     [self save];
}
- (void) removeFlashcardAtIndex: (NSUInteger) index{
    //method body
    NSUInteger num=[self numberOfFlashcards];
    
    if (num> 0 && index< num) {
        [self.flashcards removeObjectAtIndex:index];
    }
    else {
        NSLog (@"There are no flashcards or you have a bad index");
        
    }
     [self save];
}
// Favorite/unfavorite the current flashcard
- (void) toggleFavorite{
    //method body
    
    
    if ([self.flashcards[_currentIndex]isFavorite] != YES)
    {
        [self.flashcards[_currentIndex] setIsFavorite:YES];
    }
    //    else
    //    {
    //        self.flashcards.isFavorite = YES;
    //    }
     [self save];
}
// Getting the favorite flashcards
- (NSArray *) favoriteFlashcards{
    NSMutableArray* favs;
    favs = [[NSMutableArray alloc] init];
    // make new mutable array of fav and return nsarray
    for (int i=0; i<_currentIndex; i++)
    {
        if ([self.flashcards[_currentIndex]isFavorite] == YES)
        {
            [favs addObject:self.flashcards[i]];
        }
         [self save];
    }
    return favs;
}

- (void) save {
    NSMutableArray *fCards = [[NSMutableArray alloc] init];
    for (Flashcard* flashcard in self.flashcards) {
        NSDictionary *FlashcardDict = [flashcard convertToDictionary];
        [fCards addObject:FlashcardDict];
    }
    
    [fCards writeToFile: self.filepath atomically:YES];
}


@end
