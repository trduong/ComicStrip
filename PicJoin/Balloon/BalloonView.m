//
//  BalloonView.m
//  PicJoin
//
//  Created by steve Nam on 12/26/14.
//  Copyright (c) 2014 Atmarkcafe. All rights reserved.
//

#import "BalloonView.h"
#import "AppController.h"
#import "CurveModel.h"

@implementation BalloonView

#define kEclipseSmallTranslation 3.0f
#define kHalfAngle 3.5f

- (void)awakeFromNib
{
    float bubbleWidth = 200;
    float bubbleHeight = 100;
    _endPoint = CGPointMake(_contentLabel.frame.origin.x , 200);
    _bubbleRect = CGRectMake(_contentLabel.frame.origin.x - 20, _contentLabel.frame.origin.y - 25, bubbleWidth, bubbleHeight);
    
    [self addPinView];
    [[AppController sharedInstance] hidePinBalloonNotification];
    
    UIPanGestureRecognizer *panges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panBalloonView:)];
    [self addGestureRecognizer:panges];
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressGestureRecognizer.minimumPressDuration = 0.5;
    [self addGestureRecognizer:longPressGestureRecognizer];
    
    UIPinchGestureRecognizer *pinchTopGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scaleTopImage:)];
    [self addGestureRecognizer:pinchTopGesture];
}

- (void)setBalloonText:(NSString *)text andBalloonType:(BalloonType)balloonType
{
    _balloonType = balloonType;
    
    CGRect oldLabelRect = _contentLabel.frame;
    
    CGSize contentSize = [self textSizeForText:text withMaxWidth:200 andFont:[UIFont systemFontOfSize:16.0]];
    
    CGRect labelRect = _contentLabel.frame;
    labelRect.size = contentSize;
    _contentLabel.frame = labelRect;
    
    _contentLabel.text = text;
    NSInteger numberLine = [self getNumberOfLinesInLabelOrTextView:_contentLabel];
    _contentLabel.numberOfLines = numberLine;
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    _bubbleRect.size.width += contentSize.width - oldLabelRect.size.width;
    
    if (numberLine >= 4) {
        _bubbleRect = CGRectMake(_bubbleRect.origin.x - 20, _bubbleRect.origin.y, _bubbleRect.size.width + 40, contentSize.height + 30);

        _endPoint.y = contentSize.height + 60;
    }
    
    [self setDefaultPoint];
    
    [self setNeedsDisplay];
}

- (CGSize)textSizeForText:(NSString *)text withMaxWidth:(CGFloat)maxWidth andFont:(UIFont *)font
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{ NSFontAttributeName:font,
                                  NSParagraphStyleAttributeName:paragraph };
    CGRect box = [text
                  boundingRectWithSize:CGSizeMake(maxWidth, 1000)
                  options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                  attributes:attributes context:nil];
    return box.size;
}

- (NSInteger)getNumberOfLinesInLabelOrTextView:(id)obj
{
    NSInteger lineCount = 0;
    if([obj isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)obj;
        CGSize requiredSize = [self textSizeForText:label.text withMaxWidth:label.frame.size.width andFont:label.font];
        
        int charSize = label.font.leading;
        int rHeight = requiredSize.height;
        
        lineCount = rHeight/charSize;
    }  else if ([obj isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)obj;
        lineCount = textView.contentSize.height / textView.font.leading;
    }
    
    return lineCount;
}

#pragma mark - MenuController

- (void)showPopupMenuInRect:(CGRect)rect
{
    menuController = [UIMenuController sharedMenuController];
    UIMenuItem *menuDelete = [[UIMenuItem alloc] initWithTitle:@"Delete" action:@selector(onMenuDeleteAction)];
    UIMenuItem *menuEdit = [[UIMenuItem alloc] initWithTitle:@"Edit" action:@selector(onMenuEditAction)];

    [self becomeFirstResponder];
    
    [menuController setMenuItems:[NSArray arrayWithObjects:menuDelete, menuEdit, nil]];
    [menuController setTargetRect:CGRectMake(rect.origin.x, rect.origin.y, 0, 0) inView:self];
    [menuController setMenuVisible:YES animated:NO];
}

