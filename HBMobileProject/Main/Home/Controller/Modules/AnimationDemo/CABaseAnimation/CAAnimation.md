  动画类继承关系
                                            |--- CASBaseAnimation
                |--- CAPropertyAnimation ---|
                |                           |--- CAKeyframeAnimation
                |
 CAAnimation----|--- CAAnimationGroup
                |
                |
                |--- CATransition

> #### CAAnimation

**简介**: CAAnimation,所有动画的基类,不能直接使用.
1. CAPropertyAnimation 属性动画,也是一个基类,包含有: CABaseAnimation 和 CAKeyframeAnimation 两个子类, 通过控制属性值变化来产生动画.
2. CAAnimationGroup 动画组, 可以同时添加多种动画.
3. CATransition 转场动画,给视图切换的时候添加动画效果.

**属性介绍**:
```
//速度控制函数，控制动画运行的节奏
timingFunction 	
//动画代理
delegate       	
//默认为 YES, 代表动画执行完毕后就从图层上移除,图形会恢复到动画执行前的状态. 如果想让图层保持显示动画执行后的状态,那就设置为NO,不过还要设置 fillMode 为 kCAFillModeForwards.
removeOnCompletion
```

**dalegate方法**:
```
//动画开始时，执行的方法。 theAnimation：正在执行动画的CAAnimation实例
- (void)animationDidStart:(CAAnimation *)theAnimation
//动画执行完成或者动画为执行被删除时，执行该方法。theAnimation：完成或者被删除的动画实例 flag：标志该动画是执行完成或者被删除：YES：执行完成；NO：被删除。
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
```

> #### CAMediaTiming 协议

CAMediaTiming 协议定义了在一段动画内用来控制逝去时间的属性的集合，CALayer 和 CAAnimation 都实现了这个协议，所以时间可以被任意基于一个图层或者一段动画的类控制。主要属性有:

| 属性 | 描述 |
| :------        | :------ |
| beginTime      | 动画开始时间,默认为0. 可以设置动画延迟执行的时间,例如:如果想让动画延迟2s执行,就可以设置为 CACurrentMediaTime()+2. [说明:CACurrentMediaTime()为图层的当前时间]; 
| duration       | 动画持续的时间,默认为0 
| speed          | 动画执行速度 
| timeOffset     | 时间偏移量,默认0 
| repeatCount    | 动画重复的次数 
| repeatDuration | 动画重复间隔 
| autoreverses   | 动画自动逆向执行,默认为NO 
| fillMode       | 决定当前对象在非active时间段的行为.比如动画开始之前,动画结束之后 

```
// CAAnimation 速度控制函数(CAMediaTimingFunction, timingFunction)
kCAMediaTimingFunctionLinear       //线性,匀速.
kCAMediaTimingFunctionEaseIn       //渐进,动画缓慢进入,然后加速离开
kCAMediaTimingFunctionEaseOut      //渐出,动画全速进入,然后减速到达目的地
kCAMediaTimingFunctionEaseInEaseOut//渐进渐出,动画缓慢地进入,中间加速,然后减速到达目的地.这个也是默认的动画行为.
kCAMediaTimingFunctionDefault      // default is kCAMediaTimingFunctionEaseInEaseOut

// CAAnimation 动画填充模式(fillMode)
注意: 要想让 fillMode 有效,最好设置 removedOnCompletion = NO;

kCAFillModeRemoved     //这个是默认值,也就是说当动画开始前和动画结束后,动画对 layer 都没有影响,动画结束后,layer 会恢复到之前的状态.
kCAFillModeForwards    //动画结束后, layer 会一直保持着动画最后的状态.
kCAFillModeBackwards   //动画开始前,只需要将动画加入到一个 layer,layer 便立即进入动画的初始状态并等待动画开始.
kCAFillModeBoth        //这个是上面两个的合成.动画动画加入后开始前, layer 便处于动画初始状态,动画结束后layer 保持动画最后的状态.

[更加详细的说明](http://www.cocoachina.com/programmer/20131218/7569.html)
```

> ##### keyPath表

