/*******************************************************************/
/*  Archivo:          cta_vigente.sp                               */
/*  Stored procedure: sp_cta_vigente                               */
/*  Base de datos:    cob_cuentas                                  */
/*  Producto:         Cuentas de Ahorros                           */
/*******************************************************************/
/*                         IMPORTANTE                              */
/* Esta aplicacion es parte de los paquetes bancarios propiedad    */
/* de COBISCorp.                                                   */
/* Su uso no autorizado queda expresamente prohibido asi como      */
/* cualquier alteracion o agregado  hecho por alguno de sus        */
/* usuarios sin el debido consentimiento por escrito de COBISCorp. */
/* Este programa esta protegido por la ley de derechos de autor    */
/* y por las convenciones  internacionales   de  propiedad inte-   */
/* lectual.    Su uso no  autorizado dara  derecho a COBISCorp para*/
/* obtener ordenes  de secuestro o retencion y para  perseguir     */
/* penalmente a los autores de cualquier infraccion.               */
/*******************************************************************/
/*                           PROPOSITO                             */
/* Permite verificar la vigencia de una cuenta                     */
/*******************************************************************/
/*                        MODIFICACIONES                           */
/*  FECHA                 AUTOR           RAZON                    */
/* 12/Jul/2016          J. Tagle        Migración a CEN            */
/*******************************************************************/

use cob_cuentas
go

go
IF OBJECT_ID('dbo.sp_cta_vigente') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_cta_vigente
    IF OBJECT_ID('dbo.sp_cta_vigente') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_cta_vigente >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_cta_vigente >>>'
END
go
create proc sp_cta_vigente (
    	@t_trn          int = null, 
	@t_debug	char(1) = 'N',
	@s_srv		varchar(30) = null,
	@s_ofi		smallint = null,
	@i_ver_nodo	char(1) = 'N',
	@i_val		money	= 0,
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@s_rol		smallint = null,
	@i_cta_banco	varchar(20),
	@i_moneda	tinyint,
	@i_gerencia	char(1) = 'N',
        @i_cau          varchar(10) = null,
        @i_pit          char(1) = 'N', --Parametro usado por la interface PIT
        @i_bloqueo      char(1) = 'S', --Genera bloqueo de lectura al maestro S/N
        @i_pasinac      char(1) = 'N', --Parametro para permitir pago cheques cuentas inactivas
	@o_cuenta	int = null	out,
	@o_filial	tinyint = null	out,
	@o_oficina	smallint = null	out,
	@o_tpromedio	char(1) = null	out,
	@o_oficial	smallint = null	out,
	@o_chequeras	smallint = null	out,
	@o_cheque_ini	int = null	out,
	@o_alerta 	char(1) = null out /* CLE mensaje de alerta branch */
)
as
declare	@w_estado_cta	char(1),
	@w_sp_name	varchar(30),
	@w_rol		smallint,
	@w_nombre_nodo 	varchar(20),
	@w_status 	char(1),
	@w_monto_of	money,
	@w_mensaje      mensaje,
	@w_off_line	char(1),
	@w_filas	tinyint,
	@w_ente_bloq 	char(1),
	@w_cliente 	int,
	@w_return 	int

/*  Captura nombre de stored procedure  */
select	@w_sp_name = 'sp_cta_vigente'

/*  Modo de debug  */

/* Encuentra el rol de cajero interno */
select @w_rol = pa_smallint
from cobis..cl_parametro
where pa_producto = 'CTE'
and   pa_nemonico = 'CIN'

if @@rowcount <> 1
begin
    if @i_pit = 'S'
    begin
        select @w_mensaje = 'PARAMETRO NO ENCONTRADO'
    end
    else
    begin
        exec cobis..sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 201196
    end
   return 201196 /* GEB: Interface PIT */
end

if @i_gerencia = 'S'
begin
        select @o_cuenta = cc_ctacte,
               @o_oficina = cc_oficina
        from cob_cuentas..cc_ctacte
        where cc_cta_banco = @i_cta_banco
        return 0
