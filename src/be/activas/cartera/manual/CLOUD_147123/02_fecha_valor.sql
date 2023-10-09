DECLARE @w_fecha_proceso DATETIME,
        @w_fecha_valor_atras   DATETIME,
		@w_contador      INT,
	    @w_operacion     INT,
	    @w_secuencial    INT,
	    @w_banco         VARCHAR (15),
-----
	    @w_fecha_fin     DATETIME,
	    @w_oficina       INT 

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
select 'Fecha_proceso' = @w_fecha_proceso

select @w_fecha_valor_atras = '09/29/2020' -- borrar para regresar a hoy
select 'Fecha_a_procesar_atras' = @w_fecha_valor_atras

select @w_contador = 0, @w_operacion = 0

while (exists(select 1 from operaciones_x_rev_tmp where operacion_tmp > @w_operacion))
BEGIN
   
    select @w_contador = @w_contador + 1

    select top 1
	@w_operacion = operacion_tmp,
	@w_banco = banco_tmp
	 from operaciones_x_rev_tmp
	where operacion_tmp > @w_operacion
	order by operacion_tmp    

	print 'INI FECHA VALOR Operacion:' + convert(VARCHAR,@w_operacion)+ '---@w_banco:' + @w_banco
  
    BEGIN TRY
        exec cob_cartera..sp_fecha_valor 
              @s_date        = @w_fecha_proceso, --'06/02/2020', -- fecha de proceso
              @s_user        = 'usrbatch',
              @s_term        = 'consola',
              @t_trn         = 7049,
              @i_fecha_mov   = @w_fecha_proceso, --'06/02/2020', -- fecha de proceso
              @i_fecha_valor = @w_fecha_valor_atras,--- habilitar cuando se realice fecha valor, si necesito ir hacia atras debo poner la fecha que necesito 
              @i_banco       = @w_banco, --'210800041050',
              --@i_secuencial  = @w_secuencial, --74, -- de la ca_transaccion y que secuencial no tenga estado 'RV' y debe secuencial > 0
              @i_operacion   = 'F' -- SI quiero regresar a una fecha va 'F', si quero reversar una transaccion va la letr 'R'         
	   
	   update operaciones_x_rev_tmp 
	      set fecha_atras_tmp = 'S'
        where banco_tmp = @w_banco
	      and operacion_tmp = @w_operacion	
		  
    END TRY
    BEGIN CATCH 	    
    	print 'FALLA FECHA VALOR Operacion:' + convert(VARCHAR,@w_operacion) + '---@w_banco:' + @w_banco
	   update operaciones_x_rev_tmp 
	      set fecha_atras_tmp = 'X'
        where banco_tmp = @w_banco
	      and operacion_tmp = @w_operacion
		  
    END  CATCH 
	
	------------------- HOY
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
	   
	   update operaciones_x_rev_tmp 
	      set fecha_hoy_tmp = 'S'
        where banco_tmp = @w_banco
	      and operacion_tmp = @w_operacion		  
    END TRY
    BEGIN CATCH 	    
    	print 'FALLA FECHA VALOR Operacion:' + convert(VARCHAR,@w_operacion) + '---@w_banco:' + @w_banco
	   update operaciones_x_rev_tmp 
	      set fecha_hoy_tmp = 'X'
        where banco_tmp = @w_banco
	      and operacion_tmp = @w_operacion		  
    END  CATCH 	
    
END 
select 'contador' = @w_contador
--------------------
GO
