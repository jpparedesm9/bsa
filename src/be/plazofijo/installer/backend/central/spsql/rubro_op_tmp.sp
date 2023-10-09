/************************************************************************/
/*      Archivo:                rubroptmp.sp                            */
/*      Stored procedure:       sp_rubro_op_tmp                         */
/*      Base de datos:          cob_pfijo                               */
/*      Disenado por:           Clotilde Vargas                         */
/*      Fecha de documentacion: 28/Jun/06                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de INSERT,UPDATE Y      */
/*      DELETE a la tabla temporal de tasas por operacion		*/
/************************************************************************/
/*      FECHA                 MODIFICACIONES            AUTOR           */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_rubro_op_tmp')
   drop proc sp_rubro_op_tmp
go

create proc sp_rubro_op_tmp (
@s_ssn                  int             = NULL,
@s_user                 login           = NULL,
@s_sesn                 int             = NULL,
@s_term                 varchar(30)     = NULL,
@s_date                 datetime        = NULL,
@s_srv                  varchar(30)     = NULL,
@s_lsrv                 varchar(30)     = NULL,
@s_ofi                  smallint        = NULL,
@s_rol                  smallint        = NULL,
@t_debug                char(1)         = 'N',
@t_file                 varchar(10)     = NULL,
@t_from                 varchar(32)     = NULL,
@t_trn                  smallint        = NULL,
@i_operacion            char(1),
@i_cuenta               cuenta          = NULL,
@i_op_operacion         int             = NULL,
@i_toperacion	        catalogo        = NULL,
@i_moneda		        smallint        = NULL,
@i_tipo_monto	        catalogo        = NULL,
@i_tipo_plazo           catalogo        = NULL,
@i_mnemonico_tasa	    catalogo        = NULL,
@i_modalidad_tasa       char(1)         = NULL,
@i_periodo_tasa         smallint        = NULL,
@i_descr_tasa           descripcion     = NULL,
@i_valor		        float           = NULL	
)
with encryption
as
declare
@i_operacionpf          int,
@w_sp_name              varchar(32),
@w_return               int
      


--------------------------------------
--  Verificar Codigo de Transaccion --
--------------------------------------
if ( @i_operacion <> 'I' or @t_trn <> 14469 ) and
   ( @i_operacion <> 'U' or @t_trn <> 14470 ) and
   ( @i_operacion <> 'S' or @t_trn <> 14469 ) and
   ( @i_operacion <> 'C' or @t_trn <> 14469 ) and
   ( @i_operacion <> 'T' or @t_trn <> 14469 ) and
   ( @i_operacion <> 'E' or @t_trn <> 14469 ) and
   ( @i_operacion <> 'R' or @t_trn <> 14469 ) and
   ( @i_operacion <> 'V' or @t_trn <> 14469 ) and
   ( @i_operacion <> 'D' or @t_trn <> 14469 ) 
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 141040
   return 141040
end


--Insertar en la tabla temporal pf_rubro_op_tmp las tasas establecidas al momento de la prorroga
if @i_operacion = 'I'
begin
      insert pf_rubro_op
		(ro_num_banco, ro_operacion,ro_concepto,ro_mnemonico_tasa,
		 ro_operador,ro_modalidad_tasa,ro_periodo_tasa,
		 ro_toperacion,ro_moneda,ro_tipo_monto,ro_tipo_plazo,
		 ro_descr_tasa,ro_spread,ro_valor
		)
      select 	rot_num_banco, rot_operacion,rot_concepto,rot_mnemonico_tasa,
		rot_operador,rot_modalidad_tasa,rot_periodo_tasa,
		rot_toperacion,rot_moneda,rot_tipo_monto,rot_tipo_plazo,
		rot_descr_tasa,rot_spread,rot_valor
      from pf_rubro_op_tmp
      where rot_operacion  = @i_op_operacion
		

end

--Insertar en la tabla temporal pf_rubro_op_tmp las tasas establecidas al momento de la prorroga
if @i_operacion = 'T'
begin
		insert pf_rubro_op_tmp 
			(rot_usuario,rot_sesion,rot_num_banco,rot_operacion,
			rot_toperacion,rot_moneda,rot_tipo_monto,rot_tipo_plazo,
			rot_concepto,rot_mnemonico_tasa,rot_operador,rot_modalidad_tasa,
			rot_periodo_tasa,rot_descr_tasa,rot_spread,rot_valor)
		select 	@s_user      ,@s_sesn   , @i_cuenta    , @i_op_operacion,
			@i_toperacion,tv_moneda , tv_tipo_monto, tv_tipo_plazo, 
			'INTERES'    ,tv_mnemonico_tasa, tv_operador,  @i_modalidad_tasa,
			@i_periodo_tasa, @i_descr_tasa, tv_spread_vigente, tv_tasa_min
		from  pf_tasa_variable
		where tv_mnemonico_prod = @i_toperacion
		  and tv_tipo_monto 	= @i_tipo_monto
                  and tv_moneda         = @i_moneda
		if @@error <> 0
		begin
			exec cobis..sp_cerror 
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = 143001
			return  143001
		end


