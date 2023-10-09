/*Para 126 registros menos de un minuto*/
PRINT 'script 08-Inicio:' + convert(VARCHAR,getdate())

DECLARE @w_fecha_proceso DATETIME,
		@w_contador      INT,
	    @w_operacion     INT,
	    @w_secuencial    INT,
	    @w_banco         VARCHAR (15),
-----
	    @w_fecha_fin     DATETIME,
	    @w_oficina       INT 

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso
SELECT 'Fecha_proceso' = @w_fecha_proceso

SELECT operacion = operacion_c, prestamo = banco_c
  into #operaciones_castigadas
  FROM operaciones_castigadas_cs145246_borrar_tmp
   
SELECT @w_contador = 0, @w_operacion = 0

WHILE (exists(select 1 from #operaciones_castigadas where operacion > @w_operacion))
BEGIN
   
    SELECT @w_contador = @w_contador + 1

    select top 1
	@w_operacion = operacion,
	@w_banco = prestamo
	 from #operaciones_castigadas
	where operacion > @w_operacion
	order by operacion    

	print 'INI REVERSA Operacion:' + convert(VARCHAR,@w_operacion)+ '---@w_banco:' + @w_banco
  
    BEGIN TRY
        exec cob_cartera..sp_fecha_valor 
              @s_date        = @w_fecha_proceso, --'06/02/2020', -- fecha de proceso
              @s_user        = 'usrbatch',
              @s_term        = 'consola',
              @t_trn         = 7049,
              @i_fecha_mov   = @w_fecha_proceso, --'06/02/2020', -- fecha de proceso
              @i_fecha_valor = @w_fecha_proceso,--- habilitar cuando se realice fecha valor, si necesito ir hacia atras debo poner la fecha que necesito 
              @i_banco       = @w_banco, --'210800041050',
              --@i_secuencial  = @w_secuencial, --74, -- de la ca_transaccion y que secuencial no tenga estado 'RV' y debe secuencial > 0
              @i_operacion   = 'F' -- SI quiero regresar a una fecha va 'F', si quero reversar una transaccion va la letr 'R' 
        
	   update operaciones_castigadas_cs145246_borrar_tmp 
	      set realiza_fecha_hoy = 'S'
        where banco_c = @w_banco
	      and operacion_c = @w_operacion
		  
    END TRY
    BEGIN CATCH 	    
    	print 'FALLA  REVERSA Operacion:' + convert(VARCHAR,@w_operacion) + '---@w_banco:' + @w_banco

	   update operaciones_castigadas_cs145246_borrar_tmp 
	      set realiza_fecha_hoy = 'E'
        where banco_c = @w_banco
	      and operacion_c = @w_operacion
		  
    END  CATCH 
END 
SELECT 'contador' = @w_contador --- 
--------------------
DROP TABLE #operaciones_castigadas

PRINT 'script 08-Fin:' + convert(VARCHAR,getdate())

GO