| keyPath | 描述 |
| :------                 | :------ |
| transform.rotation.x    | 绕着x轴旋转
| transform.rotation.y    | 绕着y轴旋转
| transform.rotation.z    | 绕着z轴旋转
| transform.rotation      | 默认绕着z轴旋转
| transform.scale.x       | x轴方向缩放
| transform.scale.y       | y轴方向缩放
| transform.scale.z       | z轴方向缩放
| transform.scale 	      | 默认x,y,z三个方向均**等比缩放**
| transform.translation.x | 沿x轴方向平移
| transform.translation.y | 沿y轴方向平移
| transform.translation.z | 沿z轴方向平移
| transform.translation   | 默认沿x轴和y轴同时移动，设置值时应为NSSize或者CGSize
|                         |
| opacity                 | 透明度
| margin                  | 
| zPosition               | 
| backgroundColor         | 背景颜色
| cornerRadius            | 圆角
| borderWidth             | 
| bounds                  | 
| contents                | 
| contentsRect            | 
| cornerRadius            | 
| frame                   | 
| hidden                  | 
| mask                    | 
| masksToBounds           | 
| position                | 
| shadowColor             | 
| shadowOffset            | 
| shadowOpacity           | 
| shadowRadius            | 

> ##### 1. CAPropertyAnimation

**CAPropertyAnimation**, 是 CAAnimation 的子类,是一个抽象类,想要创建动画对象,需要使用它的两个子类: CABaseAnimation 和 CAKeyframeAnimation
**属性介绍**:
| 属性 | 描述 |
| :------    | :------ |
| keyPath    | 指定接收层动画的关键路径,通过指定 CALayer 的一个属性名称为 keyPath (NSString类型),并对 CALayer 的这个属性的值进行修改,达到相应的动画效果.例如,指定 @"position.x"为keyPath, 那么将会修改 CALayer 的 position.x 属性的值,可以达到 x 轴方向的移动.
| cumulative | 下一次动画执行是否接着刚才的动画，默认为YES
| additive   | 如何处理多个动画在同一时间段执行的结果.如果是YES,则同一时间段的动画合成为一个动画.默认为 NO.(使用 CAKeyframeAnimation 时必须将该属性指定为 YES,否则不会出现预期的效果)


> ##### 1.1 CABasicAnimation
CABasicAnimation, 基本动画 继承于 CAPropertyAnimation 主要用来操作缩放、平移和旋转等简单动画。随着动画的进行，在长度为duration的持续时间内，keyPath相应属性的值会在任意一个或两个属性值的范围内渐变。
**属性介绍**:
| 属性 | 描述 |
| :------    | :------ |
| fromValue  | 相应属性的初始值
| byValue    | 过渡值
| toValue    | 相应属性的结束值 

```
CABasicAnimation *animation = [CABasicAnimation animation];
animation.keyPath   = @"transform.rotation";
animation.fromValue = @(0.1);
animation.byValue = @(M_PI_4);
animation.toValue = @(M_PI);
    
animation.beginTime = CACurrentMediaTime()+0.1;
animation.duration  = 0.5;
animation.speed = 3;
animation.repeatCount  = 1;
animation.autoreverses = NO;
animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
[self.imageView.layer addAnimation:animation forKey:NSInvalidArgumentException];
```


> ##### 1.2 CAKeyframeAnimation
CAKeyFrameAnimation：关键帧动画 继承于CAPropertyAnimation 可以设置一个一系列路径的数组 让动画在路径上执行.和 CABasicAnimation 不同的是，关键帧动画在同一时间内对同一layer可以做多种不同动画，并且可以控制各动画的执行节奏。CAKeyframeAnimation 常用的两个属性是values和duration，这两个属性就可以简单的设置动画了.
**属性介绍**:
| 主要属性 | 描述 |
| :------  | :------ |
| values   | 关键帧动画值数组,当path为nil时设置有效，否则优先选择属性path做动画.
| path     | 可以设置一个CGPathRef、CGMutablePathRef，让图层按照路径轨迹移动,也就是动画执行的点路径. path只对CALayer的anchorPoint和position起作用。如果设置了path，那么values将被忽略
| keyTimes | 关键帧动画每帧动画开始执行时间点的数组,取值区间是[0,1]. \n 数组中相邻两个值必须遵循后一个值大于或等于前一个值，并且最后的值不能为大于1。设置的时候与 calculationMode 有关，具体请查看文档。未设置时默认每帧动画执行时间平均（公式：总时间/(总帧数-1)）。
| timingFunctions | 动画执行效果数组
| calculationMode | 关键帧时间计算模式，每帧动画之间如何过渡
| rotationMode    | 设置路径旋转，当设置path有不同角度时，会自动旋转layer角度与path相切

