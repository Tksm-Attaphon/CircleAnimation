# CircleAnimation

เอนิเมชั่นคล้าย joox หน้าเล่นเพลง

setup 
- set index
- set image array
- call setAnimation method for animate rotatation 360
- call nextImage or prevImage for change image

delegate

- (void)nextCircleAnimationFinished;
- (void)prevCircleAnimationFinished;

Example

    circle = [[CircleAnimationView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)]; 
    [circle setIndex:3];
    circle.delegate = self;
    circle.imageArray = imageArray;
    [circle setBackgroundColor:[UIColor clearColor]];
    [circle setCenter:self.view.center];
    [circle setAnimation];
    [self.view addSubview:circle];
