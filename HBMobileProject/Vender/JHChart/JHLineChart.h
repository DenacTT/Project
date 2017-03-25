//
//  JHLineChart.h
//  JHChartDemo
//
//  Created by cjatech-简豪 on 16/4/10.
//  Copyright © 2016年 JH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHChart.h"

/**
 *  Line chart type, has been abandoned
 */
typedef  NS_ENUM(NSInteger,JHLineChartType){

    JHChartLineEveryValueForEveryX=0, /*        Default         */
    JHChartLineValueNotForEveryX
};



/**
 *  Distribution type of line graph
 */
typedef NS_ENUM(NSInteger,JHLineChartQuadrantType){
    
    /**
     *  折线在第一象限
     */
    JHLineChartQuadrantTypeFirstQuardrant,
    
    /**
     *  折线在一二象限
     */
    JHLineChartQuadrantTypeFirstAndSecondQuardrant,
    
    /**
     *  折线在三四象限
     */
    JHLineChartQuadrantTypeFirstAndFouthQuardrant,
    
    /**
     *  折线在所有象限
     */
    JHLineChartQuadrantTypeAllQuardrant
    
    
};



/****************************华丽的分割线***********************************/



@interface JHLineChart :JHChart

/**
 *  X轴坐标值
 *  X axis scale data of a broken line graph, the proposed use of NSNumber or the number of strings
 */
@property (nonatomic, strong) NSArray * xLineDataArr;


/**
 *  Y axis scale data of a broken line graph, the proposed use of NSNumber or the number of strings
 */
@property (nonatomic, strong) NSArray * yLineDataArr;


/**
 *  An array of values that are about to be drawn.
 */
@property (nonatomic, strong) NSArray * valueArr;


/**
 *  The type of broken line graph has been abandoned.
 */
@property (assign , nonatomic) JHLineChartType  lineType ;


/**
 *  The quadrant of the specified line chart
 */
@property (assign, nonatomic) JHLineChartQuadrantType  lineChartQuadrantType;


/**
 *  Line width (the value of non drawn path width, only refers to the X, Y axis scale line width)
 */
@property (assign, nonatomic) CGFloat lineWidth;


/**
 *  To draw the line color of the target
 */
@property (nonatomic, strong) NSArray * valueLineColorArr;




/**
 *  Color for each value draw point
 */
@property (nonatomic, strong) NSArray * pointColorArr;


/**
 *  Y, X axis scale numerical color
 */
@property (nonatomic, strong) UIColor * xAndYNumberColor;


/**
 *  Draw dotted line color
 */
@property (nonatomic, strong) NSArray * positionLineColorArr;



/**
 *  Draw the text color of the information.
 */
@property (nonatomic, strong) NSArray * pointNumberColorArr;



/**
 *  Value path is required to draw points
 */
@property (assign,  nonatomic) BOOL hasPoint;



/**
 *  Draw path line width
 */
@property (nonatomic, assign) CGFloat animationPathWidth;


/**
 *  Drawing path is the curve, the default NO
 */
@property (nonatomic, assign) BOOL pathCurve;





/**
 *  Whether to fill the contents of the drawing path, the default NO
 */
@property (nonatomic, assign) BOOL contentFill;




/**
 *  Draw path fill color, default is grey
 */
@property (nonatomic, strong) NSArray * contentFillColorArr;




/**
 *  是否显示 Y 轴线条
 *  whether this chart shows the Y line or not.Default is YES
 */
@property (nonatomic,assign) BOOL showYLine;


/**
 *  是否显示水平方向的Y轴辅助线
 *  whether this chart shows the Y level lines or not.Default is NO
 */
@property (nonatomic,assign) BOOL showYLevelLine;

/** 
 *  是否显示导航线,即 点 到 x/y 坐标轴之间的虚线.
 *  whether this chart shows leading lines for value point or not,default is YES
 */
@property (nonatomic,assign) BOOL showValueLeadingLine;


/**
 *  坐标点上文案的字体大小
 *  fontsize of value point.Default 8.0;
 */
@property (nonatomic,assign) CGFloat valueFontSize;


/**
 *  自定义初始化方法
 *
 *  @param frame         frame
 *  @param lineChartType Abandoned
 *
 */
-(instancetype)initWithFrame:(CGRect)frame
            andLineChartType:(JHLineChartType)lineChartType;

/**
 *  动画展示路径
 */
-(void)showAnimation;

@end
