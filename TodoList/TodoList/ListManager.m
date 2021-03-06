//
//  ListManager.m
//  TodoList
//
//  Created by Mesfin Bekele Mekonnen on 6/27/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import "ListManager.h"
#import "List.h"
#import "ListItem.h"

@class List;

@implementation ListManager{
    NSMutableArray *_listArray;
}

-(void) printCommands{
    
    printf("a|Add List          v|View List\n");
    printf("d|Delete List       q|Quit\n");
    printf("\n\n\n\n\n\n\n");
}

-(void)addList{
    if(_listArray == nil){
        _listArray = [[NSMutableArray alloc]init];
    }
    char temp[256];
    memset(temp, '\0',256);
    printf("\n Add title of Todo-List: ");
    scanf("%255[^\n]%*c",temp);
    fpurge(stdin);
    printf("\n");
    NSString *name = [NSString stringWithCString:temp encoding:NSASCIIStringEncoding];
    List *li = [[List alloc] initWithName:name];
    li.id = 0;
    li.viewByDueDate = NO;
    li.viewPriority = NO;
    [_listArray addObject:li];
}

-(void) deleteList:(int)index{
    
    [_listArray removeObjectAtIndex:index];
    
}

-(void) printLists{
    int i =1;
    for(List *l in _listArray){
        printf("%d. %s\n",i, [l.listName UTF8String]);
        i++;
    }
    printf("\n");
}

-(BOOL) outOfBounds:(int)index{
    NSInteger arraySize = [_listArray count];
    if(index < 1 || index > arraySize){
        NSString *c = [NSString stringWithFormat:@"%@",index<1? @"Must be greater than or equal to 1\n":@"out of bounds\n"];
        printf("%s",[c UTF8String]);
        return YES;
    }
    return NO;
}

-(int) getIndex{
    int d;
    printf("\nIndex number? ");
    scanf("%d",&d);
    fpurge(stdin);
    printf("\n");
    return d;
}

-(void) run{
    while(YES){
        char userIn[256];
        memset(userIn, '\0', 256);
        [self printLists];
        [self printCommands];
        printf("\n:");
        scanf("%255[^\n]%*c",userIn);
        fpurge(stdin);
        NSString *userString = [NSString stringWithCString:userIn encoding:NSASCIIStringEncoding];
        
        if([userString isEqualToString:@"a"] || [userString isEqualToString:@"A"]){
            
            [self addList];
            continue;
        }
        
        if([userString isEqualToString:@"d"] || [userString isEqualToString:@"D"]){
            int d = [self getIndex];
            
            if([self outOfBounds:d]){
                continue;
            }
            
            [self deleteList:d-1];
            continue;
        }
        
        if([userString isEqualToString:@"v"] || [userString isEqualToString:@"V"]){
            int d = [self getIndex];
            
            if([self outOfBounds:d]){
                continue;
            }
            List* temp = [_listArray objectAtIndex:d-1] ;
            [temp run];
            continue;
        }
        if([userString isEqualToString:@"q"] || [userString isEqualToString:@"Q"]){
            
            break;
        }
    }
}

@end