end

if @i_bloqueo = 'S'
begin
   /*  Validacion de la cuenta corriente  */
   select @w_estado_cta	= cc_estado,
   	  @o_cuenta	= cc_ctacte,
   	  @o_filial	= cc_filial,
   	  @o_oficina	= cc_oficina,
   	  @o_tpromedio    = cc_tipo_promedio,
   	  @o_oficial	= cc_oficial,
   	  @o_chequeras	= cc_chequeras,
   	  @o_cheque_ini	= cc_cheque_inicial,
	  @w_cliente 	= cc_cliente
     from cob_cuentas..cc_ctacte
    where  cc_cta_banco	= @i_cta_banco
      and  cc_moneda	= @i_moneda
      and  cc_estado      != 'G'           /* Cuenta de Gerencia */
    select @w_filas = @@rowcount
end
else
begin
   /*  Validacion de la cuenta corriente  */
   select @w_estado_cta	= cc_estado,
   	  @o_cuenta	= cc_ctacte,
   	  @o_filial	= cc_filial,
   	  @o_oficina	= cc_oficina,
   	  @o_tpromedio    = cc_tipo_promedio,
   	  @o_oficial	= cc_oficial,
   	  @o_chequeras	= cc_chequeras,
   	  @o_cheque_ini	= cc_cheque_inicial,
	  @w_cliente 	= cc_cliente
     from cob_cuentas..cc_ctacte
    where  cc_cta_banco	= @i_cta_banco
      and  cc_moneda	= @i_moneda
      and  cc_estado      != 'G'           /* Cuenta de Gerencia */
    
    select @w_filas = @@rowcount
    set transaction isolation level read uncommitted
        
end

if @w_filas = 0	
begin
    /*  No existe cuenta corriente  */
    if @i_pit = 'S'
    begin
        select @w_mensaje = 'CUENTA NO EXISTE'
    end
    else
    begin
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 201004 
    end
    return 201004
end	


/***** IDENTIFICACION DE LINEA *****/

if @i_ver_nodo = 'S' and @i_pit = 'N'
begin 

  select @w_monto_of = pa_money
    from cobis..cl_parametro
   where pa_nemonico = 'MDOF' 
     and pa_producto = 'REM'
    
  --if @s_srv in ('SAFE','FX11') 
  --begin
 
  if exists(select *
              from cob_cuentas..cc_ofi_safe
             where co_oficina = @o_oficina
  and co_estado = 'V')  
  begin 

       	select @w_off_line = isnull(co_off_line,'N')
          from cob_cuentas..cc_ofi_safe
         where co_oficina = @o_oficina
           and co_estado = 'V'
                    
       	if @w_off_line = 'S' and (@i_val > @w_monto_of)
       	begin
               exec cobis..sp_cerror
               	      @t_debug = @t_debug,
                      @t_file  = @t_file,
                      @t_from  = @w_sp_name,
                      @i_num   = 208152 

               return 208152                    
    	end
  end  
  else
  begin 

     if exists(select 1 from cobis..ad_nodo_oficina
     where nl_filial = 1
       and nl_oficina = @o_oficina
      and substring(nl_nombre,1,2) = 'OF')
     begin 
  	 
        select @w_nombre_nodo = rtrim(nl_nombre)
          from cobis..ad_nodo_oficina
         where nl_oficina = @o_oficina
	  and substring(nl_nombre,1,2) = 'OF'

        if @w_nombre_nodo <> @s_srv and @s_ofi = @o_oficina
           select @w_nombre_nodo = @s_srv


        if @s_srv not in ('SAFE','FX11') 
            exec ADMIN...rp_get_commstatus @i_serverName=@w_nombre_nodo, @o_status=@w_status out


        if @w_status = 'D' and (@i_val > @w_monto_of) --servidor en f.linea
        begin 
              /*  Server Fuera de Linea  */
              if @i_pit = 'S'
              begin
                    select @w_mensaje = 'SERVER FUERA DE LINEA'
                     exec cobis..sp_cerror
                               @t_debug = @t_debug,
                               @t_file  = @t_file,
                               @t_from  = @w_sp_name,
                               @i_msg   = @w_mensaje,
                               @i_sev   = 0, --Evita hacer Rollback
                               @i_num   = 208152 
              end
              else
              begin  
        	     exec cobis..sp_cerror
               		      @t_debug = @t_debug,
               		      @t_file  = @t_file,
               		      @t_from  = @w_sp_name,
               		      @i_num   = 208152 
      	      end
      	      return 208152
  	end  

  	if @w_status = 'E' --servidor no definido
        begin 
              /* Server a Consultar No Existe */
              if @i_pit = 'S'
              begin
                    select @w_mensaje = 'SERVER A CONSULTAR NO EXISTE'
                    exec cobis..sp_cerror
                              @t_debug = @t_debug,
                               @t_file  = @t_file,
                               @t_from  = @w_sp_name,
                               @i_msg   = @w_mensaje,
                               @i_sev   = 0, --Evita hacer Rollback
                               @i_num   = 208153 
              end
              else
      	      begin
          		exec cobis..sp_cerror
               		       @t_debug = @t_debug,
               		       @t_file  = @t_file,
               		       @t_from  = @w_sp_name,
               		       @i_num   = 208153 
      	      end
      	      return 208153
   	end 
    end 
    else
    begin 
  	
         	select @w_mensaje = 'SERVER A CONSULTAR NO EXISTE'
         	exec cobis..sp_cerror
               		@t_debug = @t_debug,
               		@t_file  = @t_file,
               		@t_from  = @w_sp_name,
               		@i_msg   = @w_mensaje,
               		@i_sev   = 0, --Evita hacer Rollback
               		@i_num   = 208153 
		return 208153                 		

    end 
 end 
