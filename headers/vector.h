#if !defined(VECTOR)
#define VECTOR

#include <exec/types.h>

#define SINSIZE (720)

int sin_05[SINSIZE] =
    {
        0, 9, 17, 26, 35, 44, 52, 61, 70, 78, 87, 96, 105, 113, 122, 131, 139, 148, 156, 165,
        174, 182, 191, 199, 208, 216, 225, 233, 242, 250, 259, 267, 276, 284, 292, 301, 309, 317, 326, 334,
        342, 350, 358, 367, 375, 383, 391, 399, 407, 415, 423, 431, 438, 446, 454, 462, 469, 477, 485, 492,
        500, 508, 515, 522, 530, 537, 545, 552, 559, 566, 574, 581, 588, 595, 602, 609, 616, 623, 629, 636,
        643, 649, 656, 663, 669, 676, 682, 688, 695, 701, 707, 713, 719, 725, 731, 737, 743, 749, 755, 760,
        772, 777, 783, 788, 793, 799, 804, 809, 814, 819, 824, 829, 834, 839, 843, 848, 853, 857, 862, 866,
        870, 875, 879, 883, 887, 891, 895, 899, 903, 906, 910, 914, 917, 921, 924, 927, 930, 934, 937, 940,
        943, 946, 948, 951, 954, 956, 959, 961, 964, 966, 968, 970, 972, 974, 976, 978, 980, 982, 983, 985,
        986, 988, 989, 990, 991, 993, 994, 995, 995, 996, 997, 998, 998, 999, 999, 999, 1000, 1000, 1000, 1000,
        1000, 1000, 1000, 999, 999, 999, 998, 998, 997, 996, 995, 995, 994, 993, 991, 990, 989, 988, 986, 985,
        983, 982, 980, 978, 976, 974, 972, 970, 968, 966, 964, 961, 959, 956, 954, 951, 948, 946, 943, 940,
        937, 934, 930, 927, 924, 921, 917, 914, 910, 906, 903, 899, 895, 891, 887, 883, 879, 875, 870, 866,
        862, 857, 853, 848, 843, 839, 834, 829, 824, 819, 814, 809, 804, 799, 793, 788, 783, 777, 772, 766,
        760, 755, 749, 743, 737, 731, 725, 719, 713, 707, 701, 695, 688, 682, 676, 669, 663, 656, 649, 643,
        636, 629, 623, 616, 609, 602, 595, 588, 581, 574, 566, 559, 552, 545, 537, 530, 522, 515, 508, 500,
        492, 485, 477, 469, 462, 454, 446, 438, 431, 423, 415, 407, 399, 391, 383, 375, 367, 358, 350, 342,
        334, 326, 317, 309, 301, 292, 284, 276, 267, 259, 250, 242, 233, 225, 216, 208, 199, 191, 182, 174,
        165, 156, 148, 139, 131, 122, 113, 105, 96, 87, 78, 70, 61, 52, 44, 35, 26, 17, 9, 0,
        -9, -017, -026, -035, -044, -052, -061, -070, -78, -87, -96, -105, -113, -122, -131, -139, -148, -156, -165, -174,
        -182, -191, -199, -208, -216, -225, -233, -242, -250, -259, -267, -276, -284, -292, -301, -309, -317, -326, -334, -342,
        -350, -358, -367, -375, -383, -391, -399, -407, -415, -423, -431, -438, -446, -454, -462, -469, -477, -485, -492, -500,
        -508, -515, -522, -530, -537, -545, -552, -559, -566, -574, -581, -588, -595, -602, -609, -616, -623, -629, -636, -643,
        -649, -656, -663, -669, -676, -682, -688, -695, -701, -707, -713, -719, -725, -731, -737, -743, -749, -755, -760, -766,
        -772, -777, -783, -788, -793, -799, -804, -809, -814, -819, -824, -829, -834, -839, -843, -848, -853, -857, -862, -866,
        -870, -875, -879, -883, -887, -891, -895, -899, -903, -906, -910, -914, -917, -921, -924, -927, -930, -934, -937, -940,
        -943, -946, -948, -951, -954, -956, -959, -961, -964, -966, -968, -970, -972, -974, -976, -978, -980, -982, -983, -985,
        -986, -988, -989, -990, -991, -993, -994, -995, -995, -996, -997, -998, -998, -999, -999, -999, -1000, -1000, -1000, -1000,
        -1000, -1000, -1000, -999, -999, -999, -998, -998, -997, -996, -995, -995, -994, -993, -991, -990, -989, -988, -986, -985,
        -983, -982, -980, -978, -976, -974, -972, -970, -968, -966, -964, -961, -959, -956, -954, -951, -948, -946, -943, -940,
        -937, -934, -930, -927, -924, -921, -917, -914, -910, -906, -903, -899, -895, -891, -887, -883, -879, -875, -870, -866,
        -862, -857, -853, -848, -843, -839, -834, -829, -824, -819, -814, -809, -804, -799, -793, -788, -783, -777, -772, -766,
        -760, -755, -749, -743, -737, -731, -725, -719, -713, -707, -701, -695, -688, -682, -676, -669, -663, -656, -649, -643,
        -636, -629, -623, -616, -609, -602, -595, -588, -581, -574, -566, -559, -552, -545, -537, -530, -522, -515, -508, -500,
        -492, -485, -477, -469, -462, -454, -446, -438, -431, -423, -415, -407, -399, -391, -383, -375, -367, -358, -350, -342,
        -334, -326, -317, -309, -301, -292, -284, -276, -267, -259, -250, -242, -233, -225, -216, -208, -199, -191, -182, -174,
        -165, -156, -148, -139, -131, -122, -113, -105, -96, -87, -78, -070, -061, -052, -044, -035, -026, -17, -9, 0};

