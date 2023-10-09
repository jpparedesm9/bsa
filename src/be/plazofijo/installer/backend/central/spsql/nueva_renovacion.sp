/************************************************************************/
/*      Archivo:                nueren.sp                               */
/*      Stored procedure:       sp_nueva_renovacion                     */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Dolores Guerrero                        */
/*      Fecha de documentacion: 14/Ago/1998                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa el mantenimiento de la tabla              */
/*      con los limites de negociaciones por oficina o funcionario      */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      14-Ago-98 Miguel Landivar   Creacion                            */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_nueva_renovacion')
   drop proc sp_nueva_renovacion       
go

create proc sp_nueva_renovacion (         
		@s_ssn                  int = NULL,
		@s_user                 login = NULL,
		@s_term                 varchar(30) = NULL,
		@s_date                 datetime = NULL,
		@s_srv                  varchar(30) = NULL,
		@s_lsrv                 varchar(30) = NULL,
		@s_ofi                  smallint = NULL,
		@s_rol                  smallint = NULL,
		@t_debug                char(1) = 'N',
		@t_file                 varchar(10) = NULL,
		@t_from                 varchar(32) = NULL,
		@t_trn                  smallint = NULL,
		@i_operacion            char(1),
		@i_operacionpf          int = NULL,
		@i_num_banco            varchar(14) = NULL,
		@i_valor_renovado	      money = NULL,    
		@i_valor_utilizado	    money = NULL,    
		@i_estado     	        char(1)= NULL,
		@i_tipo     	          char(1) = NULL,
		@i_modo    	            int =  null,
		@i_oficina    	        int =  null,
		@i_moneda    	          int =  null,
		@i_descripcion		      varchar(64)= NULL,
		@i_fecha		            datetime = NULL 
)
with encryption
as
declare         
    @w_sp_name              varchar(32),
		@w_return		            int,
		@w_valor_utilizado	    float ,    
		@w_valor_renovado	      float ,    
		@w_estado     	        char(1),
		@w_estadoop    	        char(3),
		@w_ley     	            char(1),
		@w_reflag     	        char(1),
		@w_operacion   	        int,
		@w_oficina     	        int,
		@w_fecha_cancela        datetime,
		@w_fecha_ven   		      datetime,
		@w_mon_sgte 		        smallint	

select @w_sp_name = 'sp_nueva_renovacion'


if   (@t_trn <> 14946 or @i_operacion <> 'I') and
     (@t_trn <> 14946 or @i_operacion <> 'D') and
     (@t_trn <> 14946 or @i_operacion <> 'U') and
     (@t_trn <> 14946 or @i_operacion <> 'R') and
     (@t_trn <> 14946 or @i_operacion <> 'S') and
     (@t_trn <> 14946 or @i_operacion <> 'H') 

begin
   exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 141112
   return 1
end
/** Insert **/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
     --Obtener el numero de operacion
     select @w_operacion = op_operacion,
     	    @w_estadoop = op_estado,
     	    @w_mon_sgte = op_mon_sgte
	from pf_operacion
	where op_num_banco = @i_num_banco 
end

If @i_operacion = 'I'
begin

	if exists (select * from pf_nueva_renovacion       
		where re_num_banco = @i_num_banco)
      begin
	 exec cobis..sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 149072	
	 return 1
      end


	--Obtener la oficina en la que se hizo la cancelacion
      select @w_oficina = ca_oficina
	from pf_cancelacion
	where ca_operacion = @w_operacion 

	--Obtener si el certificado esta congelado y fue precancelado
	select @w_ley = op_ley,
	 	@w_fecha_ven = op_fecha_ven,
		@w_fecha_cancela = op_fecha_cancela
	from cob_pfijo..pf_operacion 	
	where op_num_banco = @i_num_banco 

--print '%1!, %2!, %3!',@w_ley,@w_fecha_cancela,@w_fecha_ven
--print '%1!',@w_estadoop
	if @w_ley in ('S','C') and @w_fecha_cancela < @w_fecha_ven and @w_estadoop = 'CAN'
		select @w_reflag = 'S'

	--Obtener si el certificado esta congelado, fue cancelado y la forma de pago es pago de obligaciones
	if (@w_ley in ('S','C') and @w_fecha_cancela >= @w_fecha_ven and @w_estadoop = 'CAN') or (@w_ley in ('S','C') and @w_estadoop = 'ACT')
	begin
		select 
			@w_fecha_cancela = mm_fecha_aplicacion
		from cob_pfijo..pf_mov_monet 	
		where mm_operacion = @w_operacion 
		and mm_tran = 14903
		and mm_producto in ('TAR','CRE','HOG') 
		if @@rowcount > 0
			select @w_reflag = 'S'

	
	end

