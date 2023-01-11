//
//  ViewController.m
//  FMDB测试
//
//  Created by 翟旭博 on 2022/11/2.
//

#import "ViewController.h"
#import "FMDB.h"
@interface ViewController ()

@property (nonatomic, strong) FMDatabase *collectionDatabase;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.获得数据库文件的路径
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"%@", doc);
        NSString *fileName = [doc stringByAppendingPathComponent:@"collectionData.sqlite"];
        
        //2.获得数据库
        self.collectionDatabase = [FMDatabase databaseWithPath:fileName];
        
        //3.打开数据库
        if ([self.collectionDatabase open]) {
            BOOL result = [self.collectionDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS collectionData (mainLabel text NOT NULL, nameLabel text NOT NULL, imageURL text NOT NULL, networkURL text NOT NULL, dateLabel text NOT NULL, nowLocation text NOT NULL, goodState text NOT NULL, collectionState text NOT NULL, id text NOT NULL);"];
            if (result) {
                NSLog(@"创表成功");
            } else {
                NSLog(@"创表失败");
            }
        }
    NSString *string = @"111";
    [self insertData:string];
    NSString *string2 = @"222";
    [self insertData:string2];
    [self deleteData];
    [self queryData];

}
//插入数据
- (void)insertData:(NSString *)string {
    if ([self.collectionDatabase open]) {
       
        BOOL result = [self.collectionDatabase executeUpdate:@"INSERT INTO collectionData (mainLabel, nameLabel, imageURL, networkURL, dateLabel, nowLocation, goodState, collectionState, id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);", string, string, string, string, string, string, string, string, string];
        if (!result) {
            NSLog(@"增加数据失败");
        }else{
            NSLog(@"增加数据成功");
        }
        [self.collectionDatabase close];
    }
}

// 删除数据
- (void)deleteData {
    if ([self.collectionDatabase open]) {
        NSString *sql = @"delete from collectionData WHERE collectionState = ?";
        BOOL result = [self.collectionDatabase executeUpdate:sql, @"111"];
        if (!result) {
            NSLog(@"数据删除失败");
        } else {
            NSLog(@"数据删除成功");
        }
        [self.collectionDatabase close];
    }
}



// 查询数据
- (void)queryData {
    if ([self.collectionDatabase open]) {
        // 1.执行查询语句
        FMResultSet *resultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
        // 2.遍历结果
        while ([resultSet next]) {
            NSString *mainLabel = [resultSet stringForColumn:@"mainLabel"];
            NSLog(@"mainLabel = %@",mainLabel);
            NSString *nameLabel = [resultSet stringForColumn:@"nameLabel"];
            NSLog(@"nameLabel = %@",nameLabel);
            NSString *imageURL = [resultSet stringForColumn:@"imageURL"];
            NSLog(@"imageURL = %@",imageURL);
            NSString *networkURL = [resultSet stringForColumn:@"networkURL"];
            NSLog(@"networkURL = %@",networkURL);
            NSString *dateLabel = [resultSet stringForColumn:@"dateLabel"];
            NSLog(@"dateLabel = %@",dateLabel);
            NSString *nowLocation = [resultSet stringForColumn:@"nowLocation"];
            NSLog(@"nowLocation = %@",nowLocation);
            NSString *goodState = [resultSet stringForColumn:@"goodState"];
            NSLog(@"goodState = %@",goodState);
            NSString *collectionState = [resultSet stringForColumn:@"collectionState"];
            NSLog(@"collectionState = %@",collectionState);
            NSString *id = [resultSet stringForColumn:@"id"];
            NSLog(@"id = %@",id);
        }
        [self.collectionDatabase close];
    }
}



@end
