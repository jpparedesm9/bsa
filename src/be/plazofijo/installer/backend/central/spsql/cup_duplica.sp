/************************************************************************/
/*      Archivo:                duplica.sp                              */
/*      Stored procedure:       sp_duplica                              */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */  
/*      Disenado por:           Walter Solís                         */
/*      Fecha de documentacion: 07/jun/01                               */
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
/*      Este procedimiento almacenado realiza las actualizaciones       */
/*      para la emision cupones de un un certificado de depositos       */
/*       a plazo.                                                       */
/*                                                                      */
/*                                                                      */
/*                          MODIFICACIONES                              */
/*      FECHA                   AUTOR              RAZON                */
/************************************************************************/

use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_cup_duplica')
   drop proc sp_cup_duplica
go

create proc sp_cup_duplica (
@s_ssn                  int = null,
@s_user                 login = null,
@s_term                 varchar(30) = null,
@s_date                 datetime = null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_ofi                  smallint = null,
@s_rol                  smallint = NULL,
@t_debug                char(1) = 'N',
@t_file                 varchar(10) = null,
@t_from                 varchar(32) = null,
@t_trn                  smallint,
@i_num_banco            cuenta,
@i_preimpreso           varchar(15) = null,
@i_autorizado           login = '',
@i_rango_inicial        int,
@i_rango_final          int,
@i_filial								int = 1  -- JSA 14/01/2002 para dividir en bco de off.
)
with encryption
as
declare         
@w_sp_name              varchar(32),
@w_cu_num_impr          tinyint,
@w_cu_fecha_mod         datetime, 
@w_codigo               int,
@w_operacionpf          int,
@w_op_fecha_valor       datetime,
@w_fecha_mod		        datetime,
@w_op_historia          tinyint,
@w_preimpreso           int,
@w_preimpreso_cu        int,
@w_toperacion           catalogo,
@w_observacion          varchar(25),
@w_rango_actual         int,
@w_preimpreso_actual    int

select @w_sp_name = 'sp_cup_duplica'

if @t_trn not in (14958, 14976)
begin
	exec cobis..sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 141018
	   /*  'Error en codigo de transaccion' */
  return 1
end

/* Verificacion de la existencia de la operacion y conversion a entero */
select @w_operacionpf = op_operacion,
       @w_op_historia = op_historia,
       @w_toperacion  = op_toperacion,
       @w_preimpreso  = isnull(op_preimpreso,0),
       @w_fecha_mod   = op_fecha_mod
from pf_operacion
where op_num_banco = @i_num_banco
if @@rowcount = 0
begin
  exec cobis..sp_cerror
    @t_debug = @t_debug,
	  @t_file  = @t_file,
	  @t_from	 = @w_sp_name,
	  @i_num	 = 141051
  return 1
end

/*Inicilizacion de las variables de trabajo del bucle*/
select @w_rango_actual = @i_rango_inicial,
       @w_preimpreso_actual = convert(int, @i_preimpreso)
       
begin tran

