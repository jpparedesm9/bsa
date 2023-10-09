/*
*   Archivo para crear parametros iniciales requerimiento 141620
*   Johan castro
*   04/09/2020
*/
use cobis
GO 

delete from cl_parametro where pa_nemonico IN ('NRPOLZ','ANPOLZ','SEPROZ','SVIDAZ','SIFCEZ','SIFMIZ','SCANZ','COMSEZ','MONSEZ','DIRECZ','AMBISZ') 

GO