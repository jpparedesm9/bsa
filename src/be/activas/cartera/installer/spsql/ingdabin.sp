/************************************************************************/
/*   Archivo:               ingdabin.sp                                 */
/*   Stored procedure:      sp_ing_detabono_int                         */
/*   Base de datos:         cob_cartera                                 */
/*   Producto:              Cartera                                     */
/*   Disenado por:          R. Garces                                   */
/*   Fecha de escritura:    Feb. 1995                                   */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA".                                                          */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   Ingresar los detalles de abonos temporales para llamadas de otro   */
/*   sp                                                                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   28/08/2019     A. ORTIZ    REQ. 118442 FORMAS DE PAGO              */
/*   08/06/2020     D. Cumbal   Req. Condonacion rubros desplazados     */
/************************************************************************/

use cob_cartera
go
                    
if exists (select 1 from sysobjects where name = 'sp_ing_detabono_int')
   drop proc sp_ing_detabono_int
go

---LS-36266 partiendo de la version 7

create proc sp_ing_detabono_int
       @s_user                 login       = null,
       @s_date                 datetime    = null,
       @s_sesn                 int         = null,
	   @s_ofi				       INT         = NULL,
       @s_term                 descripcion  = null, 
       @i_accion               char(1),
       @i_encerar              char(1),
       @i_tipo                 char(3),    
       @i_concepto             catalogo,
       @i_cuenta               cuenta      = '',
       @i_moneda               int         = null,
       @i_beneficiario         descripcion = '',
       @i_monto_mpg            money       = 0,    
       @i_monto_mop            money       = null,    
       @i_monto_mn             money       = null, 
       @i_cotizacion_mpg       money       = null,
       @i_cotizacion_mop       money       = null,  
       @i_tcotizacion_mpg      char(1)     = null,
       @i_tcotizacion_mop      char(1)     = null,
       @i_no_cheque            int         = null, 
       @i_cod_banco            catalogo    = null, 
       @i_inscripcion          int         = null, 
       @i_carga                int         = null,
       @i_banco                cuenta      = null,
       @i_factura              char(16)    = null,
       @i_porcentaje           float       = null,
       @i_crear_alterna        char(1)     = 'N',
       @i_fecha_vig            datetime    = NULL


as declare
       @w_sp_name              descripcion,
       @w_fecha_hoy            datetime,
       @w_error                int,
       @w_num_periodo_d        smallint,
       @w_periodo_d            catalogo,
       @w_valor_pagado         money,
       @w_fecha_proceso        datetime,
       @w_valor_dia_rubro      money,
       @w_dias_div             int,
       @w_di_fecha_ven         datetime,
       @w_dias_faltan_cuota    int,
       @w_devolucion           money,
       @w_est_vigente          smallint,
       @w_operacion            int,
       @w_div_vigente          smallint,
       @w_valor_rubro          money,
       @w_concepto             catalogo,
       @w_num_dec              smallint,
       @w_moneda_nacional      smallint,
       @w_cotizacion_mpg       float,
       @w_cotizacion_mop       float,
       @w_tcot_moneda          char(1),
       @w_tcotizacion_mpg      char(1),
       @w_beneficiario         char(50),
       @w_monto_mop            money,
       @w_monto_mn             money,
       @w_return               int,
       @w_cot_moneda           float,
       @w_moneda_op            smallint,
       @w_afectacion           char(1),
       @w_vlr_condonacion      money,
       @w_operacionca          int,
       @w_msg                  varchar(100)


---NOMBRE DEL SP Y FECHA DE HOY 
select  @w_sp_name   = 'sp_ing_detabono_int',
        @w_fecha_hoy = convert(varchar,@s_date,101)


---ESTADOS PARA CARTERA 
select
@w_est_vigente   = 1,
@w_devolucion    = 0


/*NUMERO DE DECIMALES*/
exec sp_decimales
@i_moneda    = @i_moneda,
@o_decimales = @w_num_dec out


select @w_num_dec = isnull(@w_num_dec,0)

select @w_moneda_nacional = pa_tinyint
from  cobis..cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'MLO'
set transaction isolation level read uncommitted