- (void)onMenuDeleteAction
{
    [self removeFromSuperview];
}

- (void)onMenuEditAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectEditBalloonView:)]) {
        [_delegate didSelectEditBalloonView:_contentLabel.text];
    }
    
    [self removeFromSuperview];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - PinBalloon

- (void)addPinView
{
    _pinArrow = [[PinBalloonView alloc] initWithView:self];
    _pinArrow.center = _endPoint;
    _pinArrow.pinType = PinTypeArrow;
    _pinArrow.userInteractionEnabled = YES;
    [self addGestureToPin:_pinArrow];
    [self addSubview:_pinArrow];
}

#pragma mark - Gesture

- (void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    [self showPopupMenuInRect:_contentLabel.frame];
}

- (void)addGestureToPin:(PinBalloonView *)pinview
{
    UIPanGestureRecognizer *panges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panPinBalloon:)];
    [pinview addGestureRecognizer:panges];
}

- (void)panPinBalloon:(UIPanGestureRecognizer *)gestureRecognizer
{
    PinBalloonView *pin = (PinBalloonView *)[gestureRecognizer view];
    if (pin.pinType == PinTypeBubble) {
        return;
    }
    CGPoint translation = [gestureRecognizer translationInView:[pin superview]];
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        [pin setStartPoint:pin.center];
        [gestureRecognizer setTranslation:CGPointZero inView:[pin superview]];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (pin.pinType == PinTypeArrow) {
            CGPoint centerPoint = CGPointMake(CGRectGetMidX(_bubbleRect), CGRectGetMidY(_bubbleRect));
            pin.center = CGPointMake(pin.center.x+translation.x, pin.center.y+translation.y);
            [pin translateToPoint:translation];
            centerPoint = CGPointMake(CGRectGetMidX(_bubbleRect), CGRectGetMidY(_bubbleRect));
            
            _endPoint = CGPointMake(_endPoint.x+translation.x, _endPoint.y+translation.y);
        }
        [self setNeedsDisplay];
        [gestureRecognizer setTranslation:CGPointZero inView:[pin superview]];
    }
}

- (void)panBalloonView:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *anview = [gestureRecognizer view];
    CGPoint translation = [gestureRecognizer translationInView:[anview superview]];    
    if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGRect labelFrame = _contentLabel.frame;
        labelFrame.origin.x  += translation.x;
        labelFrame.origin.y += translation.y;
        [_contentLabel setFrame:labelFrame];
        
        _bubbleRect.origin.x += translation.x;
        _bubbleRect.origin.y += translation.y;
        
        [self setNeedsDisplay];

    }
    [gestureRecognizer setTranslation:CGPointZero inView:[anview superview]];
}

- (void)scaleTopImage:(UIPinchGestureRecognizer *)recognizer
{
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        _previousScale = [recognizer scale];
    }
    
    if ([recognizer state] == UIGestureRecognizerStateBegan ||
        [recognizer state] == UIGestureRecognizerStateChanged) {
        
        CGFloat currentScale = [[self.layer valueForKeyPath:@"transform.scale"] floatValue];
        const CGFloat kMinScale = (150/2)/self.frame.size.width;
        CGFloat newScale = 1 -  (_previousScale - [recognizer scale]);
        newScale = MAX(newScale, kMinScale / currentScale);
        CGAffineTransform transform = CGAffineTransformScale(self.transform, newScale, newScale);
        self.transform = transform;
        _previousScale = [recognizer scale];
        [self setNeedsDisplay];
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    UIColor *currentColor = [self colorOfPoint:point];
    BOOL transparent = [self isClearColor:currentColor];
    if (!transparent) {
        [[AppController sharedInstance] hidePinBalloonNotification];
        if (_pinArrow.removing) {
            [self addPinView];
        }
    }
    return !transparent;
}


#pragma mark - Color

