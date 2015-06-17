//
//  NSObject+Category.h
//  Demo
//
//  Created by Sean on 14-5-8.
//  Copyright (c) 2014年 Sean. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark- NSObject (UserInfo)
@interface NSObject (ObjectUserInfo)
/**
 @brief objectUserInfo 可以让NSObject附带用户自定义的一些参数，方便传值、实体判断等操作，
       默认为nil，操作为(nonatomic,retain)
 */
@property (nonatomic,retain) id objectUserInfo;

@end

@interface NSObject (NSObjectDelloc)
/**
 @details 该方法会在当前 object 的 dealloc 方法触发之前自动调用。
          开发者可以在这里释放 category 中定义的变量等无法自动释放的东西。
          此方法不需要调用[super objectWillDealloc].
 @attention 开发者不要在外部主动调用该 API
 */
- (void) objectWillDealloc;

@end
#pragma mark super class
@interface NSObject (NSObjectPerformSeletors)
/**
 @brief 在当前线程触发seletor，并且附加多个参数。
 示例代码:
 @code
 [self performSelector:@selector(seletorWithMutableParams::::) withObjects:@"a",@"b",@"c",@"d"];
 @endcode
 
 @param aSelector 触发的seletor
 @param firstObj 第一个参数，可以为nil
 @param ... 追加参数，如果第一个参数firstObj传nil，追加的参数将会被自动忽略
 
 @throw NSInvalidArgumentException
 */
- (id)performSelector:(SEL)aSelector withObjects:(id)firstObj, ...;


/**
 @brief 在当前线程延迟触发seletor，并且附加多个参数。
 示例代码:
 @code
 [self performSelector:@selector(seletorWithMutableParams::::) afterDelay:1.0 withObjects:@"a",@"b",@"c",@"d"];
 @endcode
 
 @param aSelector 触发的seletor,该方法不能有返回值
 #param delayTime 延迟触发时间，为非负数
 @param firstObj 第一个参数，可以为nil
 @param ... 追加参数，如果第一个参数firstObj传nil，追加的参数将会被自动忽略
 
 @note 该方法延迟时间到了时是在主线程触发。要取消延迟的 selector，
       请使用 cancelPreviousPerformdSelector:
 @throw NSInvalidArgumentException
 */
- (void)performSelector:(SEL)aSelector
             afterDelay:(NSTimeInterval) delayTime
            withObjects:(id)firstObj, ...;

/**
 @brief 触发一个定时并且可以重复执行的 selector
 @param aSelector 触发的seletor,该方法不能有返回值
 @param anArgument 参数
 @param time 时间间隔，如果传0，将立即执行，并且只执行1次
 @param yesOrNo 是否重复执行
 
 @note 要取消延迟的 selector，请使用 cancelPreviousPerformdSelector:
 */
- (void)performSelector:(SEL)aSelector
             withObject:(id)anArgument
           timeInterval:(NSTimeInterval)time
                repeats:(BOOL)yesOrNo;

/**
 @brief 取消由performSelector:afterDelay:withObjects:或者
        performSelector:withObject:timeInterval:repeats:触发的还没有执行的selector
 @param aSelector 触发的seletor
 */
- (void)cancelPreviousPerformdSelector:(SEL)aSelector;
@end

#pragma mark- 判断格式合法性
@interface NSObject (NSObjectTypeValid)
/**
 判断object是否为有效的NSData类型
 @return YES如果是NSData类型，NO如果不是活着object为nil
 */
+ (BOOL) isValidDataClass:(id) object;

/**
 判断object是否为有效的NSString类型
 @return YES如果是NSString类型，NO如果不是活着object为nil
 */
+ (BOOL) isValidStringClass:(id) object;

/**
 判断object是否为有效的NSArray类型
 @return YES如果是NSArray类型，NO如果不是活着object为nil
 */
+ (BOOL) isValidArrayClass:(id) object;

/**
 判断object是否为有效的NSDate类型
 @return YES如果是NSDate类型，NO如果不是活着object为nil
 */
+ (BOOL) isValidDateClass:(id) object;

/**
 判断object是否为有效的NSNumber类型
 @return YES如果是NSNumber类型，NO如果不是活着object为nil
 */
+ (BOOL) isValidNumberClass:(id) object;

/**
 判断object是否为有效的NSDictionary类型
 @return YES如果是NSDictionary类型，NO如果不是活着object为nil
 */
