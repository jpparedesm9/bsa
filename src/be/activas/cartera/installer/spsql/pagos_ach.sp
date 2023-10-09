 /************************************************************************/
/*      Archivo:                pagos_ach.sp                            */
/*      Stored procedure:       sp_pagos_ach                            */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Etna Johana Laguna R.                   */
/*      Fecha de escritura:     25-Feb-2002                             */
/************************************************************************/
/*                            IMPORTANTE                                */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes  exclusivos  para el  Ecuador  de la     */
/*    "NCR CORPORATION".                                                */
/*    Su  uso no autorizado  queda expresamente  prohibido asi como     */
/*    cualquier   alteracion  o  agregado  hecho por  alguno de sus     */
/*    usuarios   sin el debido  consentimiento  por  escrito  de la     */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/*                             PROPOSITO                                */
/*    Este programa procesa la aplicacion de pagos de Cartera que han   */
/*    sido generados por ACH						*/
/*                           MODIFICACIONES                             */
/*    FECHA           AUTOR            RAZON                            */
/*    25/Feb/2002     E. Laguna        Emision Inicial                  */
/*    26/Mar/2002     E. Laguna        Manejo de error 			*/
/************************************************************************/
use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_pagos_ach')
   drop proc sp_pagos_ach
go

create proc sp_pagos_ach(
       	@s_user		login = null,
	@s_sesn	 	int = null,
        @s_ssn          int = null,
       	@s_term		varchar(30) = null,
       	@s_date		datetime = null,
       	@s_srv		varchar(30) = null,
       	@s_lsrv		varchar(30) = null,
       	@s_ofi		smallint = null,
	@s_rol		smallint = NULL,
	@s_org_err	char(1) = NULL,
	@s_error	int = NULL,
	@s_sev		tinyint = NULL,
	@s_msg		descripcion = NULL,
	@s_org		char(1) = NULL,
       	@t_debug	char(1) = 'N',
       	@t_file		varchar(10) = null,
       	@t_from		varchar(32) = null,
       	@t_trn		smallint = null)


as declare


/** GENERALES **/
	@w_return	 	int,
	@w_error         	int,
	@w_parametro	 	money, 
	@w_sp_name	 	descripcion,
	@w_fecha_proceso 	datetime,
        @w_fecha_ult_proceso    datetime,
	@w_operacion		int,
	@w_secuencial_ing	int,
	@w_fecha_ing		datetime,
	@w_concepto		catalogo,
	@w_inscripcion		int,
	@w_valor                money,
        @w_secuencial_ach       int,
	@w_sec  		int,
       	@w_lsrv		        char(15),
	@w_ente_orig 		int,
	@w_ced_ruc_orig         varchar(15),
	@w_cuenta_orig          varchar(17),
	@w_tipo_cta_orig        varchar(3),
	@w_nom_cliente_orig     varchar(50),
	@w_descripcion          varchar(255),
        @w_desc_adenda          varchar(80),
	@w_carga		int,
        @w_moneda_nacional      tinyint
	

     
select @w_sp_name = 'sp_pagos_ach'


select @w_fecha_proceso = fc_fecha_cierre 
from cobis..ba_fecha_cierre
where fc_producto = 7

select @w_lsrv = pa_char
from cobis..cl_parametro
where pa_nemonico = 'SRVR'
and pa_producto  = 'ADM'
set transaction isolation level read uncommitted


select @w_moneda_nacional = pa_tinyint
from cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'MLO'
set transaction isolation level read uncommitted

 /* Encuentra el SSN inicial */

  select @w_sec = se_numero
    from cobis..ba_secuencial

  if @@rowcount <> 1
  begin
      /* Error en lectura de SSN */
      exec cobis..sp_cerror
           @i_num       = 201163
      return 201163
  end

  update cobis..ba_secuencial
     set se_numero = @w_sec + 100

  if @@rowcount <> 1
    begin
      
 /* Error en actualizacion de SSN */
      exec cobis..sp_cerror
           @i_num       = 205031
      return 205031
    end

/** PARCHADO HASTA CUANDO SE DECIDA UTILIZAR -- JCQ -- 10/10/2002 **/
/**

/** LECTURA DE PAGOS PENDIENTES DE APLICAR **/
declare cursor_pagos_ach cursor for select 
	ab_operacion,
	ab_secuencial_ing,
	ab_fecha_ing,
        op_fecha_ult_proceso ,
	abd_concepto,
	abd_inscripcion,
	or_valor ,
	or_cont_tran,
	or_ente_orig,
	or_ced_ruc_orig,
	or_cuenta_orig,
	or_tipo_cta_orig,
	or_nom_cliente_orig,
	or_descripcion,
	or_desc_adenda,
        op_moneda
from cob_cartera..ca_abono,
     cob_cartera..ca_abono_det,
     cob_cartera..ca_operacion,
     cob_ach..ach_originador
where ab_operacion = abd_operacion
and   ab_operacion  = op_operacion
and ab_secuencial_ing = abd_secuencial_ing
and abd_concepto = 'NDACH'
and ab_estado = 'NA'
and ab_dias_retencion_ini = 99
and ab_dias_retencion = 99
and abd_inscripcion not in(null,0)
and abd_carga in(null,0)
and abd_inscripcion = or_cont_tran
for read only