- (BOOL)isClearColor:(UIColor *)color
{
    CGFloat red1, green1, alpha1, blue1;
    [color getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    
    return (red1 == 0 && green1 == 0 && blue1 == 0 && alpha1 == 0);
}

- (UIColor *)colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel,
                                                 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIColor *color = [UIColor colorWithRed:pixel[0]/255.0
                                     green:pixel[1]/255.0 blue:pixel[2]/255.0
                                     alpha:pixel[3]/255.0];
    return color;
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    [self setStyleNomalWithContext:ctx];
    switch (_balloonType) {
        case BalloonTypeNormal:
        {
            [self drawBubbleNormalInContext:ctx];
        } break;
        case BalloonTypeSquare:
        {
            [self drawBubbleSquareInContext:ctx];
        } break;
        case BalloonTypeRounded:
        {
           [self drawBubbleRoundInContext:ctx];
        } break;
        case BalloonTypeCaption:
        {
           [self drawBubbleCaptionInContext:ctx];
        } break;
        case BalloonTypePointer:
        {
            [self drawBubblePointerInContext:ctx];
        } break;
            
        default:
            break;
    }

    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{ NSFontAttributeName:_contentLabel.font,
                                  NSParagraphStyleAttributeName:paragraph };

    [_contentLabel.text drawInRect:_contentLabel.frame withAttributes:attributes];
    
    _contentLabel.hidden = YES;

}

- (void)drawBubblePointerInContext: (CGContextRef)ctx
{
    CGPoint startPoint = CGPointMake(_bubbleRect.size.width/2 + _bubbleRect.origin.x, _bubbleRect.size.height/2 + _bubbleRect.origin.y);
    // Ve mui ten
    if (CGRectContainsPoint(self.frame, _endPoint)) {
        CGPoint p1 = CGPointZero;
        CGPoint p2 = CGPointZero;
        CGFloat angle = [self angleFromPoint:_endPoint toEllipseRect:_bubbleRect];
        p1 = [self pointOnRect:_bubbleRect withAngle:angle - kHalfAngle];
        p2 = [self pointOnRect:_bubbleRect withAngle:angle + kHalfAngle];
        
        double slopy, cosy, siny;
        // Arrow size
        double length = 16.0;
        double width = 12.0;
        
        slopy = atan2((_endPoint.y - startPoint.y), (_endPoint.x - startPoint.x));
        cosy = cos(slopy);
        siny = sin(slopy);
        
        //draw a line between the 2 endpoint
        double slopy1, cosy1, siny1;
        slopy1 = atan2((_endPoint.y - p1.y), (_endPoint.x - p1.x));
        cosy1 = cos(slopy);
        siny1 = sin(slopy);
        
        
        // Now draw the bubble arrow
        // Fill
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx,
                                _endPoint.x + ( - length * cosy - ( width / 2.0 * siny )),
                                _endPoint.y + ( - length * siny + ( width / 2.0 * cosy )));
        CGContextAddLineToPoint(ctx,
                                _endPoint.x + (- length * cosy + ( width / 2.0 * siny )),
                                _endPoint.y - (width / 2.0 * cosy + length * siny ) );
        
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        CGContextMoveToPoint(ctx, _endPoint.x - length * cosy1, _endPoint.y - length * siny1 );
        CGContextAddLineToPoint(ctx, p2.x, p2.y);
        
        //paints a line along the current path
        CGContextStrokePath(ctx);
        
        //here is the tough part - actually drawing the arrows
        //a total of 6 lines drawn to make the arrow shape
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx,
                                _endPoint.x + ( - length * cosy - ( width / 2.0 * siny )),
                                _endPoint.y + ( - length * siny + ( width / 2.0 * cosy )));
        CGContextAddLineToPoint(ctx,
                                _endPoint.x + (- length * cosy + ( width / 2.0 * siny )),
                                _endPoint.y - (width / 2.0 * cosy + length * siny ) );
        CGContextClosePath(ctx);
        CGContextStrokePath(ctx);
        
    }
    
    // Draw ellipse
    // ve hinh ben trong vien
    CGContextFillRect(ctx, _bubbleRect);
    CGContextStrokeRect(ctx, _bubbleRect);
}