//caculationMode：动画计算模式
kCAAnimationLinear: 线性模式，默认值
kCAAnimationDiscrete: 离散模式
kCAAnimationPaced:均匀处理，会忽略keyTimes
kCAAnimationCubic:平滑执行，对于位置变动关键帧动画运行轨迹更平滑
kCAAnimationCubicPaced:平滑均匀执行
```

摇一摇动画:
CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animation];
//默认绕 z 轴转动
shakeAnimation.keyPath = @"transform.rotation";
//设置角度变化值
CGFloat angle = M_PI_4/4;
shakeAnimation.values  = @[@(angle), @(-angle), @(angle)];
//设置关键帧动画每帧的执行时间，这里不设置也行，默认平均分配时间
shakeAnimation.keyTimes = @[@0, @0.5, @1];
//设置动画重复次数
shakeAnimation.repeatCount = MAXFLOAT;
//执行效果
//shakeAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//相邻动画的过度方式
shakeAnimation.calculationMode = kCAAnimationCubic;
[self.imageView1.layer addAnimation:shakeAnimation forKey:nil];

贝塞尔曲线动画:
UIBezierPath *path = [UIBezierPath bezierPath];
[path moveToPoint:CGPointMake(50, 550)];
[path addCurveToPoint:CGPointMake(300, 550) controlPoint1:CGPointMake(150, 450) controlPoint2:CGPointMake(250, 600)];
//设置关键帧动画
CAKeyframeAnimation *bezierAnimation = [CAKeyframeAnimation animation];
bezierAnimation.path = path.CGPath;
bezierAnimation.keyPath = @"position";
bezierAnimation.duration = 5.f;
bezierAnimation.rotationMode = kCAAnimationRotateAuto;//自动旋转 layer 角度与 path相切
bezierAnimation.repeatCount = MAXFLOAT;
bezierAnimation.autoreverses = YES;
[self.imageView1.layer addAnimation:bezierAnimation forKey:nil];

缩放动画:
CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animation];
scaleAnimation.keyPath  = @"transform.scale";
scaleAnimation.values   = @[@0.0, @0.1, @1.05, @1.0, @0.1, @0.0];//设置缩放系数
scaleAnimation.duration = 1.2;
scaleAnimation.autoreverses = YES;
scaleAnimation.repeatCount = MAXFLOAT;
[self.imageView2.layer addAnimation:scaleAnimation forKey:nil];

```

> #### 2. CAAnimationGroup
CAAnimationGroup：动画组 继承于CAAnimation 可以保存一组动画对象 将CAAnimationGroup对象加入图层后，组中所有动画对象可以同时执行.

```
//数组将几个动画对象放入其中
animations
//默认情况下，数组中的所有动画是同时执行的，也可以设置动画对象的beginTime来更改动画的开始时间
```

//实例:
```
CAKeyframeAnimation *starAnimation = [CAKeyframeAnimation animation];
starAnimation.keyPath  = @"transform.scale";
starAnimation.values   = @[@0.0, @0.1, @1.05, @0.1, @0.0];
starAnimation.keyTimes = @[@0.0, @0.2, @0.8, @1.0];
starAnimation.duration = 1.2;
starAnimation.autoreverses = NO;
starAnimation.repeatCount = MAXFLOAT;
[self.imageView1.layer addAnimation:starAnimation forKey:nil];

CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animation];
scaleAnimation.keyPath  = @"transform.scale";
scaleAnimation.values   = @[@0.0, @0.1, @1.05, @0.1, @0.0];
scaleAnimation.keyTimes = @[@0.1, @0.2, @0.8, @1.0];
scaleAnimation.duration = 1.2;
scaleAnimation.autoreverses = NO;
scaleAnimation.repeatCount = MAXFLOAT;
[self.imageView2.layer addAnimation:scaleAnimation forKey:nil];
    
CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
animationGroup.duration = 2;
animationGroup.animations = @[starAnimation, scaleAnimation];
animationGroup.repeatCount = MAXFLOAT;
[self.bgView.layer addAnimation:animationGroup forKey:nil];

```

> #### 3. CATransition
CATransition:转场动画 继承于CAAnimation 提供层移出屏幕和移入屏幕的动画效果 系统导航压栈的动画就是转场动画效果
**属性介绍**:
| 属性 | 描述 |
| :------       | :------ |
| type          | 动画过渡类型
| subtype       | 动画过渡方向
| startProgress | 动画起点 百分比
| endProgress   | 动画终点 百分比