open cursor_pagos_ach


fetch cursor_pagos_ach into
	@w_operacion,
	@w_secuencial_ing,
	@w_fecha_ing,
        @w_fecha_ult_proceso ,
	@w_concepto,
	@w_inscripcion,
	@w_valor,
	@w_secuencial_ach,
	@w_ente_orig,
	@w_ced_ruc_orig,
	@w_cuenta_orig,
	@w_tipo_cta_orig,
	@w_nom_cliente_orig,
	@w_descripcion,
	@w_desc_adenda,
        @w_moneda

while @@fetch_status = 0 
begin

   if (@@fetch_status = -1) 
   begin
      select @w_error = 143049 --OJO CAMBIAR EL CODIGO DE ERROR 
      --goto ERROR
   end


   if @w_operacion is not null
   begin
	   exec @w_return    = cob_ach..sp_originador
		@s_ssn		      = @w_sec,
		@s_srv		      = @s_srv,
		@s_lsrv		      = @w_lsrv,
		@s_user		      = 'sa',
		@s_sesn		      = @w_sec,
		@s_term		      = 'consola',
		@s_date		      = @w_fecha_proceso,
		@s_org		      = @s_org, 
		@s_ofi		      = 900,
    		@t_trn                = 20414,
		@i_operacion          = 'I',
    		@i_valor              = @w_valor,
    		@i_servicio           = 'CAR',
	        @i_origen	      = @w_secuencial_ach,
    		@i_ente_orig          = @w_ente_orig,
    		@i_modulo             = 7,
    		@i_ced_ruc_orig       = @w_ced_ruc_orig,
    		@i_cuenta_orig        = @w_cuenta_orig,
    		@i_tipo_cta_orig      = @w_tipo_cta_orig,
    		@i_nom_cliente_orig   = @w_nom_cliente_orig,
    		@i_descripcion        = @w_descripcion,
    		@i_adenda             = 'S',
    		@i_desc_adenda        = @w_desc_adenda,
                @i_en_linea           = 'N', /* Bandera para manejo de error - controla ACH */
                @o_cont_tran          = @w_carga out


         if @w_return != 0 
         begin
           select @w_error = @w_return
         goto ERROR
         end 
         else
         begin



     /* DETERMINAR EL VALOR DE COTIZACION DEL DIA */
      if @w_moneda = @w_moneda_nacional
         select @w_cotizacion_hoy = 1.0
      else
      begin
         exec sp_buscar_cotizacion
              @i_moneda     = @w_moneda,
              @i_fecha      = @w_fecha_ult_proceso,
              @o_cotizacion = @w_cotizacion_hoy output
      end

 


	    update cob_cartera..ca_abono
	    set ab_dias_retencion_ini = 0,
	        ab_dias_retencion = 0
	    where ab_operacion       = @w_operacion
	    and   ab_secuencial_ing  = @w_secuencial_ing

	    update cob_cartera..ca_abono_det
	    set abd_carga = @w_carga
	    where abd_operacion       = @w_operacion
	    and   abd_secuencial_ing  = @w_secuencial_ing
	    and   abd_inscripcion     = @w_secuencial_ach

      /** APLICACION EN LINEA DEL PAGO SIN RETENCION **/

            exec @w_return = sp_cartera_abono
            @s_user           = @s_user,
            @s_srv 	      = @s_srv,             
            @s_term           = @s_term,
            @s_date           = @s_date,
            @s_sesn           = @s_sesn,
            @s_ssn            = @s_ssn,
            @s_ofi            = @s_ofi,
            @i_secuencial_ing = @w_secuencial_ing,
            @i_operacionca    = @w_operacion,
            @i_fecha_proceso  = @w_fecha_ult_proceso,
            @i_en_linea       = 'N',
   	    @i_dividendo      = 0 ,
            @i_cotizacion     = @w_cotizacion_hoy

            if @w_return !=0 begin 
               print '(ingaboin.sp) error  al ejecutar abonoca...' 
             return @w_return
             end


	select @w_sec = @w_sec +1

end
      ERROR:
  /*    exec sp_errorlog
      @i_fecha         = @w_fecha_proceso,
      @i_error         = @w_error,
      @i_usuario       = 'sa',
      @i_tran          = 20414,
      @i_tran_name     = @w_sp_name,
      @i_cuenta        = @w_cuenta_orig,
      @i_rollback      = 'S' 
      --while @@trancount > 0 rollback tran
      --goto SIGUIENTE                       */
    --print 'ERRORRORORORORORROOROR'
 

	--  SIGUIENTE:
	--   select @w_ente_aux = @w_ente_orig

 end 



fetch cursor_pagos_ach into
	@w_operacion,
	@w_secuencial_ing,
	@w_fecha_ing,
        @w_fecha_ult_proceso,
	@w_concepto,
	@w_inscripcion,
	@w_valor,
	@w_secuencial_ach,
	@w_ente_orig,
	@w_ced_ruc_orig,
	@w_cuenta_orig,
	@w_tipo_cta_orig,
	@w_nom_cliente_orig,
	@w_descripcion,
	@w_desc_adenda
        @w_moneda

end

close cursor_pagos_ach
deallocate cursor_pagos_ach

**/

return 0
go