- (void)drawBubbleCaptionInContext: (CGContextRef) ctx
{
    // Draw ellipse
    // ve hinh ben trong vien
    CGContextFillRect(ctx, _bubbleRect);
    CGContextStrokeRect(ctx, _bubbleRect);
}

- (void)drawBubbleScreamInContext: (CGContextRef) ctx
{
    // Ve mui ten
    if (CGRectContainsPoint(self.frame, _endPoint)) {
        CGPoint p1 = CGPointZero;
        CGPoint p2 = CGPointZero;
        CGPoint p1Trans = CGPointZero;
        CGPoint p2Trans = CGPointZero;
        CGRect bubbleRectTrans = CGRectMake(_bubbleRect.origin.x + kEclipseSmallTranslation, _bubbleRect.origin.y + kEclipseSmallTranslation, _bubbleRect.size.width - 2*kEclipseSmallTranslation, _bubbleRect.size.height - 2*kEclipseSmallTranslation);
        CGPoint p3 = CGPointZero;
        CGFloat angle = [self angleFromPoint:_endPoint toEllipseRect:_bubbleRect];
        p1 = [self pointOnEllipseRect:_bubbleRect withAngle:angle - kHalfAngle];
        p2 = [self pointOnEllipseRect:_bubbleRect withAngle:angle + kHalfAngle];
        
        p1Trans = [self pointOnEllipseRect:bubbleRectTrans withAngle:angle - kHalfAngle];
        p2Trans = [self pointOnEllipseRect:bubbleRectTrans withAngle:angle + kHalfAngle];
        
        CGFloat p3Y = (_endPoint.y < MIN(p1.y, p2.y))?(MAX(p1.y, p2.y)+10.0f):(MIN(p1.y, p2.y)-10.0f);
        
        p3 = CGPointMake((p1.x+p2.x)/2.0f, p3Y);
        
        // Now draw the bubble arrow
        // Fill
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p1Trans.x, p1Trans.y);
        CGContextAddLineToPoint(ctx, p2Trans.x, p2Trans.y);
        CGContextMoveToPoint(ctx, p1Trans.x, p1Trans.y);
        CGContextAddLineToPoint(ctx, p2Trans.x, p2Trans.y);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        // Stroke
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p1.x, p1.y);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p2.x, p2.y);
        CGContextStrokePath(ctx);
    }
    
    // do rong cuar vien
    CGContextMoveToPoint(ctx, ((CurveModel *)[_defaultPoints objectAtIndex:0]).p1.x, ((CurveModel *)[_defaultPoints objectAtIndex:0]).p1.y);
    for (CurveModel *curve in _defaultPoints) {
        CGContextAddLineToPoint(ctx, curve.p3.x, curve.p3.y);
        CGContextAddLineToPoint(ctx, curve.p2.x, curve.p2.y);
    }
    
    
    CGContextClosePath(ctx);
    // Fill & stroke the path
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