begin tran

      insert into pf_nueva_renovacion 

	       values    ( @w_operacion,  
			   @i_num_banco,
			   @i_valor_renovado,
		   	   @i_valor_utilizado,  
			   'V',
			   @w_oficina,
			   @i_moneda,
			   @w_reflag
			   )

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
	 exec cobis..sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 149072
	 return 1
      end

  commit tran
  
return 0

end

/** Update **/
If @i_operacion = 'U'
begin

    /* Si no existe, error */ 
    
    if not exists (select * from pf_nueva_renovacion       
            where re_num_banco = @i_num_banco)
    begin
      exec cobis..sp_cerror
	@t_debug        = @t_debug,
	@t_file         = @t_file,
	@t_from         = @w_sp_name,
	@i_num          = 149073	
      return 1    
    end
	/* calculo del nuevo valor*/
    select @w_valor_utilizado = re_valor_utilizado
	 from pf_nueva_renovacion       
            where re_num_banco = @i_num_banco


    select @w_valor_utilizado = @w_valor_utilizado - @i_valor_utilizado
	
    if @w_valor_utilizado = 0 
    begin
	select @w_estado = 'C'

	/*Actualizacion del estado de la operacion*/
	update cob_pfijo..pf_operacion
	set op_estado = 'REN'
	where op_num_banco = @i_num_banco 
    end
    else 
    	if @w_valor_utilizado > 0 
		select @w_estado = 'V'
	else
    		begin
      			exec cobis..sp_cerror
			@t_debug        = @t_debug,
			@t_file         = @t_file,
			@t_from         = @w_sp_name,
			@i_num          = 149073
      			return 1    
    		end
	  
      
     begin tran

     /* modificacion de los datos */
     update pf_nueva_renovacion         
	set  re_estado = @w_estado,    
	     re_valor_utilizado  = @w_valor_utilizado    
      where  re_num_banco = @i_num_banco      
     
     /* Si no se puede modificar,error */
     if @@error <> 0 
     begin
      exec cobis..sp_cerror
	@t_debug        = @t_debug,
	@t_file         = @t_file,
	@t_from         = @w_sp_name,
	@i_num          = 149073
      return 1    
     end 



  commit tran
  return 0
  
end /* fin de if @i_operacion = U */   


/** Delete **/
if @i_operacion = 'D'
begin

    if exists (select * from pf_nueva_renovacion       
            where re_num_banco = @i_num_banco)
    begin

   begin tran


    /* borrar el tipo de deposito  */
   	delete pf_nueva_renovacion                          
        where re_num_banco = @i_num_banco
    
   if @@error <> 0
     begin
      exec cobis..sp_cerror
	@t_debug        = @t_debug,
	@t_file         = @t_file,
	@t_from         = @w_sp_name,
	@i_num          = 149074	
      return 1    
     end 

  commit tran
  end
  return 0

end /* end de if operacion = D */

/** Help **/

If @i_operacion = 'H'
begin
 if @i_tipo = 'A'