int cos_05[720];

struct _point2D
{
    int X;
    int Y;
};
typedef struct _point2D Point2D;
typedef struct _point2D Vector2D;

Vector2D Vect2DGetVector(Point2D va, Point2D vb)
{
    Vector2D vr;

    vr.X = vb.X - va.X;
    vr.Y = vb.Y - va.Y;

    return vr;
}
Vector2D Vect2DAdd(Vector2D va, Vector2D vb)
{
    Vector2D vr;
    vr.X = va.X + vb.X;
    vr.Y = va.Y + vb.Y;
    return vr;
}
Vector2D Vect2DSub(Vector2D va, Vector2D vb)
{
    Vector2D vr;
    vr.X = va.X - vb.X;
    vr.Y = va.Y - vb.Y;
    return vr;
}
Vector2D Vect2DMul(Vector2D va, int scalar)
{
    Vector2D vr;
    vr.X = va.X * scalar;
    vr.Y = va.Y * scalar;
    return vr;
}
int Vect2DSkal(Vector2D va, Vector2D vb)
{
    return va.X * vb.X + va.Y * vb.Y;
}
Vector2D Vector2DVec(Vector2D va, Vector2D vb)
{
    Vector2D vr;

    return vr;
}
Point2D Point2DTrans(Point2D pa, Point2D m)
{
    Point2D pr;
    
    pr.X = pa.X +m.X;
    pr.Y = pa.Y +m.Y;
    
    return pr;
}
void Points2DTrans(Point2D *pointsA, Point2D *pointsB, USHORT length, Point2D m)
{
    for (int i = 0; i < length; i++)
    {
        pointsB[i] = Point2DTrans(pointsA[i], m);
    }
}
Point2D Point2DScale(Point2D pa, Point2D fixpoint, int mx, int my)
{
    Point2D pr;

    pr.X = pa.X - fixpoint.X;
    pr.Y = pa.Y - fixpoint.Y;
    pr.X *= mx;
    pr.Y *= my;
    pr.X += fixpoint.X;
    pr.Y += fixpoint.Y;

    return pr;
}
void Points2DScale(Point2D *pointsA, Point2D *pointsB, USHORT length, Point2D origin, int mx, int my)
{
    for (int i = 0; i < length; i++)
    {
        pointsB[i] = Point2DScale(pointsA[i], origin, mx, my);
    }
}
Point2D Point2DRotate(Point2D pa, Point2D fixpoint, int alpha)
{
    Point2D pr;

    pr.X = pa.X - fixpoint.X;
    pr.Y = pa.Y - fixpoint.Y;
    pr.X = ((pa.X * sin_05[(alpha+90) * 2])/1000)-((pa.Y* sin_05[(alpha) * 2])/1000);
    pr.Y = ((pa.X * sin_05[(alpha) * 2])/1000)+((pa.Y* sin_05[(alpha+90) * 2])/1000);
    pr.X += fixpoint.X;
    pr.Y += fixpoint.Y;

    return pr;
}
void Points2DRotate(Point2D *pointsA, Point2D *pointsB, USHORT length, Point2D origin, int alpha);
#endif // VECTOR