end

--Insertar en la tabla temporal pf_rubro_op_tmp las tasas establecidas al momento de la apertura
if @i_operacion = 'C'
begin

	delete from pf_rubro_op_tmp
	where rot_operacion = @i_op_operacion

	insert pf_rubro_op_tmp (rot_usuario, rot_sesion, rot_num_banco,rot_operacion,
				rot_toperacion,rot_moneda,rot_tipo_monto,rot_tipo_plazo,
				rot_concepto,rot_mnemonico_tasa,rot_operador,rot_modalidad_tasa,
				rot_periodo_tasa,rot_descr_tasa,rot_spread,rot_valor)
	select 			@s_user      ,@s_sesn   ,ro_num_banco,  ro_operacion,
				ro_toperacion,ro_moneda,ro_tipo_monto, ro_tipo_plazo,
				ro_concepto,ro_mnemonico_tasa,ro_operador,ro_modalidad_tasa,
				ro_periodo_tasa,ro_descr_tasa,ro_spread,ro_valor
	from pf_rubro_op
	where ro_operacion  = @i_op_operacion 
      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_msg   = 'Error en insercion de tasa',
              @i_num   = 143037
         return 143037
      end

end

--Actualizacion de tabla temporal pf_rubro_op con los cambios de la pantalla de fcambtasaesc
if @i_operacion = 'U'
begin
	update pf_rubro_op_tmp
	   set rot_valor = @i_valor
	where rot_operacion 	= @i_op_operacion 
          and rot_mnemonico_tasa= @i_mnemonico_tasa
          and rot_moneda    	= @i_moneda
          and rot_tipo_plazo 	= @i_tipo_plazo
          and rot_tipo_monto 	= @i_tipo_monto  
      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_msg   = 'Error en actualizacion de tasa',
              @i_num   = 143037
         return 143037
      end
end

--Busqueda de Tabla Temporal
if @i_operacion = 'S'
begin
	select 
		 'Tipo Tasa'    = tr_tasa,
		 'Cod.Moneda'   = rot_moneda,
                 'Desc. Moneda' = convert(char(20),mo_descripcion),
                 'Tipo Monto'   = rot_tipo_monto,
                 'Tipo Plazo'   = rot_tipo_plazo,
		 'Tasa Vigente' = rot_valor
	from cobis..te_tasas_referenciales, cobis..cl_moneda,
             cob_pfijo..pf_rubro_op_tmp
        where tr_tasa 		= rot_mnemonico_tasa
          and rot_toperacion    = @i_toperacion
          and tr_estado 	= 'V'
          and rot_moneda 	= mo_moneda
          and rot_operacion     = @i_op_operacion
	order by rot_moneda,rot_toperacion, rot_mnemonico_tasa ,
                 rot_tipo_monto, rot_tipo_plazo   	

end

--Busqueda de Tabla Definitiva
if @i_operacion = 'V'
begin
	select  'Tasa Vigente' = ro_valor
	from  cob_pfijo..pf_rubro_op
        where ro_num_banco   = @i_cuenta
	order by ro_tipo_plazo   	

end


--Insertar en la tabla temporal pf_rubro_op_tmp lo que se almaceno en la instruccion
if @i_operacion = 'R'
begin
	insert pf_rubro_op_tmp (rot_usuario, rot_sesion, rot_num_banco,rot_operacion,
				rot_toperacion,rot_moneda,rot_tipo_monto,rot_tipo_plazo,
				rot_concepto,rot_mnemonico_tasa,rot_operador,rot_modalidad_tasa,
				rot_periodo_tasa,rot_descr_tasa,rot_spread,rot_valor)
	select 			@s_user      ,@s_sesn   ,roi_num_banco,  roi_operacion,
				roi_toperacion,roi_moneda,roi_tipo_monto, roi_tipo_plazo,
				roi_concepto,roi_mnemonico_tasa,roi_operador,roi_modalidad_tasa,
				roi_periodo_tasa,roi_descr_tasa,roi_spread,roi_valor
	from pf_rubro_op_i
	where roi_operacion  = @i_op_operacion 
      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_msg   = 'Error en insercion de tasa',
              @i_num   = 143037
         return 143037
      end

end


--Eliminacion de tabla temporal
if @i_operacion = 'D'
begin
	delete from pf_rubro_op_tmp
	where rot_operacion = @i_op_operacion
end


--Eliminacion de tabla temporal
if @i_operacion = 'E'
begin
	delete from pf_rubro_op
	where ro_operacion = @i_op_operacion
end

return 0
go
