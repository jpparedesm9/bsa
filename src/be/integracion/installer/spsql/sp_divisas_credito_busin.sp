use 
cob_pac
go

IF OBJECT_ID ('dbo.sp_divisas_credito_busin') IS NOT NULL
   DROP PROCEDURE dbo.sp_divisas_credito_busin
GO

create proc [dbo].[sp_divisas_credito_busin](
   @s_date                  datetime     = null,       -- Fecha del sistema
   @s_user                  login        = null,       -- Usuario del sistema
   @s_ssn                   int          = null,       -- Secuencial unico COBIS
   @t_show_version          tinyint      = 0,          -- Versionamiento del SP
   @s_ofi                   smallint    = null,
   @t_trn                   int,
   @t_debug                 char(1)     = 'N',
   @t_file                  varchar(14) = null,
   @i_oficina               smallint    = null,        -- Oficina donde debe ser registrada la transaccion.  Afectará contablemente
   @i_modulo                char(3),                   -- Nemonico del modulo COBIS que origina la operacion de divisas
   @i_moneda_origen         tinyint      = null,         /* Moneda en la cual está expresado el monto a convertir                     */
   @i_operacion             char(1),   
   @i_valor                 money        = 0,         /* Monto a convertir                                                         */
   @i_valor_destino         money        = 0,   
   @i_moneda_destino        tinyint      = null,         /* Moneda en la cual se expresará el monto                                   */
   /*
   @i_transaccion           varchar(5)   = null,
   @i_tasa                  money        = null,
   @i_monto_cv              money        = null,*/
   @i_mon                   tinyint      = null,
   @i_moneda_cv             tinyint      = null,   
   /*@i_valor_tran            money        = null,
   @i_cot_usd               float        = 0,
   @i_factor                float        = 0,
   @i_concepto              catalogo     = null,
   @i_cliente               int          = 0,
   */
   @o_valor_convertido      money        = null out,     /* Monto equivalente en la moneda destino                                    */   
   @o_factor                float = null output,         /* Factor de relación de la moneda respecto al dólar(Tesoreria/Contabilidad) */
   @o_cotizacion            float = null output,          /* Cotizacion de la Moneda respecto a la moneda nacional                    */
   @o_valor_conver_orig     money = null output
)

as declare

  @w_sp_name                varchar(32),      --Nombre de procedure
  @w_tipo_op                estado,                      /* Tipo de Operaci¢n: Compra, Venta o Arbitraje                              */
  @w_mensaje_error          varchar(255),
  @w_mon_local              smallint,
  @w_mon_usd                smallint,
  @w_retorno                int

select @w_sp_name       = 'sp_divisas_credito_busin'
---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
begin
    print 'Stored procedure cob_remesas..sp_divisas_credito_busin, Version 1.0.0.0'
    return 0
end

if (@t_trn <> 73930 and @i_operacion = 'C')
begin
    /* No existe codigo de transaccion. */
    exec cobis..sp_cerror
            @i_num  = 101183,
            @t_from = @w_sp_name
    return 1
end



--Consulta la moneda local

select @w_mon_local = pa_tinyint
from   cobis..cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'MLO'

if @i_operacion = 'C'
begin
    select @w_mon_usd = pa_tinyint
      from cobis..cl_parametro
     where pa_producto = 'ADM'
       and pa_nemonico = 'CDOLAR'

    if @i_mon <> @w_mon_local and @i_moneda_cv <> @w_mon_local and @i_mon <> @i_moneda_cv
    begin
        exec cobis..sp_cerror  -- ERROR EN LA MONEDA DE COMPRA DE DIVISAS, ESCOJA LA MONEDA LOCAL
               @t_from = @w_sp_name,
               @i_num  = 2610063,
               @i_sev  = 0
        return 1
    end

    if @i_moneda_origen = @w_mon_local and @i_moneda_destino = @w_mon_usd
        select @i_valor_destino = @i_valor, @i_valor = 0
    else
        select @i_valor = @i_valor, @i_valor_destino = 0
		
	select @o_cotizacion = 1

    if @i_moneda_origen = @w_mon_local
        select @o_valor_convertido=@o_valor_conver_orig
end
return 0




GO