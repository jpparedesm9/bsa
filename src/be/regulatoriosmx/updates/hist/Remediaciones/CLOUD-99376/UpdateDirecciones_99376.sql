select *
from cobis..cl_direccion
where di_ente in (6827, 6456, 6478, 1854, 1808, 8606, 6999, 2681, 6661,
                  2489, 1294, 1304, 4450, 1658, 2162, 3517, 2626, 3636,
                  913 , 487 , 1112, 13  , 6116, 1285, 1288, 6557, 1669,
                  1749, 1753, 1320, 214 , 3330, 6122, 805 , 6969, 5108,
                  3530, 7953, 4011, 1583, 3535, 3639, 3857, 1000, 4427,
                  12  , 3531, 554 , 16  , 3431, 1293, 1297, 4909, 1190,
                  2278, 1486, 7172, 1383, 1552, 1555, 1181, 1188, 1182,
                  1483, 4514, 31  , 28  , 1490, 4482, 24  , 11  , 23  ,
                  17  , 20  , 4485, 43  , 33  , 917 , 1672, 1006, 1286,
                  1342, 553 , 552 , 2964, 4224, 2971, 1346, 3404, 1375,
                  555 , 703 , 694 , 942 , 81  , 82  , 551 , 1002, 86  ,
                  1289, 3117, 4486, 4487, 85  , 6443, 6446, 6251, 6767,
                  1908, 1185, 3896, 3934, 3442, 3724, 281 , 7849, 6627,
                  1001, 997 , 6139, 3288, 2171, 702 , 2885, 36  , 2816,
                  7509, 7497, 7818, 2799, 2459, 2464, 2475, 2471, 2493,
                  1793, 5878, 5932, 2864, 795 , 4503, 2472, 2473, 4515,
                  4522, 2811, 2813, 7883, 310 , 299 , 4640, 1219, 1220,
                  7335, 7561, 3674, 5895, 1240, 2016, 5939, 8022, 5898,
                  5913, 3487, 4196, 2706, 973 , 2856, 1084, 1091, 1380,
                  6821, 5910, 6540, 7589, 3611, 4815, 909 , 1110, 1414,
                  1295, 1506, 1292, 6685, 6759, 1721, 2825, 2615, 2526,
                  932 , 2660, 6975, 6866, 429 , 4784, 4782, 6549, 7201,
                  7019, 4953, 2175, 425 , 1010, 1021, 2156, 436 , 2268,
                  2252, 6682, 6951, 3923, 2412, 2414, 3929, 5762, 5768,
                  2418, 1071, 758 , 2061, 1058, 1061, 1056, 493 , 503 ,
                  1081, 3210, 2549, 2747, 1020, 1024, 1763, 3913, 4325,
                  7065, 6991, 4961, 2776, 2686, 2695, 3278, 3614, 6982,
                  6988, 6824, 292 , 7629, 305 , 6619, 289 , 301 , 6467,
                  7861, 1088, 1247, 2104, 1095, 1718, 1094, 739 , 829 ,
                  731 , 814 , 806 , 813 , 906 , 5940, 6359, 1761, 1920,
                  1426, 1431, 1418, 1242, 2599, 7857, 6120, 2281, 481 ,
                  3990, 7548, 8075, 1766, 803 , 7501, 7640, 2744, 1344,
                  792 , 752 , 727 , 1562, 2285, 7909, 5507, 6723, 231 ,
                  7294, 6905)
and     di_tipo  in ('AE', 'RE') 
and     di_calle is not null              





update cobis..cl_direccion
set di_calle = 'CALLE ' + UPPER(di_calle)
from cobis..cl_direccion
where di_ente in (6827, 6456, 6478, 1854, 1808, 8606, 6999, 2681, 6661,
                  2489, 1294, 1304, 4450, 1658, 2162, 3517, 2626, 3636,
                  913 , 487 , 1112, 13  , 6116, 1285, 1288, 6557, 1669,
                  1749, 1753, 1320, 214 , 3330, 6122, 805 , 6969, 5108,
                  3530, 7953, 4011, 1583, 3535, 3639, 3857, 1000, 4427,
                  12  , 3531, 554 , 16  , 3431, 1293, 1297, 4909, 1190,
                  2278, 1486, 7172, 1383, 1552, 1555, 1181, 1188, 1182,
                  1483, 4514, 31  , 28  , 1490, 4482, 24  , 11  , 23  ,
                  17  , 20  , 4485, 43  , 33  , 917 , 1672, 1006, 1286,
                  1342, 553 , 552 , 2964, 4224, 2971, 1346, 3404, 1375,
                  555 , 703 , 694 , 942 , 81  , 82  , 551 , 1002, 86  ,
                  1289, 3117, 4486, 4487, 85  , 6443, 6446, 6251, 6767,
                  1908, 1185, 3896, 3934, 3442, 3724, 281 , 7849, 6627,
                  1001, 997 , 6139, 3288, 2171, 702 , 2885, 36  , 2816,
                  7509, 7497, 7818, 2799, 2459, 2464, 2475, 2471, 2493,
                  1793, 5878, 5932, 2864, 795 , 4503, 2472, 2473, 4515,
                  4522, 2811, 2813, 7883, 310 , 299 , 4640, 1219, 1220,
                  7335, 7561, 3674, 5895, 1240, 2016, 5939, 8022, 5898,
                  5913, 3487, 4196, 2706, 973 , 2856, 1084, 1091, 1380,
                  6821, 5910, 6540, 7589, 3611, 4815, 909 , 1110, 1414,
                  1295, 1506, 1292, 6685, 6759, 1721, 2825, 2615, 2526,
                  932 , 2660, 6975, 6866, 429 , 4784, 4782, 6549, 7201,
                  7019, 4953, 2175, 425 , 1010, 1021, 2156, 436 , 2268,
                  2252, 6682, 6951, 3923, 2412, 2414, 3929, 5762, 5768,
                  2418, 1071, 758 , 2061, 1058, 1061, 1056, 493 , 503 ,
                  1081, 3210, 2549, 2747, 1020, 1024, 1763, 3913, 4325,
                  7065, 6991, 4961, 2776, 2686, 2695, 3278, 3614, 6982,
                  6988, 6824, 292 , 7629, 305 , 6619, 289 , 301 , 6467,
                  7861, 1088, 1247, 2104, 1095, 1718, 1094, 739 , 829 ,
                  731 , 814 , 806 , 813 , 906 , 5940, 6359, 1761, 1920,
                  1426, 1431, 1418, 1242, 2599, 7857, 6120, 2281, 481 ,
                  3990, 7548, 8075, 1766, 803 , 7501, 7640, 2744, 1344,
                  792 , 752 , 727 , 1562, 2285, 7909, 5507, 6723, 231 ,
                  7294, 6905)
