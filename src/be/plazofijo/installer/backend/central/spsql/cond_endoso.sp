/************************************************************************/
/*      Archivo:                contotop.sp                             */
/*      Stored procedure:       sp_cond_endoso				*/
/*      Base de datos:          cobis                                   */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Luis Angel Gaitan                       */
/*      Fecha de documentacion: 25-Mar-1998                             */
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
/*      Este programa trae todas la historia de las condiciones que     */
/*      tiene un titulo que ha sido endosado			        */
/************************************************************************/   
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if object_id('sp_cond_endoso') is not null
   drop proc sp_cond_endoso
go

CREATE PROCEDURE sp_cond_endoso(
@s_ssn                     int         = null,
@s_user                    login       = null,
@s_sesn                    int         = null,
@s_term                    varchar(30) = null,
@s_date                    datetime    = null,
@s_srv                     varchar(30) = null,
@s_lsrv                    varchar(30) = null,
@s_ofi                     smallint    = null,
@s_rol                     smallint    = NULL,
@t_debug                   char(1)     = 'N',
@t_file                    varchar(10) = null,
@t_from                    varchar(32) = null,
@t_trn                     smallint,
@i_num_banco               cuenta,
@i_fecha                   varchar(30),
@i_operacion               char(1))
with encryption
as
declare   
@w_sp_name                 varchar(32),
@w_codigo                  int,
@w_condicion               tinyint,  
@w_condicion_ant           tinyint,  
@w_ccondicion 	           catalogo,  
@w_ente		               int,
@w_nombre		           varchar(60),
@w_operacionpf             int
		

select @w_sp_name = 'sp_cond_endoso' 

if (@t_trn <> 14450 and @i_operacion <> 'S')
   or (@t_trn <> 14450 and @i_operacion <> 'P')
begin
	/*  'Error en codigo de transaccion' */
	exec cobis..sp_cerror
	  				@t_debug      = @t_debug,
	   				@t_file       = @t_file,
	   				@t_from       = @w_sp_name,
	   				@i_num        = 141112
	return 1
end

select 	@w_operacionpf  = op_operacion
from pf_operacion
where op_num_banco = @i_num_banco


if @@rowcount = 0
begin
  exec cobis..sp_cerror @t_debug = @t_debug, @t_file  = @t_file,
                           @t_from  = @w_sp_name, @i_num   = 141004
  return 1
end

if @i_operacion='S'
begin
  select @w_condicion = 0,@w_condicion_ant = 99
  
  select CONDICION = @w_ccondicion, ENTE = @w_ente,
         NOMBRE = @w_nombre
  into #temporal
  where 1 = 2
  
  while 1 = 1 
  begin
    set rowcount 1
    select @w_condicion=ec_condicion,   
           @w_ente=pf_endoso_cond.ec_ente, 
           @w_nombre=p_p_apellido +' '+ p_s_apellido+' '+ cobis..cl_ente.en_nombre
    from pf_endoso_cond,cobis..cl_ente 
    where ec_operacion = @w_operacionpf
      and (ec_condicion > @w_condicion or
          (ec_condicion = @w_condicion
           and pf_endoso_cond.ec_ente > @w_ente))
      and pf_endoso_cond.ec_ente = cobis..cl_ente.en_ente 
      and pf_endoso_cond.ec_fecha_crea=@i_fecha
    order by ec_condicion, ec_ente
             
    if @@rowcount = 0
      break
    
    if @w_condicion <> @w_condicion_ant 
      select @w_condicion_ant = @w_condicion,
--           @w_ccondicion = '**************'
             @w_ccondicion = 'O'
    else 
      select @w_ccondicion = 'Y'

    insert into #temporal 
		values( @w_ccondicion,@w_ente,ltrim(@w_nombre))
  end
	set rowcount 0
 	select * from #temporal
end
else
begin
	set rowcount 20
	select 	'ROL'	=	pf_endoso_prop.en_rol, 
       		'CLIENTE'=	pf_endoso_prop.en_ente,
	 	      'NOMBRE'= p_p_apellido +' '+ p_s_apellido + ' '+ cobis..cl_ente.en_nombre,
          'CEDULA'=	cobis..cl_ente.en_ced_ruc
  from pf_endoso_prop,cobis..cl_ente
	where pf_endoso_prop.en_operacion = @w_operacionpf
	  and pf_endoso_prop.en_ente = cobis..cl_ente.en_ente 
	  and pf_endoso_prop.en_fecha_crea=@i_fecha
end

return 0   

go
