#include <string>
using namespace std;

int len(string str) {
return str.size();
}


#include <stdio.h>
#include "CiberAV.h"

void stop(){
	motors(0,0);
	apply(1);
}

double var1;
double var2;
bool var3;
bool var4;
bool var5;
double var6;
bool var7;
double var8;
bool var9;
bool var10;
double var11;
bool var12;
bool var13;
void topReserved_(){
    var6 = 1;
    var9 = true;
    double var17 = groundType();
    bool var16 = var17 == var6;
    var5 = var16;
    double var19 = startAngle();
    double var21 = 10;
    double var20 = -var21;
    double var22 = 10;
    bool var18 = var19 > var20 && var19 < var22;
    var7 = var18;
    double var24 = startDistance();
    double var25 = 50;
    bool var23 = var24 < var25;
    var12 = var23;
    double var27 = obstacleDistance(var6);
    double var29 = 5;
    double var28 = -var29;
    bool var26 = var27 < var28;
    var4 = var26;
    double var31 = obstacleDistance(var6);
    double var32 = 5;
    bool var30 = var31 > var32;
    var10 = var30;
    double var34 = startAngle();
    double var36 = 5;
    double var35 = -var36;
    bool var33 = var34 < var35;
    var13 = var33;
    double var38 = startAngle();
    double var39 = 5;
    bool var37 = var38 > var39;
    var3 = var37;
}
void b1(){
    var9 = true;
    while(!var9){
        apply(1);
        double var42 = 60;
        double var41 = -var42;
        double var43 = 60;
        motors(var41,var43);
        var9 = true;
    }
}
void b2(){
    double var46 = groundType();
    bool var45 = var46 == var6;
    var5 = var45;
    while(!var5){
        apply(1);
        double var47 = obstacleDistance(var1);
        double var48 = var47;
        double var49 = obstacleDistance(var8);
        double var50 = var49;
        double var51 = obstacleDistance(var11);
        double var52 = var51;
        double var53 = obstacleDistance(var6);
        double var54 = var53;
        string var55;
        var55 = var55 + to_string("distances: ");
        var55 = var55 + to_string(var48);
        var55 = var55 + to_string(", ");
        var55 = var55 + to_string(var50);
        var55 = var55 + to_string(", ");
        var55 = var55 + to_string(var52);
        var55 = var55 + to_string("; angle: ");
        var55 = var55 + to_string(var54);
        printStr(&var55[0u]);
        double var57 = 80;
        bool var56 = var48 < var57;
        double var67 = 80;
        bool var66 = var50 < var67;
        double var71 = 80;
        bool var70 = var52 < var71;
        double var75 = obstacleDistance(var6);
        double var77 = 5;
        double var76 = -var77;
        bool var74 = var75 < var76;
        var4 = var74;
        double var81 = obstacleDistance(var6);
        double var82 = 5;
        bool var80 = var81 > var82;
        var10 = var80;
        if (var56) {
            double var59 = 80;
            bool var58 = var50 < var59;
            if (var58) {
                double var60 = 50;
                double var62 = 50;
                double var61 = -var62;
                motors(var60,var61);
            }
            else {
                double var64 = 50;
                double var63 = -var64;
                double var65 = 50;
                motors(var63,var65);
            }
        }
        else if (var66) {
            double var68 = 80;
            double var69 = 40;
            motors(var68,var69);
        }
        else if (var70) {
            double var72 = 40;
            double var73 = 80;
            motors(var72,var73);
        }
        else if (var4) {
            double var78 = 80;
            double var79 = 40;
            motors(var78,var79);
        }
        else if (var10) {
            double var83 = 40;
            double var84 = 80;
            motors(var83,var84);
        }
        else {
            double var85 = 80;
            double var86 = 80;
            motors(var85,var86);
        }
        double var88 = groundType();
        bool var87 = var88 == var6;
        var5 = var87;
    }
}
void b3(){
    double var90 = startDistance();
    double var91 = 50;
    bool var89 = var90 < var91;
    var12 = var89;
    while(!var12){
        apply(1);
        double var92 = obstacleDistance(var1);
        double var93 = var92;
        double var94 = obstacleDistance(var8);
        double var95 = var94;
        double var96 = obstacleDistance(var11);
        double var97 = var96;
        string var98;
        var98 = var98 + to_string("distances: ");
        var98 = var98 + to_string(var93);
        var98 = var98 + to_string(", ");
        var98 = var98 + to_string(var95);
        var98 = var98 + to_string(", ");
        var98 = var98 + to_string(var97);
        printStr(&var98[0u]);
        double var100 = 80;
        bool var99 = var93 < var100;
        double var110 = 80;
        bool var109 = var95 < var110;
        double var114 = 80;
        bool var113 = var97 < var114;
        double var118 = startAngle();
        double var120 = 5;
        double var119 = -var120;
        bool var117 = var118 < var119;
        var13 = var117;
        double var124 = startAngle();
        double var125 = 5;
        bool var123 = var124 > var125;
        var3 = var123;
        if (var99) {
            double var102 = 80;
            bool var101 = var95 < var102;
            if (var101) {
                double var103 = 50;
                double var105 = 50;
                double var104 = -var105;
                motors(var103,var104);
            }
            else {
                double var107 = 50;
                double var106 = -var107;
                double var108 = 50;
                motors(var106,var108);
            }
        }
        else if (var109) {
            double var111 = 80;
            double var112 = 40;
            motors(var111,var112);
        }
        else if (var113) {
            double var115 = 40;
            double var116 = 80;
            motors(var115,var116);
        }
        else if (var13) {
            double var121 = 80;
            double var122 = 40;
            motors(var121,var122);
        }
        else if (var3) {
            double var126 = 40;
            double var127 = 80;
            motors(var126,var127);
        }
        else {
            double var128 = 80;
            double var129 = 80;
            motors(var128,var129);
        }
        double var131 = startDistance();
        double var132 = 50;
        bool var130 = var131 < var132;
        var12 = var130;
    }
}
int main(){
    topReserved_();
    string var133 = "Grimmy Bear";
    double var134 = 0;
    init(&var133[0u],var134);
    string var135 = "Going to beacon 1";
    printStr(&var135[0u]);
    var6 = 1;
    b2();
    stop();
    string var137 = "Signaling arrival to target 1";
    printStr(&var137[0u]);
    pickup();
    string var138 = "Signaling returning to start spot";
    printStr(&var138[0u]);
    returning();
    string var139 = "Going to start spot";
    printStr(&var139[0u]);
    b3();
    stop();
    string var140 = "Signaling end of trial";
    printStr(&var140[0u]);
    finish();
    string var141 = "Bye!";
    printStr(&var141[0u]);
    return 0;
}