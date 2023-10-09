update cob_credito..cr_tr_sincronizar
set    ti_seccion = 'APLICAR CUESTIONARIO - GRUPAL'
where  ti_seccion = 'APLICAR CUESTIONARIO - GRP'
and    ti_tramite in (438,852,1851,2590,
                      2625,2635,3074,3368,
                      4345,6224,9893,11410,
                      12693,14837,15683,16642,
                      26141,26768,26973,29821,
                      29901,31096,32403,34903,
                      36000,36273,37314,37431,
                      38516,39739,41501,41982,
                      42416,43510,43704,45103,
                      46387,46403,46582,48484,
                      48514,49089,49474,50120,50243)

go




