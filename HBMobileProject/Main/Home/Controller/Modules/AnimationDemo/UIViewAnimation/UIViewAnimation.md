[iOS动画和特效（一）UIView动画和CoreAnimation](http://liuyanwei.jumppo.com/2015/10/30/iOS-Animation-UIViewAndCoreAnimation.html)

#### 简介
每个UIView都有一个layer属性，它的类型是CALayer，属于QuartzCore框架。CALayer本身并不包含在UIKit中，它不能响应事件。由于CALayer在设计之初就考虑它的动画操作功能，CALayer很多属性在修改时都能形成动画效果，这种属性称为“隐式动画属性”。 对每个UIView的非root layer对象属性进行修改时，都存在隐式动画。
