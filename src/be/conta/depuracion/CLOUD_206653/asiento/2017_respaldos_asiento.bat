bcp "SELECT * FROM cob_conta_tercero..ct_sasiento WHERE sa_fecha_tran BETWEEN '10/01/2017' AND '10/31/2017'" queryout D:\Temp\Pruebas\cob_conta_tercero_ct_sasiento_Octubre_2017.dat -n -r \n -T -S
bcp "SELECT * FROM cob_conta_tercero..ct_sasiento WHERE sa_fecha_tran BETWEEN '11/01/2017' AND '11/30/2017'" queryout D:\Temp\Pruebas\cob_conta_tercero_ct_sasiento_Noviembre_2017.dat -n -r \n -T -S
bcp "SELECT * FROM cob_conta_tercero..ct_sasiento WHERE sa_fecha_tran BETWEEN '12/01/2017' AND '12/31/2017'" queryout D:\Temp\Pruebas\cob_conta_tercero_ct_sasiento_Diciembre_2017.dat -n -r \n -T -S
