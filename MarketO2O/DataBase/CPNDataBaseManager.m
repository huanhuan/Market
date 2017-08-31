//
//  CPNDataBaseManager.m
//  
//
//  Created by CPN on 15/11/14.
//  Copyright © 2015年 . All rights reserved.
//

#import "CPNDataBaseManager.h"
#import "NSString+FMDB.h"

#define kDefaultDBName @"CPNDataBase.sqlite"

@interface CPNDataBaseManager ()



@end

@implementation CPNDataBaseManager
CPNSingletonM(CPNDataBaseManager)

/**
 *  数据库队列的初始化：本操作一个
 */
+(void)initialize{
    
    //取出实例
    CPNDataBaseManager *manager=[CPNDataBaseManager sharedCPNDataBaseManager];
    NSString * docp = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    NSString * documentPath = [docp stringByAppendingString:[NSString stringWithFormat:@"/%@",kDefaultDBName]];
    const BOOL needLogSqlFilePath=YES;
    
    if(needLogSqlFilePath) NSLog(@"dbPath:%@",documentPath);
    //创建队列
    FMDatabaseQueue *queue =[FMDatabaseQueue databaseQueueWithPath:documentPath];
    
    if(queue==nil)NSLog(@"code=1：创建数据库失败，请检查");
    
    manager.queue = queue;
}



/**
 *  执行一个更新语句
 *
 *  @param sql 更新语句的sql
 *
 *  @return 更新语句的执行结果
 */
+(BOOL)executeUpdate:(NSString *)sql{
    
    __block BOOL updateRes = NO;
    
    CPNDataBaseManager *manager=[CPNDataBaseManager sharedCPNDataBaseManager];
    [manager.queue inDatabase:^(FMDatabase *db) {
        
        updateRes = [db executeUpdate:sql];
    }];
    
    return updateRes;
}





/**
 *  执行一个查询语句
 *
 *  @param sql              查询语句sql
 *  @param queryResBlock    查询语句的执行结果
 */
+(void)executeQuery:(NSString *)sql queryResBlock:(void(^)(FMResultSet *set))queryResBlock{
    
    CPNDataBaseManager *manager=[CPNDataBaseManager sharedCPNDataBaseManager];
    
    [manager.queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *set = [db executeQuery:sql];
        
        if(queryResBlock != nil) queryResBlock(set);
        [set close];
    }];
}




/**
 *  查询出指定表的列
 *
 *  @param table table
 *
 *  @return 查询出指定表的列的执行结果
 */
+(NSArray *)executeQueryColumnsInTable:(NSString *)table{
    
    NSMutableArray *columnsM=[NSMutableArray array];
    
    NSString *sql=[NSString stringWithFormat:@"PRAGMA table_info (%@);",table];
    
    [self executeQuery:sql queryResBlock:^(FMResultSet *set) {
        
        //循环取出数据
        while ([set next]) {
            NSString *column = [set stringForColumn:@"name"];
            [columnsM addObject:column];
        }
        
        if(columnsM.count==0) NSLog(@"code=2：您指定的表：%@,没有字段信息，可能是表尚未创建！",table);
    }];
    
    return [columnsM copy];
}


/**
 *  表记录数计算
 *
 *  @param table 表
 *
 *  @return 记录数
 */
+(NSUInteger)countTable:(NSString *)table{
    
    NSString *alias=@"count";
    
    NSString *sql=[NSString stringWithFormat:@"SELECT COUNT(*) AS %@ FROM %@;",alias,table];
    
    __block NSUInteger count=0;
    
    [self executeQuery:sql queryResBlock:^(FMResultSet *set) {
        
        while ([set next]) {
            
            count = [[set stringForColumn:alias] integerValue];
        }
    }];
    
    return count;
}


/**
 *  清空表（但不清除表结构）
 *
 *  @param table 表名
 *
 *  @return 操作结果
 */
+(BOOL)truncateTable:(NSString *)table{
    
    BOOL res = [self executeUpdate:[NSString stringWithFormat:@"DELETE FROM '%@'", table]];
    [self executeUpdate:[NSString stringWithFormat:@"DELETE FROM sqlite_sequence WHERE name='%@';", table]];
    return res;
}

@end
