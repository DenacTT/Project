##### CALayer简介
1.CALayer是核心动画的基础，它是所有图层类的基类（后面会一一介绍其他图层类），通过对图层的操作，可以实现很多在UIView上实现不了的动画！
2.每个UIView及其子类都有一个root layer用来显示UIView上的内容，简单点来说，UIView自身并没有显示的功能，它之所以能够显示在屏幕上，是因为它内部的图层。一个UIView至少有一个layer。
3.非root layer的部分属性修改时，会自带一些动画效果，简称隐式动画(属性后带Animatable)，常见的有bounds、backgroundColor、position等

##### CALayer常用属性
属性 	描述
anchorPoint 	锚点，x和y方向的取值范围均为(0,1)，(0,0)表示左上角，(1,1)表示右下角，(0.5,0.5)表示中心点，默认锚点为layer的中心点
bounds 	layer的大小，若为UIView的根layer，默认为UIView的bounds；若为新创建layer，默认为CGRectZero
position 	锚点所在位置的坐标，此坐标是相对于父视图的！若为UIView根layer，默认为UIView的center；若为新创建layer，默认为zero
transform 	形变参数，类似与UIView的transform(CGAffineTransform)，不过layer的transform(CATransform3D)是一个四维矩阵，可以进行三维的变化操作
mask 	mask图层，根据透明度进行裁剪，只保留非透明部分，显示底部内容
masksToBounds 	是否将layer之外的部分遮挡，若为true对阴影效果有影响，默认为false
backgroundColor 	由于QuartzCore框架和CoreGrahpics框架均是跨平台的，但UIKit只能在iOS中使用，为保证可扩展性，需使用CGColor，而不能使用UIColor
cornerRadius 	圆角
borderWidth 	描边宽度
borderColor 	描边颜色
opacity 	layer透明度，默认为1
shadowColor 	阴影颜色
shadowOpacity 	阴影透明度
shadowOffset 	阴影偏移量
shadowRadius 	阴影圆角

https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html#//apple_ref/doc/uid/TP40004514-CH11-SW2
