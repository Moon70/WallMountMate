Overlap=0.05;
$fn=50;

design=1;

brackethickness=0.28*4;

bracketWidth=16;

wallBracketHoleDistance=100;
wallBracketGrooveLength=10;
wallBracketHeight=30;
wallLargeHoleDiameter=7;
wallSmallHoleDiameter=3;

deviceBracketHoleDistance=155;
deviceBracketPegBaseDiameter=4;
deviceBracketPegHeadDiameter=7;
deviceBracketPegLength=3;
deviceBracketPegHeadLength=1;
deviceBracketPegConeLength=1;

bracket();

module bracket(){
    addHoles(){
        bracketBase();
    }
}

module bracketBase(bracketLength=wallBracketHoleDistance<deviceBracketHoleDistance?deviceBracketHoleDistance:wallBracketHoleDistance){
    translate([0,design==1?0:wallBracketHeight,0])
    union(){
        cube([bracketLength,bracketWidth,brackethickness],center=true);

        translate([-bracketLength/2,0,0])
        cylinder(d=bracketWidth, h=brackethickness, center=true);

        translate([bracketLength/2,0,0])
        cylinder(d=bracketWidth, h=brackethickness, center=true);
    }

    translate([-wallBracketHoleDistance/2,wallBracketHeight-wallBracketGrooveLength,0])
    cylinder(d=wallLargeHoleDiameter+8, h=brackethickness, center=true);

    translate([wallBracketHoleDistance/2,wallBracketHeight-wallBracketGrooveLength,0])
    cylinder(d=wallLargeHoleDiameter+8, h=brackethickness, center=true);

    translate([design==1?-wallBracketHoleDistance/2:-deviceBracketHoleDistance/2,wallBracketHeight,0])
    wallBracket();
    translate([design==1?wallBracketHoleDistance/2:deviceBracketHoleDistance/2,wallBracketHeight,0])
    wallBracket();

    translate([-deviceBracketHoleDistance/2,0,0])
    deviceHolderPeg();

    translate([deviceBracketHoleDistance/2,0,0])
    deviceHolderPeg();
}

module wallBracket(){
    cylinder(d=bracketWidth, h=brackethickness, center=true);
    translate([0,-wallBracketHeight/2,0])
    cube([bracketWidth,wallBracketHeight,brackethickness],center=true);
}

module deviceHolderPeg(){
    cylinder(d=bracketWidth, h=brackethickness, center=true);

    color("orange")
    {
        translate([0,0,deviceBracketPegLength/2+brackethickness/2])
        cylinder(d=deviceBracketPegBaseDiameter, h=deviceBracketPegLength, center=true);

        translate([0,0,deviceBracketPegLength+brackethickness/2+deviceBracketPegConeLength/2])
        cylinder(d1=deviceBracketPegBaseDiameter,d2=deviceBracketPegHeadDiameter, h=deviceBracketPegConeLength, center=true);

        translate([0,0,deviceBracketPegLength+brackethickness/2+deviceBracketPegConeLength+deviceBracketPegHeadLength/2])
        cylinder(d=deviceBracketPegHeadDiameter, h=deviceBracketPegHeadLength, center=true);
    }
}

module addHoles(){
    difference(){
        children();
        union(){
            translate([-wallBracketHoleDistance/2,wallBracketHeight,0])
            wallHole();
            translate([wallBracketHoleDistance/2,wallBracketHeight,0])
            wallHole();
        }
    }
}

module wallHole(){
    cylinder(d=wallSmallHoleDiameter, h=brackethickness*2, center=true);

    translate([0,-wallBracketGrooveLength,0])
    cylinder(d=wallLargeHoleDiameter, h=brackethickness*2, center=true);

    translate([0,-wallBracketGrooveLength/2,0])
    cube([wallSmallHoleDiameter,wallBracketGrooveLength,brackethickness*2],center=true);
}