while 1= 1
begin
 
  /*Verifica la existencia del cupon a actualizar...*/  
  select @w_cu_num_impr = cu_num_impr_orig,
	       @w_preimpreso_cu = cu_preimpreso,
	       @w_cu_fecha_mod = cu_fecha_mod
  from pf_cuotas
  where cu_operacion = @w_operacionpf 
    and cu_cuota = @w_rango_actual
  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from	 = @w_sp_name,
       @i_num	 = 141161
    return 1
  end
  if @w_cu_num_impr is null 
     Select  @w_cu_num_impr = 0  

  /*Verifica que el # de preimpreso no exista...*/
	if @i_filial = 1
    if exists(select * from pf_npreimpreso
              where np_preimpreso_cupon = @w_preimpreso_actual
             )
    begin
      exec cobis..sp_cerror
        	 @t_debug = @t_debug,
	         @t_file  = @t_file,
	         @t_from  = @w_sp_name,
         	 @i_num	 = 141151
      return 1
    end
	else
    if exists(select * from pf_npreimpreso
            where np_toperacion = @w_toperacion 
              --and np_preimpreso = @w_preimpreso 
              and np_preimpreso_cupon = @w_preimpreso_actual
             )
    begin
      exec cobis..sp_cerror
        	 @t_debug = @t_debug,
	         @t_file  = @t_file,
	         @t_from  = @w_sp_name,
         	 @i_num	 = 141151
      return 1
    end

  /*Se actualiza la tabla pf_operacion con el nuevo dato de op_historia*/ 
  update pf_operacion
  set op_historia   = @w_op_historia + 1,
      op_fecha_mod  = @s_date
  where op_operacion = @w_operacionpf
  /* Si no se puede modificar, error */
  if @@rowcount <> 1
  begin
     /* Error en actualizacion de pf_operacion */
     exec cobis..sp_cerror
     @t_debug    = @t_debug,
     @t_file     = @t_file,
     @t_from     = @w_sp_name,
     @i_num      = 145001
     return 1
  end

  /* transaccion de servicio con los datos anteriores - pf_operacion */
  insert into ts_operacion (secuencial, tipo_transaccion, clase, fecha, usuario,
                            terminal, srv, lsrv, historia,fecha_mod,operacion)
  values    		   (@s_ssn, @t_trn, 'P', @s_date, @s_user, @s_term,
                            @s_srv, @s_lsrv, @w_op_historia, @w_fecha_mod,@w_operacionpf)
  /* Si no se puede insertar transaccion de servicio, ERROR */
  if @@error <> 0
  begin
     exec cobis..sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 143005
     return 1
  end

  /* transaccion de servicio con los datos modificados - pf_operacion */
  insert into ts_operacion (secuencial, tipo_transaccion, clase, fecha, usuario,
                            terminal, srv, lsrv, historia,fecha_mod,operacion)
  values    		   (@s_ssn, @t_trn, 'A', @s_date, @s_user, 
                    @s_term, @s_srv, @s_lsrv, @w_op_historia + 1, @s_date,@w_operacionpf)
  if @@error <> 0
  begin
      exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 143005
      return 1
  end


  Select @w_observacion = 'Imp.cupon#' + convert(varchar(4),@w_rango_actual) + ' Prei.#' + convert(varchar(14), @w_preimpreso_actual)

   /* Creacion del registro en pf_historia */
   insert into pf_historia(hi_operacion, 
			 hi_secuencial,
			 hi_fecha,
			 hi_trn_code,	
			 hi_valor,
			 hi_funcionario,
			 hi_oficina,
			 hi_fecha_crea,	
			 hi_fecha_mod,
			 hi_observacion,
                         hi_cupon)   -- GES 07/16/01 CUZ-020-103
    values  		 (@w_operacionpf,
			 @w_op_historia, 
			 @s_date,
			 @t_trn,
			 null,
			 @s_user,
			 @s_ofi,
		 	 @s_date,
		 	 @s_date,
			 @w_observacion,
                         @w_rango_actual)   -- GES 07/16/01 CUZ-020-103
  if @@error <> 0
  begin
    /* 'Error en creacion de registro en pf_historia' */
    exec cobis..sp_cerror
	@t_debug	= @t_debug,
	@t_file		= @t_file,
	@t_from		= @w_sp_name,
	@i_num		= 143006
    return 1
  end 


  /*ACTUALIZACION DE PF_CUOTAS */
  update pf_cuotas
  set cu_num_impr_orig = @w_cu_num_impr + 1,
      cu_preimpreso = @w_preimpreso_actual,
      cu_fecha_mod  = @s_date
  where cu_operacion = @w_operacionpf 
    and cu_cuota = @w_rango_actual
  
  /* Si no se puede modificar, error */
  if @@rowcount <> 1
  begin
     /* Error en actualizacion de pf_coutas */
     exec cobis..sp_cerror
     @t_debug    = @t_debug,
     @t_file     = @t_file,
     @t_from     = @w_sp_name,
     @i_num      = 145043
     return 1
  end         

  /* transaccion de servicio con los datos anteriores - pf_cuotas */
  insert ts_cuotas (secuencial, 
		   tipo_transaccion, 
		   clase,
		   usuario, 
		   terminal, 
		   srv, 
		   lsrv, 
		   fecha, 
		   operacion,
       cuota,
		   fecha_caja,
       fecha_mod,
       preimpreso,
       num_impre)
  values           (@s_ssn, 
		   14146,
		   'P',
		   @s_user, 
		   @s_term, 
		   @s_srv, 
		   @s_lsrv,
		   @s_date, 
		   @w_operacionpf, 
       @w_rango_actual,
		   @s_date,
       @w_cu_fecha_mod,
       @w_preimpreso_cu, 
       @w_cu_num_impr)
 if @@error <> 0
    begin
       exec cobis..sp_cerror
       @t_debug=@t_debug,
       @t_file=@t_file,
       @t_from=@w_sp_name,
       @i_num = 143005
       return 1
    end



  /* transaccion de servicio con los datos modificados - pf_cuotas */
  insert ts_cuotas (secuencial, 
		   tipo_transaccion, 
		   clase,
		   usuario, 
		   terminal, 
		   srv, 
		   lsrv, 
		   fecha, 
		   operacion,
       cuota,
		   fecha_caja,
       fecha_mod,
       preimpreso,
       num_impre)
  values           (@s_ssn, 
		   14146,
		   'A',
		   @s_user, 
		   @s_term, 
		   @s_srv, 
		   @s_lsrv,
		   @s_date, 
		   @w_operacionpf, 
       @w_rango_actual,
		   @s_date,
       @s_date,
       @w_preimpreso_actual, 
       @w_cu_num_impr+1)
 if @@error <> 0
    begin
       exec cobis..sp_cerror
       @t_debug=@t_debug,
       @t_file=@t_file,
       @t_from=@w_sp_name,
       @i_num = 143005
       return 1
    end


   /* INSERTAR EN LA TABLA DE NUMEROS PREIMPRESOS */
   insert into pf_npreimpreso(np_operacion, 
                              np_secuencial, 
                              np_preimpreso, 
                              np_observacion,
                              np_toperacion,
                              np_preimpreso_cupon,
                              np_hora,
                              np_usuario,
                              np_fecha,
                              np_cupon) 
   select @w_operacionpf, 
          @w_cu_num_impr + 1,
          @w_preimpreso, 
          @w_observacion,
          @w_toperacion,
          @w_preimpreso_actual,
          convert(char(2), datepart(hh, getdate())) + ':' + convert(char(2), datepart(mi, getdate())),
          @s_user,
          @s_date,
          convert(varchar(10), @w_rango_actual)
                   

     if @@error <> 0
     begin
       /* 'Error en creacion de registro en pf_npreimpreso' */
       exec cobis..sp_cerror
	       @t_debug	= @t_debug,
  	     @t_file	= @t_file,
	       @t_from	= @w_sp_name,
	       @i_num	= 143024
       return 1
     end 


   if @i_autorizado <> ''  
   begin
      insert pf_autorizacion (au_operacion,
			      au_autoriza, 
			      au_oficina,
			      au_tautorizacion,
			      au_fecha_crea,
			      au_num_banco,
			      au_oficial)
      values (		      @w_operacionpf,
			      @i_autorizado,
			      @s_ofi, 
			      'REIC',
			      @s_date,
			      @i_num_banco,
			      @s_user)    
     if @@error <> 0
     begin
       /* 'Error en creacion de registro en pf_npreimpreso' */
       exec cobis..sp_cerror
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_num          = 143033
       return 1
      end        
   end

   /*Aumentativo de la variables de trabajo del bucle.*/
   select @w_preimpreso_actual = @w_preimpreso_actual + 1 --sgte preimpreso 
   select @w_op_historia = @w_op_historia + 1 --sgte.ophistoria
   select @w_rango_actual = @w_rango_actual + 1  --sgte. cupon
   if @w_rango_actual > @i_rango_final
   begin
      break
   end

end -- del while...

commit tran

return 0   

go