end 
/***** IDENTIFICACION DE LINEA *****/

if @w_estado_cta = 'I'
begin
  if @i_pasinac = 'N'
    begin
    /*  Cuenta Corriente no esta vigente  */
    if @i_pit = 'S'
    begin
        select @w_mensaje = 'CUENTA INACTIVA'
    end
    else
    begin
        exec cobis..sp_cerror	
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 201134 
    end
    return 201134 
  end
end
else
if @w_estado_cta = 'C' and @i_cau <> '2'
begin
    /*  Cuenta Corriente no esta vigente  */
    if @i_pit = 'S'
    begin
        select @w_mensaje = 'CUENTA CORRIENTE NO ESTA VIGENTE'
    end
    else
    begin
        exec cobis..sp_cerror	
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 201005 
    end
    return 201005 
end
else
if @w_estado_cta = 'P' and @w_rol != @s_rol
begin
    /*  Cuenta Corriente no esta vigente  */
    if @i_pit = 'S'
    begin
        select @w_mensaje = 'CUENTA CORRIENTE NO ESTA VIGENTE'
    end
    else
    begin
        exec cobis..sp_cerror	
             @t_debug= @t_debug,
             @t_file	= @t_file,
             @t_from	= @w_sp_name,
             @i_num	= 201005 
    end
    return 201005 
end

/*  Modo de debug, parametros de output  */

/******* CLE 07/11/2006 Mensaje de Alerta en branch *********/

select @o_alerta = 'N'

select @o_alerta = ta_alerta 
  from cob_remesas..re_trans_alerta
 where ta_transaccion 	= @t_trn
   and ta_estado	= 'V'

if @o_alerta = 'S'
begin 
   exec @w_return = cobis..sp_ente_bloqueado
	@t_trn 		= 175,
	@i_operacion 	= 'B',
 	@i_ente 	= @w_cliente,
	@o_retorno 	= @w_ente_bloq out

   if @w_return != 0
      return @w_return

   if @w_ente_bloq = 'S'
      select @o_alerta = 'S'
   else
      select @o_alerta = 'N'
end
go
IF OBJECT_ID('dbo.sp_cta_vigente') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.sp_cta_vigente >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.sp_cta_vigente >>>'
go

go
use cob_cuentas
go
