//
//  Flashcard_HW5Tests.m
//  Flashcard_HW5Tests
//
//  Created by Mana Mehraein on 3/13/18.
//  Copyright © 2018 Mana Mehraein. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FlashcardsModel.h"
#import "Flashcard.h"

@interface Flashcard_HW5Tests : XCTestCase
@property(strong, nonatomic) FlashcardsModel* model; //added

@end

@implementation Flashcard_HW5Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.model=[[FlashcardsModel alloc]init]; //added
}

- (void) testSharedModel {
    FlashcardsModel* model1 = [FlashcardsModel sharedModel];
    [model1 insertWithQuestion: @"What is instance variable?" answer: @"specify types of data to be stored in your class along with the names of those data types" favorite:(YES)];
    NSUInteger num1 = [model1 numberOfFlashcards];
    XCTAssertEqual(num1, 6);
    FlashcardsModel* model2 = [FlashcardsModel sharedModel]; // add a flashcard to model1
    // check model2 for increase in number of flashcards
    NSUInteger num2 = [model2 numberOfFlashcards];
    XCTAssertEqual(num1, num2);
}

-(void) testRandomFlashcard{
    Flashcard* one=[self.model randomFlashcard];
    XCTAssertNotNil(one);
}
// another possible function to do the testRandomFlashcard
//-(void) testRandomFlashcard{
//
//
//    XCTAssertNotNil(self.model);
//    Flashcard* one=[self.model randomFlashcard];
//    Flashcard* two=[self.model randomFlashcard];
//    
//    XCTAssertNotEqual(one, two);
    
//}
//test of insert and insert at index and numberofFlashcards
- (void)testInsertFlashcard {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    // local variables
    NSUInteger num;
    FlashcardsModel* model = [[FlashcardsModel alloc] init];
    
    XCTAssertNotNil(model);
    [model insertWithQuestion: @"What is instance variable?" answer: @"specify types of data to be stored in your class along with the names of those data types" favorite:(YES)];
    num = [model numberOfFlashcards];
    XCTAssertEqual(num, 6);
    
    [model insertWithQuestion:@"What is instance variable?" answer:@"specify types of data to be stored in your class along with the names of those data types" favorite:(YES) atIndex: 2];
    num = [model numberOfFlashcards];
    XCTAssertEqual(num, 7);
    
    // Should insert a student at the index of the num
    [model insertWithQuestion:@"What is instance variable?" answer:@"specify types of data to be stored in your class along with the names of those data types" favorite:(YES) atIndex: 1];
    num = [model numberOfFlashcards];
    XCTAssertEqual(num, 8);
}


- (void)testRemoveFlashcard {
    // Use the property model
    XCTAssertNotNil(self.model);
    
    // local variables
    NSUInteger num;
    
    num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 5);
    [self.model removeFlashcard];
    num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 4);
    
    [self.model insertWithQuestion: @"What is instance variable?" answer: @"specify types of data to be stored in your class along with the names of those data types" favorite:(YES)];
    num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 5);
    
    [self.model removeFlashcard];
    num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 4);
    
}

- (void)testRemoveFlashcardAtIndex {
    
    XCTAssertNotNil(self.model);
    NSUInteger num;
    num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 5);
    // local variables
    [self.model insertWithQuestion: @"What is instance variable?" answer: @"specify types of data to be stored in your class along with the names of those data types" favorite:(YES) atIndex: 1];
    num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 6);
    [self.model removeFlashcardAtIndex:1];
    num = [self.model numberOfFlashcards];
    XCTAssertEqual(num, 5);
}

-(void) testFlashcardAtIndex{
    XCTAssertNotNil(self.model);
    Flashcard* returned = [self.model flashcardAtIndex:1];
    //NSLog(@"%@", returned.question);
    //check to see that the question in return is equal to the question
    XCTAssertEqualObjects(returned.question, @"What is a class?");
}

-(void) testNextFlashcard{
    XCTAssertNotNil(self.model);
    Flashcard* returned = [self.model flashcardAtIndex:1];
    Flashcard* next= [self.model nextFlashcard];
    XCTAssertEqualObjects(next.question, returned.question);
    
}

-(void) testPrevFlashcard{
    XCTAssertNotNil(self.model);
    Flashcard* returned = [self.model flashcardAtIndex:4];
    Flashcard* prev= [self.model prevFlashcard];
    XCTAssertEqualObjects(prev.question, returned.question);
    
}

-(void) testToggleFavorite{
    XCTAssertNotNil(self.model);
    Flashcard* returned = [self.model flashcardAtIndex:4];
    [self.model toggleFavorite];
    XCTAssertTrue(returned);
    
}

-(void) testFavoriteFlashcards{
    XCTAssertNotNil(self.model);
    [self.model insertWithQuestion: @"What is instance variable?" answer: @"specify types of data to be stored in your class along with the names of those data types" favorite:(YES) atIndex: 1];
    // make new mutable array of fav and return nsarray
    Flashcard* returned = [self.model flashcardAtIndex:1];
    NSMutableArray* favs;
    favs = [[NSMutableArray alloc] init];
    [self.model favoriteFlashcards];

    if (returned.isFavorite == YES)
    {
        [favs addObject: self.model];
        XCTAssertEqual(favs.count, 1);
    }
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
