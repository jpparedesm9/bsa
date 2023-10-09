/************************************************************************/
/*      Archivo:                retfuent.sp                             */
/*      Stored procedure:       sp_rete_fuen                            */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Doris Gomez		                */
/*      Fecha de documentacion: 09-Feb-2001                             */
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
/*      Este programa realiza la consulta de la tabla pf_mov_monet      */
/*      para consultar transacciones con retencion en la fuente.        */
/*                                                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR              RAZON                             */
/*      22-Jul-09  Y. Martinez 	  Creacion                          	*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_rete_fuen')
   drop proc sp_rete_fuen
go

create proc sp_rete_fuen (
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
      @i_num_banco            cuenta          = NULL,
      @i_beneficiario         int             = NULL,
      @i_moneda               int             = NULL,
      @i_sub_secuencia        tinyint         = NULL,
      @i_tipo                 char(1)         = NULL,
      @i_producto             catalogo        = NULL,
      @i_cuenta               cuenta          = NULL,
      @i_valor                money           = NULL, 
      @i_impuesto             money           = 0, 
      @i_valor_ext            money           = NULL,
      @i_impuesto_capital_me  money           = 0,
      @i_formato_fecha	      int             = 103,
      @o_comp_inflaccionario  float	      = 0.00 out) 
with encryption
as
declare
      @w_sp_name              varchar(32),
      @w_impuesto             money,
      @w_operacionpf	      int,
      @w_valor_ext            money,       
      @w_valor                money,    
      @w_cotizacion_compra    money,   
      @w_cotizacion_venta     money,  
      @w_cotizacion_valor     money, 
      @w_cotizacion           money,
      @w_comp_inflaccionario  float 

select @w_sp_name = 'sp_rete_fuen'

if @t_debug = 'S'
   begin
      exec cobis..sp_begin_debug @t_file = @t_file
         select 
            '/** Stored Procedure **/ ' = @w_sp_name,
            s_ssn                       = @s_ssn,
            s_user                      = @s_user,
            s_sesn                      = @s_sesn,
            s_term                      = @s_term,
            s_date                      = @s_date,
            s_srv                       = @s_srv,
            s_lsrv                      = @s_lsrv,
            s_ofi                       = @s_ofi,
            s_rol                       = @s_rol,
            t_trn                       = @t_trn,
            t_file                      = @t_file,
            t_from                      = @t_from,
            i_operacion                 = @i_operacion,
            i_sub_secuencia             = @i_sub_secuencia,
            i_producto                  = @i_producto,
            i_cuenta                    = @i_cuenta,
            i_moneda                    = @i_moneda,
            i_valor                     = @i_valor,
            i_impuesto                  = @i_impuesto,
            i_valor_ext                 = @i_valor_ext
      exec cobis..sp_end_debug
   end



/**  VERIFICAR CODIGO DE TRANSACCION PARA INSERT  **/
if ( @i_operacion <> 'H' or  @t_trn <> 14471 ) 
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 141040
      return 1
   end

create table #ca_operacion_aux (
	fecha		varchar(10)	null ,
	trans		int		null,
	operacion	int		null,
	secuencia	int		null,
	benef		int		null,
	valor		money		null,
	renta		money		null,
	ica		money		null,
	no_grab		money		null
)


If @i_operacion = 'H'
   begin

	--Captura de Parametro de Componente Inflaccionario anio Gravable
	select @w_comp_inflaccionario = pa_float 
          from cobis..cl_parametro 
         where pa_nemonico = 'CIAG'

	if @@rowcount = 0
  	begin
    	    exec cobis..sp_cerror 
               @t_debug= @t_debug,
               @t_file = @t_file,
               @t_from = @w_sp_name,
               @i_num  = 141245   --No Existe Parametro de Componente Inflaccionario anio Gravable
           return 141245
  	end 


      begin tran

         select @w_operacionpf = op_operacion
         from pf_operacion
         where op_num_banco = @i_cuenta


	insert into        #ca_operacion_aux 
         select convert(varchar,mm_fecha_aplicacion,@i_formato_fecha),
          	mm_tran,
		mm_operacion,
		mm_secuencia,
		mm_beneficiario,
          	sum(mm_valor),
		sum(mm_impuesto),
          	sum(mm_ica),
		sum(round(mm_valor * (@w_comp_inflaccionario/100),0))
	from 	pf_mov_monet M 
	where 	mm_operacion 	= @w_operacionpf 
	and 	mm_fecha_aplicacion IS NOT NULL
	and	mm_estado 	= 'A'
        and 	mm_tipo   	= 'C' 
       	and 	(mm_ica 	> 0  Or	mm_impuesto > 0 )
	and	mm_tran 	in (14903, 14905) 
	group by mm_fecha_aplicacion, mm_tran, mm_operacion, mm_secuencia, mm_beneficiario

	select 	'FECHA        ' = fecha,
		'BENEFICIARIO ' = (select p_p_apellido +' '+ p_s_apellido + ' ' + en_nombre from cobis..cl_ente where en_ente = Z.benef), 
		'TRANSACCION  ' = trans,
		'VALOR        ' = (select case when Z.trans = 14903 
						then (	select 	ca_int_ganado  - ca_pen_monto      --(isnull(Z.valor,0) - (ca_monto_pg_int - isnull(ca_pen_capital,0))  )
							from 	pf_cancelacion 
							where 	ca_operacion 	= Z.operacion 
							and 	ca_secuencial  	= Z.secuencia ) 
						else 	Z.valor
						end),
		'IMPUESTO     ' = renta,
		'NO GRAVADO   ' = no_grab
	from         	#ca_operacion_aux Z

                
	if @@error <> 0
	begin
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 141075 
		return 1
	end

      select @w_comp_inflaccionario

      	commit tran
      	return 0
   end

go