- (void)drawBubbleRoundInContext: (CGContextRef) ctx
{
    // As a bonus, we'll combine arcs to create a round rectangle!
    
    // Drawing with a white stroke color
    //    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1.0);
    
    // If you were making this as a routine, you would probably accept a rectangle
    // that defines its bounds, and a radius reflecting the "rounded-ness" of the rectangle.
    CGFloat radius = 10.0;
    // NOTE: At this point you may want to verify that your radius is no more than half
    // the width and height of your rectangle, as this technique degenerates for those cases.
    
    // In order to draw a rounded rectangle, we will take advantage of the fact that
    // CGContextAddArcToPoint will draw straight lines past the start and end of the arc
    // in order to create the path from the current position and the destination position.
    
    // In order to create the 4 arcs correctly, we need to know the min, mid and max positions
    // on the x and y lengths of the given rectangle.
    CGFloat minx = CGRectGetMinX(_bubbleRect), midx = CGRectGetMidX(_bubbleRect), maxx = CGRectGetMaxX(_bubbleRect);
    CGFloat miny = CGRectGetMinY(_bubbleRect), midy = CGRectGetMidY(_bubbleRect), maxy = CGRectGetMaxY(_bubbleRect);
    
    // Next, we will go around the rectangle in the order given by the figure below.
    //       minx    midx    maxx
    // miny    2       3       4
    // midy   1 9              5
    // maxy    8       7       6
    // Which gives us a coincident start and end point, which is incidental to this technique, but still doesn't
    // form a closed path, so we still need to close the path to connect the ends correctly.
    // Thus we start by moving to point 1, then adding arcs through each pair of points that follows.
    // You could use a similar tecgnique to create any shape with rounded corners.
    
    // Start at 1
    CGContextMoveToPoint(ctx, minx, midy);
    // Add an arc through 2 to 3
    CGContextAddArcToPoint(ctx, minx, miny, midx, miny, radius);
    // Add an arc through 4 to 5
    CGContextAddArcToPoint(ctx, maxx, miny, maxx, midy, radius);
    // Add an arc through 6 to 7
    CGContextAddArcToPoint(ctx, maxx, maxy, midx, maxy, radius);
    // Add an arc through 8 to 9
    CGContextAddArcToPoint(ctx, minx, maxy, minx, midy, radius);
    // Close the path
    CGContextClosePath(ctx);
    // Fill & stroke the path
    CGContextDrawPath(ctx, kCGPathFillStroke);
    //    CGContextFillRect(ctx, _bubbleRect);
    // Ve mui ten
    if (CGRectContainsPoint(self.frame, _endPoint)) {
        CGPoint p1 = CGPointZero;
        CGPoint p2 = CGPointZero;
        CGPoint p1Trans = CGPointZero;
        CGPoint p2Trans = CGPointZero;
        CGRect bubbleRectTrans = CGRectMake(_bubbleRect.origin.x + kEclipseSmallTranslation, _bubbleRect.origin.y + kEclipseSmallTranslation, _bubbleRect.size.width - 2*kEclipseSmallTranslation, _bubbleRect.size.height - 2*kEclipseSmallTranslation);
        CGPoint p3 = CGPointZero;
        CGFloat angle = [self angleFromPoint:_endPoint toEllipseRect:_bubbleRect];
        p1 = [self pointOnRect:_bubbleRect withAngle:angle - kHalfAngle];
        p2 = [self pointOnRect:_bubbleRect withAngle:angle + kHalfAngle];
        
        p1Trans = [self pointOnRect:bubbleRectTrans withAngle:angle - kHalfAngle];
        p2Trans = [self pointOnRect:bubbleRectTrans withAngle:angle + kHalfAngle];
        
        CGFloat p3Y = (_endPoint.y < MIN(p1.y, p2.y))?(MAX(p1.y, p2.y)+10.0f):(MIN(p1.y, p2.y)-10.0f);
        
        p3 = CGPointMake((p1.x+p2.x)/2.0f, p3Y);
        
        // Now draw the bubble arrow
        // Fill
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p1Trans.x, p1Trans.y);
        CGContextAddLineToPoint(ctx, p2Trans.x, p2Trans.y);
        CGContextMoveToPoint(ctx, p1Trans.x, p1Trans.y);
        CGContextAddLineToPoint(ctx, p2Trans.x, p2Trans.y);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        // Stroke
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p1.x, p1.y);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p2.x, p2.y);
        CGContextStrokePath(ctx);
    }
}