if @i_accion = 'I' begin -- (I)ngresar  
   ---SI SE TRATA DE LA PRIMERA INSERCION, ELIMINAR LA TABLA 
   if @i_encerar = 'S'   begin
      delete ca_abono_det_tmp
      where  abdt_user = @s_user
      and    abdt_sesn = @s_sesn
      if @@error <> 0 return 71003
   end

   ---VALIDACION DEL MAXIMO VALOR DE CONDONACION POR INT O IMO
   if @i_tipo = 'CON'     
   begin
        
       select @w_vlr_condonacion = sum(am_cuota + am_gracia - am_pagado)
       from  ca_operacion, ca_dividendo,ca_amortizacion
       where op_banco     = @i_banco
       and   di_operacion = op_operacion
       and   di_estado    in (0,1,2)
       and   am_operacion = op_operacion
       and   am_dividendo = di_dividendo
       and   am_concepto  = @i_concepto
       
       if @w_vlr_condonacion < @i_monto_mpg return 708139
 
       if @i_monto_mn <= 0
       begin
	     select @i_monto_mn = round(@i_monto_mpg * @i_cotizacion_mop,@w_moneda_nacional)
       end
	      
       if @i_monto_mn <= 0
       begin
          PRINT 'ingdabin.sp  EL valor Condonado @i_monto_mn llega  en 0  ' + cast(@i_monto_mn as varchar)
          return 703070
       end
       
     
   end
   
   if @i_tipo = 'SOB'     --SOBRANTE
   begin
      select 
      @i_monto_mn  = -1*@i_monto_mn,
      @i_monto_mpg = -1*@i_monto_mpg,
      @i_monto_mop = -1*@i_monto_mop
       
      select @w_afectacion = cp_afectacion
      from ca_producto
      where  cp_producto = @i_concepto

      if @w_afectacion = 'D'
         return 710462

   end
 
   ---CUANDO ESTA VARABLE LLEGA EN S NO SE HA UTILIZADO CHEQUE
   ---POR TANTO SE REUTILIZA EL CAMPO DE BANCO PARA ALMACENAR LA
   ---MARCACION DE CREAR ALTERNA  QUE LEGARA EN S/N
   
   if @i_crear_alterna = 'S'
      select @i_cod_banco = 'S'
   
   --INSERCION DE CA_ABONO_DET_TMP 
   insert into ca_abono_det_tmp(
   abdt_user,             abdt_sesn,             abdt_moneda,
   abdt_tipo,             abdt_concepto,         abdt_cuenta,
   abdt_beneficiario,     abdt_monto_mpg,        abdt_monto_mop,
   abdt_monto_mn,         abdt_cotizacion_mpg,   abdt_cotizacion_mop,
   abdt_tcotizacion_mpg,  abdt_tcotizacion_mop,  abdt_cheque,
   abdt_cod_banco,        abdt_inscripcion,      abdt_carga,
   abdt_porcentaje_con)                          
   values (                                      
   @s_user,               @s_sesn,               @i_moneda,
   @i_tipo,               @i_concepto,           isnull(@i_cuenta,''),
   @i_factura,            @i_monto_mpg,          @i_monto_mop,
   @i_monto_mn,           @i_cotizacion_mpg,     @i_cotizacion_mop,
   @i_tcotizacion_mpg,    @i_tcotizacion_mop,    @i_no_cheque,
   @i_cod_banco,          @i_inscripcion,        @i_carga,
   @i_porcentaje)  

   if @@error <> 0
      return 710216  
end



if @i_accion = 'D' -- Eliminar
begin
   if not exists (select 1
                  from   ca_abono_det_tmp
                  where  abdt_user     = @s_user
                  and    abdt_sesn     = @s_sesn 
                  and    abdt_tipo     = @i_tipo
                  and    abdt_concepto = @i_concepto)
   begin
      return  710344
   end

   delete ca_abono_det_tmp 
   where  abdt_user     = @s_user
   and    abdt_sesn     = @s_sesn
   and    abdt_tipo     = @i_tipo
   and    abdt_concepto = @i_concepto

   if @@error <> 0 return 71003

end


if @i_accion = 'G' 
begin
	if @i_concepto in('GAR_DEB','FALLECIDO')
	begin
		return 710610
	end
	
    select @w_fecha_proceso = fp_fecha 
    from cobis..ba_fecha_proceso
    
    if @i_fecha_vig > @w_fecha_proceso begin
        --La Fecha valor es mayor a la fecha proceso
        return 701192
    end
    
    if (exists(select 1 from cobis..cl_dias_feriados 
               where df_ciudad = (select pa_int from cobis..cl_parametro where pa_nemonico = 'CIUN' and pa_producto = 'ADM')
               and   df_fecha  = @i_fecha_vig))
    begin
       return 708144
    end
    
    select 
    @w_operacionca = op_operacion
    from ca_operacion 
    where op_banco = @i_banco

    insert into ca_corresponsal_trn (
    co_corresponsal  , co_tipo         , co_codigo_interno     , co_fecha_proceso      , co_fecha_valor, 
    co_referencia    , co_moneda       , co_monto              , co_status_srv         , co_estado, 
    co_error_id      , co_error_msg    , co_accion             , co_login              , co_terminal,
    co_fecha_real)
    values (
    @i_concepto      , 'PG'            , @w_operacionca        , @w_fecha_proceso      , @i_fecha_vig, 
    @i_banco         , @i_moneda       , @i_monto_mpg          , null                  , 'I'         , 
    0                , ''              , 'I'                   , @s_user               , @s_term     ,
    getdate()) 
    
    if @@error != 0 return 710001
    
    update ca_corresponsal_trn 
    set co_trn_id_corresp = co_secuencial
    where co_referencia = @i_banco 
    and co_trn_id_corresp is null 
    
    if @@error != 0 return 710001

end

return 0

ERROR: 
	exec cobis..sp_cerror
     @t_debug = 'N',
     @t_file = null,
     @t_from  = @w_sp_name,
     @i_num = @w_error,
	 @i_msg = @w_msg
	 
return @w_error

go

