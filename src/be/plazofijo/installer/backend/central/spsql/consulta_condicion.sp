/************************************************************************/
/*      Archivo:                rencondi.sp                             */
/*      Stored procedure:       sp_consulta_condicion                   */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 07/Sep/95                               */
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
/*      Este procedimiento almacenado realiza las consultas             */
/*      de las condiciones y sus detalles de una operacion              */
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
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

if exists (select 1 from sysobjects where name = 'sp_consulta_condicion')
   drop proc sp_consulta_condicion
go

create proc sp_consulta_condicion (
		@s_ssn                  int = null,
		@s_user                 login = null,
		@s_sesn			int = null,
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
		@i_operacion     	char(1),
		@i_num_banco  		cuenta
)
with encryption
as
/*  Variables para pf_operacion  */
declare         @w_sp_name              varchar(32),
		@w_codigo               int,
		@w_pri_condicion        tinyint,   --xca
		@w_condicion            tinyint,  
		@w_condicion_ant        tinyint,  
		@w_ccondicion        	catalogo,  
		@w_ente			int,
		@w_nombre		varchar(60),
		@w_operacionpf          int


select @w_sp_name = 'sp_consulta_condicion' 
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file = @t_file
	 select '/** Stored Procedure **/ '= @w_sp_name,
		s_ssn                      = @s_ssn,
		s_sesn			   = @s_sesn,
		s_user                     = @s_user,
		s_term                     = @s_term,
		s_date                     = @s_date,
		s_srv                      = @s_srv,
		s_lsrv                     = @s_lsrv,
		s_ofi                      = @s_ofi,
		s_rol                      = @s_rol,
		t_trn                      = @t_trn,
		t_file                     = @t_file,
		t_from                     = @t_from,
		i_operacion                = @i_operacion,
		i_num_banco		   = @i_num_banco
    exec cobis..sp_end_debug
end

  if @t_trn <> 14641 and @i_operacion <> 'H'
      begin
	exec cobis..sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 141112
	   /*  'Error en codigo de transaccion' */
	   return 1
      end

select @w_pri_condicion = 0

select 	@w_operacionpf  = op_operacion
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

If @i_operacion = 'H'
  begin
   select @w_condicion = 0,
          @w_condicion_ant = 99

   select CONDICION = @w_ccondicion,
	  COD_CLIENTE = @w_ente,
	  NOMBRE = @w_nombre
   into #temporal
   where 1= 2

   while 1 =1 
	begin
            select @w_pri_condicion = @w_pri_condicion + 1 
	     set rowcount 1
             select @w_condicion=dc_condicion,   
                    @w_ente=dc_ente, 
		    @w_nombre=p_p_apellido +' '+ p_s_apellido+' '+en_nombre
   	       from pf_det_condicion,cobis..cl_ente 
	       where dc_operacion = @w_operacionpf
		    and (dc_condicion > @w_condicion or
		        (dc_condicion = @w_condicion
		        and dc_ente > @w_ente))
		    and dc_ente = en_ente 
	 	    and dc_estado_xren = 'N'
    		order by dc_condicion, dc_ente
              if @@rowcount = 0
			break
              if @w_condicion <> @w_condicion_ant 
                begin
                  if @w_pri_condicion = 1 --xca
			select @w_condicion_ant = @w_condicion, --xca
				@w_ccondicion = '' --xca
                  else --xca
			select @w_condicion_ant = @w_condicion,
				--@w_ccondicion = '**************'
				@w_ccondicion = 'O'
                end
	      else 
			select @w_ccondicion = 'Y'
			--select @w_ccondicion = ''
 	      insert into #temporal 
                          values( @w_ccondicion,@w_ente,ltrim(@w_nombre))
          end
     set rowcount 0
     select @w_pri_condicion = 0
     select * from #temporal
   end		
return 0   
go