- (void)drawBubbleThoughtInContext: (CGContextRef)ctx
{
    // Ve mui ten
    if (CGRectContainsPoint(self.frame, _endPoint)) {
        float defaultDistance = 30;
        CGPoint centerPoint = CGPointMake(CGRectGetMidX(_bubbleRect), CGRectGetMidY(_bubbleRect));
        float dfW = 10;
        float dfH = 10;
        CGRect currentRect = CGRectMake(_endPoint.x, _endPoint.y, dfW, dfH);
        CGContextFillEllipseInRect(ctx, currentRect);
        CGContextStrokeEllipseInRect(ctx, currentRect);
        float distance = [self distanceBetween:centerPoint and:_endPoint];
        CGPoint tempPoint = _endPoint;
        int numberCircle = (int)distance/defaultDistance;
        double slopy, siny,cosy;
        slopy = atan2((centerPoint.x - _endPoint.x),(centerPoint.y - _endPoint.y));
        siny = sin(slopy);
        cosy = cos(slopy);
        for (int i = 0; i < numberCircle; i++) {
            CGPoint p3 = CGPointMake(tempPoint.x + defaultDistance*siny, tempPoint.y + defaultDistance*cosy);
            tempPoint = p3;
            currentRect = CGRectMake(p3.x, p3.y, dfW + i*2, dfH + i*2);
            CGContextFillEllipseInRect(ctx, currentRect);
            CGContextStrokeEllipseInRect(ctx, currentRect);
        }
    }
    
    // do rong cuar vien
    CGContextMoveToPoint(ctx, CGRectGetMinX(_bubbleRect), CGRectGetMidY(_bubbleRect));
    CGPoint startPoint = ((CurveModel *) [_defaultPoints objectAtIndex:0]).p1;
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    for (CurveModel *curve in _defaultPoints) {
        CGContextAddCurveToPoint(ctx, curve.p1.x, curve.p1.y, curve.p3.x, curve.p3.y, curve.p2.x, curve.p2.y);
    }
    
    CGContextClosePath(ctx);
    // Fill & stroke the path
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

- (void)addCurveDictWithP1X:(float)p1x P1Y:(float)p1y P2X:(float)p2x P2Y:(float)p2y P3X:(float)p3x P3Y:(float)p3y
{
    CurveModel *curve = [[CurveModel alloc] init];
    curve.p1 = CGPointMake(p1x, p1y);
    curve.p2 = CGPointMake(p2x, p2y);
    curve.p3 = CGPointMake(p3x, p3y);
    [_defaultPoints addObject:curve];
}

- (void)setDefaultPoint
{
    _defaultPoints = [[NSMutableArray alloc] init];
    [self addCurveDictWithP1X:60 P1Y:140 P2X:100 P2Y:100 P3X:35 P3Y:70];
    [self addCurveDictWithP1X:100 P1Y:100 P2X:130 P2Y:110 P3X:125 P3Y:70];
    [self addCurveDictWithP1X:130 P1Y:110 P2X:180 P2Y:140 P3X:180 P3Y:80];
    [self addCurveDictWithP1X:180 P1Y:140 P2X:160 P2Y:190 P3X:250 P3Y:170];
    [self addCurveDictWithP1X:160 P1Y:190 P2X:100 P2Y:210 P3X:180 P3Y:280];
    [self addCurveDictWithP1X:100 P1Y:210 P2X:60 P2Y:180 P3X:30 P3Y:270];
    [self addCurveDictWithP1X:60 P1Y:180 P2X:60 P2Y:140 P3X:0 P3Y:160];
}

- (void)drawBubbleSquareInContext: (CGContextRef) ctx
{
    // Draw ellipse
    // ve hinh ben trong vien
    CGContextFillRect(ctx, _bubbleRect);
    CGContextStrokeRect(ctx, _bubbleRect);
    
    // Ve mui ten
    if (CGRectContainsPoint(self.frame, _endPoint)) {
        CGPoint p1 = CGPointZero;
        CGPoint p2 = CGPointZero;
        CGPoint p1Trans = CGPointZero;
        CGPoint p2Trans = CGPointZero;
        CGRect bubbleRectTrans = CGRectMake(_bubbleRect.origin.x + kEclipseSmallTranslation, _bubbleRect.origin.y + kEclipseSmallTranslation, _bubbleRect.size.width - 2*kEclipseSmallTranslation, _bubbleRect.size.height - 2*kEclipseSmallTranslation);
        CGPoint p3 = CGPointZero;
        CGFloat angle = [self angleFromPoint:_endPoint toEllipseRect:_bubbleRect];
        p1 = [self pointOnRect:_bubbleRect withAngle:angle - kHalfAngle];
        p2 = [self pointOnRect:_bubbleRect withAngle:angle + kHalfAngle];
        
        p1Trans = [self pointOnRect:bubbleRectTrans withAngle:angle - kHalfAngle];
        p2Trans = [self pointOnRect:bubbleRectTrans withAngle:angle + kHalfAngle];
        
        CGFloat p3Y = (_endPoint.y < MIN(p1.y, p2.y))?(MAX(p1.y, p2.y)+10.0f):(MIN(p1.y, p2.y)-10.0f);
        
        p3 = CGPointMake((p1.x+p2.x)/2.0f, p3Y);
        
        // Now draw the bubble arrow
        // Fill
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p1Trans.x, p1Trans.y);
        CGContextAddLineToPoint(ctx, p2Trans.x, p2Trans.y);
        CGContextMoveToPoint(ctx, p1Trans.x, p1Trans.y);
        CGContextAddLineToPoint(ctx, p2Trans.x, p2Trans.y);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        // Stroke
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p1.x, p1.y);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p2.x, p2.y);
        CGContextStrokePath(ctx);
    }
    
}

