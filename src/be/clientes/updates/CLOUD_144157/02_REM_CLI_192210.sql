/*Script 03 VERSION 1*/
/*Para ejecutar el sp_util, el script se puede ejecutar varias veces */
/*debe ser enviado con cada remediacion*/
use cob_externos
go

declare @w_ente         int,
	    @w_nombre       varchar(64),
	    @w_p_s_nombre   varchar(64),
        @w_p_p_apellido varchar(64),
	    @w_p_s_apellido varchar(64),
		@w_id           int,
		@w_acepta_vacio char(1)
		
select @w_ente = 0

while (exists(select 1 from cambio_nombre_tmp where ente > @w_ente and procesado = ''))
BEGIN
   
    SELECT TOP 1
	       @w_id = id,
           @w_ente = ente,
	       @w_nombre = nombre,
           @w_p_s_nombre = p_s_nombre,
           @w_p_p_apellido = p_p_apellido,
           @w_p_s_apellido = p_s_apellido,
		   @w_acepta_vacio = acepta_vacio_seg
    from cambio_nombre_tmp
	where  ente > @w_ente
	and procesado = ''
	order by ente

    SELECT 'datos_a_tomar', 'ID' = @w_id, 'CLIENTE' = @w_ente, @w_nombre,@w_p_s_nombre,@w_p_p_apellido,@w_p_s_apellido
    
    exec sp_util_08_act_nombre_cliente
         @i_param1 = @w_ente,
         @i_param2 = @w_nombre, -- primer nombre en_nombre
         @i_param3 = @w_p_s_nombre, -- segundo nombre p_s_nombre
         @i_param4 = @w_p_p_apellido, -- primer apellido p_p_apellido
         @i_param5 = @w_p_s_apellido, -- segundo apellido p_s_apellido
		 @i_param6 = @w_acepta_vacio
	
	update cambio_nombre_tmp
	   set fecha_act = getdate(),
	       procesado = 'S'
	where ente = @w_ente
	  and id = @w_id
	  
END
GO