begin
 set rowcount 20
 if @i_modo = 0
 begin
   /* Extrae los primeros veinte tipos dedeposito */
 select   'OPERACION'		  = re_num_banco,
          'MONTO'                 = re_valor_utilizado,
          'TITULAR'               = op_descripcion,	
	  'ESTATUS' 		  = op_ley,
	  'FECHA CAMB.TASA' 	  = op_ult_fecha_cal_tasa,
	  'TASA' 		  = op_tasa,
	  'FECHA INGRESO'	  = op_fecha_valor
   from pf_nueva_renovacion,pf_operacion
        where re_estado = 'V' 
	and re_operacion = op_operacion
	and re_oficina = @i_oficina
	and re_moneda = @i_moneda
	and op_estado ='CAN'
   order by op_descripcion      

 end

 if @i_modo = 1
   begin
     /* Extrae los siguientes 20 tipos de plazo */
 select   'OPERACION'		  = re_num_banco,
          'MONTO'                 = re_valor_utilizado,
          'TITULAR'               = op_descripcion,
	  'ESTATUS' 		  = op_ley,
	  'FECHA CAMB.TASA' 	  = op_ult_fecha_cal_tasa,
	  'TASA' 		  = op_tasa,
	  'FECHA INGRESO'	  = op_fecha_valor
   from pf_nueva_renovacion,pf_operacion
        where re_estado = 'V' 
	and re_operacion = op_operacion
	and re_oficina = @i_oficina
	and re_moneda = @i_moneda
	and op_estado ='CAN'
	and op_descripcion > @i_descripcion
    order by op_descripcion      
	
 end
	
 set rowcount 0 
   return 0   

 end
   
 if @i_tipo = 'V'
 begin
 select   re_valor_utilizado,
          op_descripcion,
	  op_ley,
	  op_ult_fecha_cal_tasa,
	  op_tasa,
	  op_fecha_valor
   from pf_nueva_renovacion,pf_operacion
        where re_num_banco = @i_num_banco
	and re_operacion = op_operacion
	and re_moneda = @i_moneda
	and re_oficina = @i_oficina
	and op_estado ='CAN'
	
    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
	@t_debug        = @t_debug,
	@t_file         = @t_file,
	@t_from         = @w_sp_name,
	@i_num          = 149075
      return 1    
    end

   return 0
 end
 end
if @i_operacion = 'R'
begin

    /* Si no existe, error */ 
    
    if  exists (select * from pf_nueva_renovacion       
            where re_num_banco = @i_num_banco)
    begin
	/* Validaciones del reverso de cancelacion */
    	select @w_valor_utilizado = re_valor_utilizado,
    	   @w_valor_renovado = re_valor_renovado
	 from pf_nueva_renovacion       
            where re_num_banco = @i_num_banco

	
    if @w_valor_utilizado <> @w_valor_renovado 
    	begin
      		exec cobis..sp_cerror
		@t_debug        = @t_debug,
		@t_file         = @t_file,
		@t_from         = @w_sp_name,
		@i_num          = 149076
      		return 1    
    	end
  end
      
  return 0
end /* fin de if @i_operacion = R */   

if @i_operacion = 'S'
begin
	if @i_tipo = 'R'
	begin
		/*select  
		'OPERACION ANTERIOR' = re_num_banco,
		'MONTO DE LA CANCELACION' = re_valor_renovado,
		'ESTADO' = re_estado,
		'OPERACION NUEVA' =  op_num_banco,
		'MONTO DE DE LA RENOVACION' = op_monto,
		'IMPUESTO' = op_impuesto_capital,
		'TOTAL RENOVACION' = op_monto + op_impuesto_capital
		from pf_nueva_renovacion,pf_operacion,pf_mov_monet
		where re_num_banco = mm_cuenta
		and mm_operacion = op_operacion
		and mm_tran = 14901
		and mm_estado = 'A'
		and mm_producto = 'REN'
		and re_oficina = @i_oficina
		and re_moneda = @i_moneda 
		--and op_monto + op_impuesto_capital <>re_valor_renovado
		and op_estado not in ('ANU')
		and op_fecha_valor = @i_fecha
		order by re_num_banco	*/

		select  
		'OPERACION ANTERIOR' = b.re_num_banco,
		'MONTO DE LA CANCELACION' = b.re_valor_renovado,
		'ESTADO' = b.re_estado,
		'OPERACION NUEVA' =  op_num_banco,
		'MONTO DE DE LA RENOVACION' = op_monto,
		'IMPUESTO' = op_impuesto_capital,
		'TOTAL RENOVACION' = op_monto + op_impuesto_capital
		from pf_nueva_renovacion b,pf_renovacion a,pf_operacion
		where b.re_operacion = a.re_operacion
		and a.re_operacion_new = op_operacion
		and a.re_estado <> 'R'
		and b.re_oficina = @i_oficina
		and b.re_moneda = @i_moneda 
		and op_estado not in ('ANU')
		and a.re_fecha_valor = @i_fecha
		order by re_num_banco	
	end
	else
	begin
		select  
		'OPERACION' = re_num_banco,
		'MONTO DE LA CANCELACION' = re_valor_renovado,
		'ESTADO' = re_estado
		from pf_nueva_renovacion,pf_operacion
		where 
		re_operacion = op_operacion
		and re_oficina = @i_oficina
		and re_moneda = @i_moneda 
		--and op_monto + op_impuesto_capital <>re_valor_renovado
		and op_fecha_cancela = @i_fecha
		and re_estado = 'V'
		order by re_num_banco	
	end

end
	
	

go

