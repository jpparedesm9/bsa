/*Para 126 registros alrededor de 4 minutos*/
PRINT 'script 02-Inicio:' + convert(VARCHAR,getdate())

DECLARE @w_fecha_proceso DATETIME,
		@w_contador      INT,
	    @w_operacion     INT,
	    @w_secuencial    INT,
	    @w_banco         VARCHAR (15),
-----
	    @w_fecha_fin     DATETIME,
	    @w_oficina       INT 
		
update cobis..cl_parametro 
   set pa_char = 'N'
 where pa_nemonico = 'PAVACA'
   and pa_producto = 'CCA'

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso
SELECT 'Fecha_proceso' = @w_fecha_proceso

SELECT operacion = operacion_c, prestamo = banco_c
  into #operaciones_castigadas_ETM
FROM operaciones_castigadas_cs145246_borrar_tmp
 
SELECT T.*
  INTO #operaciones_castigadas_ETM_a_procesar
  FROM cob_cartera..ca_transaccion T, #operaciones_castigadas_ETM O
 WHERE tr_operacion = O.operacion
   AND tr_banco = O.prestamo
   AND tr_secuencial > 0
   AND tr_estado <> 'RV'
   AND tr_tran = 'ETM'---cambio de estado manual
  ORDER BY tr_operacion

SELECT @w_contador = 0, @w_operacion = 0
WHILE (exists(select 1 from #operaciones_castigadas_ETM_a_procesar where tr_operacion > @w_operacion))
BEGIN
   
    SELECT @w_contador = @w_contador + 1

    select top 1
	@w_operacion  = tr_operacion,
	@w_secuencial = tr_secuencial,
	@w_banco = tr_banco
	 from #operaciones_castigadas_ETM_a_procesar
	where tr_operacion > @w_operacion
	order by tr_operacion
	    
	print 'INI REVERSA Operacion:' + convert(VARCHAR,@w_operacion)+ '---@w_banco:' + @w_banco +'---@w_secuencial:' + convert(VARCHAR,@w_secuencial)
  
    BEGIN TRY
       exec cob_cartera..sp_fecha_valor 
             @s_date        = @w_fecha_proceso, --'06/02/2020', -- fecha de proceso
             @s_user        = 'usrbatch',
             @s_term        = 'consola',
             @t_trn         = 7049,
             @i_fecha_mov   = @w_fecha_proceso, --'06/02/2020', -- fecha de proceso
             --@i_fecha_valor = @w_fecha_pro, -- se habilita pra la fecha valor y se comenta el @w_secuencial
             @i_banco       = @w_banco, --'210800041050',
             @i_secuencial  = @w_secuencial, --74, -- de la ca_transaccion y que secuencial no tenga estado 'RV' y debe secuencial > 0
             @i_operacion   = 'R' -- SI quiero regresar a una fecha va 'F', si quero reversar una transaccion va la letr 'R'        
       
	   update operaciones_castigadas_cs145246_borrar_tmp 
	      set realiza_reverso = 'S'
        where banco_c = @w_banco
	      and operacion_c = @w_operacion
    END TRY
    BEGIN CATCH 	    
    	print 'FALLA  REVERSA Operacion:' + convert(VARCHAR,@w_operacion) + '---@w_banco:' + @w_banco
		
	   update operaciones_castigadas_cs145246_borrar_tmp 
	      set realiza_reverso = 'E'
        where banco_c = @w_banco
	      and operacion_c = @w_operacion
		  
    END  CATCH
END 
SELECT 'contador' = @w_contador --- 
--------------------
DROP TABLE #operaciones_castigadas_ETM
DROP TABLE #operaciones_castigadas_ETM_a_procesar

update cobis..cl_parametro 
   set pa_char = 'S'
 where pa_nemonico = 'PAVACA'
   and pa_producto = 'CCA'

PRINT 'script 06-Fin:' + convert(VARCHAR,getdate())

GO