+ (BOOL) isValidDictionaryClass:(id) object;

@end

#pragma mark- NSObject  打印日志
@interface NSObject (NSObjectPrintDescription)
/**
 @brief 打印debug日志
 */
- (void) printDescription;

@end


#pragma mark- NSObject 动态交换方法
@interface NSObject (NSObjectMethodSwizzling)

/**
 @brief 交换实例方法origSel与altSel的实现
 @note 需要保证(SEL)origSel 和 (SEL)altSel 都已实现
 @return YES如果能成功修改，NO如果交换修改失败
 */
+ (BOOL)exchangeInstanceMethod:(SEL)origSel withMethod:(SEL)altSel;

/**
 @brief 交换类方法origSel与altSel的实现
 @note 需要保证(SEL)origSel 和 (SEL)altSel 都已实现
 @return YES如果能成功修改，NO如果交换修改失败
 */
+ (BOOL)exchangeClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;

@end

/*!
 下面这些方法在我们给某个class动态追加属性时将会用到。
 */
#pragma mark- NSObject 动态追加属性
@interface NSObject (NSObjectAssociateValueAndKey)
/**
 @briel 将object通过指针key与self确定关联，该object将会被retain，访问是nonatomic的
 @param value 需要关联的object，如果传nil，代表删除key所对应的关联。
 @param key 获取关联object需要的指针地址key.不能为NULL
 
 示例代码
 @code
 static char kAssociateKey;
 
 [self associateValue:object forKey:&kAssociateKey];
 @endcode
 */
- (void) associateValue:(id)value forKey:(const void *)key;

/**
 @briel 将integerValue通过指针key与self确定关联，访问是nonatomic的
 @param integerValue 需要关联的integerValue。
 @param key 获取关联integerValue需要的指针地址key.不能为NULL
 */
- (void) associateInteger:(NSInteger)integerValue forKey:(const void *)key;

/**
 @briel 将object通过指针key与self确定关联，该object不会被retain，而是assign
 @param value 需要关联的object，如果传nil，代表删除key所对应的关联。
 @param key 获取关联object需要的指针地址key.不能为NULL
 */
- (void) associateWeakValue:(id)value forKey:(const void *)key;

/**
 @brief 根据指针key获取之前设定好得关联object
 @param key 获取关联object需要的指针地址key.不能为NULL
 */
- (id) associatedValueForKey:(const void *)key;
/**
 @brief 删除可以关联的object
 @param key 关联object需要的指针地址key.不能为NULL
 */
- (void) removeAssociatedForKey:(const void *)key;

@end


#pragma mark- NSObject 打印debug信息
@interface NSObject (NSObjectDebugObjectDetail)
/** 继承关系 */
+ (NSArray*) NSObjectSuperClasses;
/** 继承关系描述信息 */
+ (NSString*) NSObjectSuperClassesDescription;

/** 返回当前类所有的属性列表 */
+ (NSArray*) NSObjectPropertyList;
/** 返回当前类所有的属性信息 */
+ (NSString*) NSObjectPropertysDescription;

/** 返回当前类所有的实例方法列表 */
+ (NSArray*) NSObjectMethodList;
/** 返回当前类所有的实例方法信息 */
+ (NSString*) NSObjectMethodsDescription;

/** 返回当前类所有的私有实例方法列表 */
+ (NSArray*) NSObjectPrivateMethodList;
/** 返回当前类所有的私有实例方法信息 */
+ (NSString*) NSObjectPrivateMethodsDescription;

/** 返回当前类所有的类方法列表 */
+ (NSArray*) NSObjectClassMethodList;
/** 返回当前类所有的类方法信息 */
+ (NSString*) NSObjectClassMethodsDescription;

/** 返回当前类所有的私有变量列表 */
+ (NSArray*) NSObjectVariableList;
/** 返回当前类所有的私有变量信息 */
+ (NSString*) NSObjectVariablesDescription;

/** 返回当前类所有遵循的协议列表 */
+ (NSArray*) NSObjectProtocalList;
/** 返回当前类所有遵循的协议信息 */
+ (NSString*) NSObjectProtocalsDescription;

/** dump类及实例信息 */
+ (NSString*) NSObjectDumpObjectInfo;


@end


@interface NSNull (NSNullException)
@end






