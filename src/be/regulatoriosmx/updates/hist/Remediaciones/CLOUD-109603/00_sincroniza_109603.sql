USE [cob_credito]
GO

DROP TABLE #usuarios
GO

select DISTINCT us_login , oc_oficial, us_sec = 0 INTO #usuarios
from cobis..ad_usuario U,
cobis..ad_usuario_rol UR ,
cobis..cl_funcionario F,
cobis..cc_oficial  O
where U.us_login = UR.ur_login 
and UR.ur_rol = 14  ------------------>> ROL DE LA MOVIL
AND U.us_login = F.fu_login
AND O.oc_funcionario = F.fu_funcionario
AND fu_estado = 'V'
AND us_estado = 'V'

DECLARE 
@w_cont    INT,
@w_login   vARCHAR(32),
@w_oficial INT,
@w_total  int

SELECT @w_cont = 0
UPDATE #usuarios SET us_sec = @w_cont, @w_cont = @w_cont +1

SELECT @w_total = count(1) FROM #usuarios


SELECT @w_cont = 0
WHILE 1= 1
begin
	SELECT TOP 1
		@w_cont = us_sec,
		@w_login = us_login,
		@w_oficial = oc_oficial
	FROM #usuarios
	WHERE us_sec > @w_cont
	ORDER BY us_sec

	IF @@ROWCOUNT = 0 break
	
	PRINT ' ------------------------------------ >>>> Procesando SEC: ' + convert(VARCHAR, @w_cont) + ' de '+convert(VARCHAR, @w_total) + '  LOGIN ' + @w_login

	EXEC [sp_sync_device] 
    @s_user         = @w_login, 
    @i_oficial      = @w_oficial

END