and     di_tipo  in ('AE', 'RE')               
and    (UPPER(di_calle) like 'NORTE%'    or 
        UPPER(di_calle) like 'SUR%'      or 
        UPPER(di_calle) like 'ORIENTE%'  or 
        UPPER(di_calle) like 'PONIENTE%' or 
        UPPER(di_calle) like 'PTE%' or 
        UPPER(di_calle) like 'NTE%' or 
        UPPER(di_calle) like 'OTE%' )


select *
from cobis..cl_direccion
where di_ente in (6827, 6456, 6478, 1854, 1808, 8606, 6999, 2681, 6661,
                  2489, 1294, 1304, 4450, 1658, 2162, 3517, 2626, 3636,
                  913 , 487 , 1112, 13  , 6116, 1285, 1288, 6557, 1669,
                  1749, 1753, 1320, 214 , 3330, 6122, 805 , 6969, 5108,
                  3530, 7953, 4011, 1583, 3535, 3639, 3857, 1000, 4427,
                  12  , 3531, 554 , 16  , 3431, 1293, 1297, 4909, 1190,
                  2278, 1486, 7172, 1383, 1552, 1555, 1181, 1188, 1182,
                  1483, 4514, 31  , 28  , 1490, 4482, 24  , 11  , 23  ,
                  17  , 20  , 4485, 43  , 33  , 917 , 1672, 1006, 1286,
                  1342, 553 , 552 , 2964, 4224, 2971, 1346, 3404, 1375,
                  555 , 703 , 694 , 942 , 81  , 82  , 551 , 1002, 86  ,
                  1289, 3117, 4486, 4487, 85  , 6443, 6446, 6251, 6767,
                  1908, 1185, 3896, 3934, 3442, 3724, 281 , 7849, 6627,
                  1001, 997 , 6139, 3288, 2171, 702 , 2885, 36  , 2816,
                  7509, 7497, 7818, 2799, 2459, 2464, 2475, 2471, 2493,
                  1793, 5878, 5932, 2864, 795 , 4503, 2472, 2473, 4515,
                  4522, 2811, 2813, 7883, 310 , 299 , 4640, 1219, 1220,
                  7335, 7561, 3674, 5895, 1240, 2016, 5939, 8022, 5898,
                  5913, 3487, 4196, 2706, 973 , 2856, 1084, 1091, 1380,
                  6821, 5910, 6540, 7589, 3611, 4815, 909 , 1110, 1414,
                  1295, 1506, 1292, 6685, 6759, 1721, 2825, 2615, 2526,
                  932 , 2660, 6975, 6866, 429 , 4784, 4782, 6549, 7201,
                  7019, 4953, 2175, 425 , 1010, 1021, 2156, 436 , 2268,
                  2252, 6682, 6951, 3923, 2412, 2414, 3929, 5762, 5768,
                  2418, 1071, 758 , 2061, 1058, 1061, 1056, 493 , 503 ,
                  1081, 3210, 2549, 2747, 1020, 1024, 1763, 3913, 4325,
                  7065, 6991, 4961, 2776, 2686, 2695, 3278, 3614, 6982,
                  6988, 6824, 292 , 7629, 305 , 6619, 289 , 301 , 6467,
                  7861, 1088, 1247, 2104, 1095, 1718, 1094, 739 , 829 ,
                  731 , 814 , 806 , 813 , 906 , 5940, 6359, 1761, 1920,
                  1426, 1431, 1418, 1242, 2599, 7857, 6120, 2281, 481 ,
                  3990, 7548, 8075, 1766, 803 , 7501, 7640, 2744, 1344,
                  792 , 752 , 727 , 1562, 2285, 7909, 5507, 6723, 231 ,
                  7294, 6905)
and     di_tipo  in ('AE', 'RE')  
and     di_calle is not null 