| 过度效果 | 描述 |
| :------       | :------ |
| fade          | 交叉淡化过渡(不支持过渡方向) kCATransitionFade
| push       	| 新视图把旧视图推出去  kCATransitionPush
| moveIn 		| 新视图移到旧视图上面   kCATransitionMoveIn
| reveal   		| 将旧视图移开,显示下面的新视图  kCATransitionReveal
| cube          | 立方体翻滚效果
| oglFlip       | 上下左右翻转效果
| suckEffect    | 收缩效果，如一块布被抽走(不支持过渡方向)
| rippleEffect  | 滴水效果(不支持过渡方向)
| pageCurl 		| 向上翻页效果
| pageUnCurl    | 向下翻页效果
| cameraIrisHollowOpen  | 相机镜头打开效果(不支持过渡方向)
| cameraIrisHollowClose | 相机镜头关上效果(不支持过渡方向)

```
CATransition *animation = [CATransition animation];
//动画时间
animation.duration = 2.0f;
animation.timingFunction = UIViewAnimationCurveEaseInOut;
animation.removedOnCompletion = NO;
//过渡效果
animation.type = @"pageCurl";
//过渡方向
animation.subtype = kCATransitionFromRight;
//动画停止(在整体动画的百分比).
animation.endProgress = 0.7;
[self.imageView1.layer addAnimation:animation forKey:nil];
```

> #### 实用Tips 
##### 动画的控制
```
// 暂停正在进行中的动画
- (void)pauseSynAnimation:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed      = 0.0;
    layer.timeOffset = pausedTime;
}

// 恢复正在进行中的动画
- (void)resumeSynAnimation:(CALayer *)layer {
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed      = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime  = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime  = timeSincePause;
}

// 停止正在进行中的动画
- (void)stopSynAnimation:(CALayer *)layer {
    
    [layer removeAllAnimations];
}

```

##### 左右摇晃动画
```
#pragma mark - 状态栏左右摇晃动画
- (void)statusShakeAnimation {

    // 晃动次数
    NSInteger numberOfShakes = 2;
    // 晃动幅度(相对于总宽度而言)
    CGFloat ranggeOfShake = 0.05f;
    // 摇晃延续时长(s)
    CGFloat durationOfShake = 0.65f;
    
    
    // 获取关键点
    CGPoint layerPosition = self.synStatusText.layer.position;
    // 起始点
    NSValue *startValue = [NSValue valueWithCGPoint:layerPosition];
    // 关键点数组
    NSMutableArray *values = [[NSMutableArray alloc] initWithObjects:startValue, nil];
    for (int i = 0; i < numberOfShakes; i++) {
        // 设置左右摇晃的点
        NSValue *leftValue = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x-self.synStatusText.frame.size.width*ranggeOfShake*(1-(float)i/numberOfShakes), layerPosition.y)];
        NSValue *rightValue = [NSValue valueWithCGPoint:CGPointMake(layerPosition.x+self.synStatusText.frame.size.width*ranggeOfShake*(1-(float)i/numberOfShakes), layerPosition.y)];
        // 加入到values数组中
        [values addObject:leftValue];
        [values addObject:rightValue];
    }
    // 最后回归到起始点
    [values addObject:startValue];
    
    
    // 创建关键帧动画
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animation];
    // 设置关键帧路径
    shakeAnimation.keyPath = @"position";
    // 设置关键帧动画的 values 变化数组
    shakeAnimation.values = values;
    shakeAnimation.duration = durationOfShake;
    
    //将动画添加到控件layer上
    [self.synStatusText.layer addAnimation:shakeAnimation forKey:kCATransition];
}

```


> #### Refrance
// http://www.jianshu.com/p/679d1e552dc0#
// http://www.jianshu.com/p/d05d19f70bac#
// http://www.jianshu.com/p/9ce32ea5cb14

http://www.cnblogs.com/bucengyongyou/archive/2012/12/20/2826590.html
http://www.cnblogs.com/WJJ-Dream/p/5817283.html
http://www.tuicool.com/articles/nuYnYrj
http://www.jianshu.com/p/9ce32ea5cb14
http://www.jianshu.com/u/097ca75cf74a