- (void)setStyleNomalWithContext:(CGContextRef)ctx
{
    // Setup drawing values
    // mau ben trong
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    // mau ben ngoai
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    // do rong cuar vien
    CGContextSetLineWidth(ctx, 2.0f);
}

- (void)drawBubbleNormalInContext:(CGContextRef)ctx
{
    // Draw ellipse
    // ve hinh ben trong vien
    CGContextFillEllipseInRect(ctx, _bubbleRect);
    CGContextStrokeEllipseInRect(ctx, _bubbleRect);
    //    NSLog(@"Bubble Rect: %@", NSStringFromCGRect(_bubbleRect));
    
    if ([self checkEndPointInEclipse]) {
        CGPoint p1 = CGPointZero;
        CGPoint p2 = CGPointZero;
        CGPoint p1Trans = CGPointZero;
        CGPoint p2Trans = CGPointZero;
        CGRect bubbleRectTrans = CGRectMake(_bubbleRect.origin.x + kEclipseSmallTranslation, _bubbleRect.origin.y + kEclipseSmallTranslation, _bubbleRect.size.width - 2*kEclipseSmallTranslation, _bubbleRect.size.height - 2*kEclipseSmallTranslation);
        CGPoint p3 = CGPointZero;
        CGFloat angle = [self angleFromPoint:_endPoint toEllipseRect:_bubbleRect];
        p1 = [self pointOnEllipseRect:_bubbleRect withAngle:angle - kHalfAngle];
        p2 = [self pointOnEllipseRect:_bubbleRect withAngle:angle + kHalfAngle];
        
        p1Trans = [self pointOnEllipseRect:bubbleRectTrans withAngle:angle - kHalfAngle];
        p2Trans = [self pointOnEllipseRect:bubbleRectTrans withAngle:angle + kHalfAngle];
        
        CGFloat p3Y = (_endPoint.y < MIN(p1.y, p2.y))?(MAX(p1.y, p2.y)+10.0f):(MIN(p1.y, p2.y)-10.0f);
        
        p3 = CGPointMake((p1.x+p2.x)/2.0f, p3Y);
        
        // Now draw the bubble arrow
        // Fill
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p1Trans.x, p1Trans.y);
        CGContextAddLineToPoint(ctx, p2Trans.x, p2Trans.y);
        CGContextMoveToPoint(ctx, p1Trans.x, p1Trans.y);
        CGContextAddLineToPoint(ctx, p2Trans.x, p2Trans.y);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
        
        // Stroke
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p1.x, p1.y);
        CGContextMoveToPoint(ctx, _endPoint.x, _endPoint.y);
        CGContextAddLineToPoint(ctx, p2.x, p2.y);
        CGContextStrokePath(ctx);
    }
}

-(CGPoint)pointOnRect: (CGRect) rect withAngle: (CGFloat)angle {
    angle = fmodf(angle * M_PI / 180, 2 * M_PI);
    if (angle < 0)
        angle += (CGFloat)(2 * M_PI);
    CGFloat xRadius = rect.size.width / 2;
    CGFloat yRadius = rect.size.height / 2;
    CGPoint pointRelativeToCenter;
    CGFloat tangent = tanf(angle);
    CGFloat y = xRadius * tangent;
    if (fabsf(y) <= yRadius) {
        // The line intersects the left and right edges before it intersects
        // the top and bottom edges.
        if (angle < (CGFloat)M_PI_2 || angle > (CGFloat)(M_PI + M_PI_2)) {
            // The ray at angle `radians` intersects the right edge.
            pointRelativeToCenter = CGPointMake(xRadius, y);
        } else {
            // The ray intersects the left edge.
            pointRelativeToCenter = CGPointMake(-xRadius, -y);
        }
    } else {
        // The line intersects the top and bottom edges before it intersects
        // the left and right edges.
        CGFloat x = yRadius / tangent;
        if (angle < (CGFloat)M_PI) {
            // The ray at angle `radians` intersects the bottom edge.
            pointRelativeToCenter = CGPointMake(x, yRadius);
        } else {
            // The ray intersects the top edge.
            pointRelativeToCenter = CGPointMake(-x, -yRadius);
        }
    }
    
    return CGPointMake(pointRelativeToCenter.x + CGRectGetMidX(rect),
                       pointRelativeToCenter.y + CGRectGetMidY(rect));
}

- (BOOL)checkEndPointInEclipse
{
    CGPoint center = CGPointMake(_bubbleRect.origin.x+_bubbleRect.size.width/2, _bubbleRect.origin.y+_bubbleRect.size.height/2);
    CGPoint tempPoint = [self pointOnEllipseRect:_bubbleRect withAngle:[self angleFromPoint:_endPoint toEllipseRect:_bubbleRect]];
    if ([self distanceBetween:tempPoint and:center] > [self distanceBetween:_endPoint and:center]) {
        return NO;
    }
    return YES;
}

- (float)distanceBetween:(CGPoint)p1 and:(CGPoint)p2
{
    return sqrt(pow(p2.x-p1.x,2)+pow(p2.y-p1.y,2));
}

- (CGPoint)pointOnEllipseRect:(CGRect)ellipseRect withAngle:(CGFloat)angle
{
    // Get the center of the ellipse
    CGPoint center = CGPointMake(ellipseRect.origin.x+ellipseRect.size.width/2, ellipseRect.origin.y+ellipseRect.size.height/2);
    
    // Convert angle to radians
    float angleRadians = DegreesToRadians(angle);
    
    // Calculate a, b
    float a = ellipseRect.size.width/2;
    float b = ellipseRect.size.height/2;
    
    // x = a cos t
    // y = b sin t
    float x = center.x + a * cosf(angleRadians);
    float y = center.y + b * sinf(angleRadians);
    
    // Create point
    CGPoint point = CGPointMake(x, y);
    
    return point;
}

- (CGFloat)angleFromPoint:(CGPoint)point toEllipseRect:(CGRect)ellipseRect
{
    CGPoint center = CGPointMake(ellipseRect.origin.x+ellipseRect.size.width/2, ellipseRect.origin.y+ellipseRect.size.height/2);
    CGPoint originPoint = CGPointMake(point.x - center.x, point.y - center.y); // get origin point to origin by subtracting end from start
    float bearingRadians = atan2f(originPoint.y, originPoint.x); // get bearing in radians
    float bearingDegrees = bearingRadians * (180.0 / M_PI); // convert to degrees
    bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)); // correct discontinuity
    return bearingDegrees;
}

CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
};

CGFloat RadiansToDegrees(CGFloat radians)
{
    return radians * 180 / M_PI;
};

@end
