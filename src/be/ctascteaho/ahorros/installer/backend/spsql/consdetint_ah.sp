
USE cob_ahorros_his
go



/***********************************************************************/
/*  Archivo:            ahconsint.sp                                   */
/*  Stored procedure:   sp_consdetint_ah                               */
/*  Base de datos:      cob_ahorros_his                                */
/*  Producto:           Cuentas de Ahorros                             */
/*  Disenado por:       Bruno Cristella                                */
/*  Fecha de escritura: 22-Mar-2005                                    */
/***********************************************************************/
/*                              IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*  de COBISCorp.                                                      */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como   */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus   */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.  */
/*  Este programa esta protegido por la ley de   derechos de autor     */
/*  y por las    convenciones  internacionales   de  propiedad inte-   */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para*/
/*  obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*  penalmente a los autores de cualquier   infraccion.                */
/***********************************************************************/
/*                              PROPOSITO                              */
/* Consulta detalle de Intereses.                                      */
/***********************************************************************/
/*                          MODIFICACIONES                             */
/*  FECHA          AUTOR            RAZON                              */
/*  02/Mayo/2016   Walther Toledo   Migración a CEN                    */
/***********************************************************************/

/****** Object:  StoredProcedure sp_consdetint_ah    Script Date: 04/05/2016 15:26:42 ******/
SET ANSI_NULLS OFF
go


SET QUOTED_IDENTIFIER OFF
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_consdetint_ah')
  drop proc sp_consdetint_ah
go

CREATE proc sp_consdetint_ah (
    @s_ssn                  int             = NULL,
    @s_user                 login           = NULL,
    @s_term                 varchar(30)     = NULL,
    @s_date                 datetime        = NULL,
    @s_srv                  varchar(30)     = NULL,
    @s_lsrv                 varchar(30)     = NULL,
    @s_ofi                  smallint        = NULL,
    @s_rol                  smallint        = NULL,
    @t_debug                char(1)         = 'N',
    @t_file                 varchar(10)     = NULL,
    @t_from                 varchar(32)     = NULL,
    @t_trn                  smallint,
    @t_show_version         bit   = 0,
    @i_modo                 int             = null,
    @i_cta_banco            char(16)        = null,
    @i_fecha_desde          datetime        = null,
    @i_fecha_hasta          datetime        = null,
    @i_corresponsal         char(1)         = 'N'  --Req. 381 CB Red Posicionada
)
as
declare @w_sp_name varchar(32),
        @w_cuenta  int,
        @w_prod_bancario   varchar(50) --Req. 381 CB Red Posicionada

select @w_sp_name = 'sp_consdetint_ah'

    ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
    if @t_show_version = 1
    begin
        print 'Stored Procedure='+@w_sp_name+' Version=4.0.0.0'
        return 0
    end

--  Verificar Codigo de Transaccion
if @t_trn <> 343
begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 101001
    return 1
end

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

-- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
if @i_corresponsal = 'N'
begin
   -- Obtengo la Cuenta a partir de la Cuenta Banco
   select @w_cuenta = ah_cuenta
   from cob_ahorros..ah_cuenta
   where ah_cta_banco = @i_cta_banco
   and ah_prod_banc   <> @w_prod_bancario -- Req. 381 CB Red Posicionada

   if @@rowcount = 0
   begin
      -- No existe cuenta de ahorro
      exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = 251001
      return 251001
   end

   -- Traer los resultados de 20 en 20
   set rowcount 20

   select '9002' = convert(varchar(10), sd_fecha, 103),      -- 'FECHA'          
          '9943' = sd_saldo_disponible,                      -- 'SDO. DISPONIBLE'
          '9040' = sd_12h + sd_24h + sd_48h + sd_remesas,    -- 'SDO. RETENIDO'  
          '9944' = sd_prom_disponible,                       -- 'SDO. PROMDISP'  
          '9041' = sd_tasa_disponible,                       -- 'VALOR TASA INT.'
          '9042' = sd_int_hoy,                               -- 'VALOR INT.'     
          '9945' = sd_dias                                   -- 'DIAS'        
   from ah_saldo_diario
   where sd_cuenta = @w_cuenta
   and sd_fecha >= @i_fecha_desde
   and sd_fecha <= @i_fecha_hasta
   and sd_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
   order by sd_fecha, sd_cuenta, sd_saldo_disponible, sd_12h, sd_24h, sd_48h, sd_remesas, sd_prom_disponible, sd_tasa_disponible, sd_int_hoy, sd_dias

   set rowcount 0
   select 20
end
else
begin
   -- Obtengo la Cuenta a partir de la Cuenta Banco
   select @w_cuenta = ah_cuenta
   from cob_ahorros..ah_cuenta
   where ah_cta_banco = @i_cta_banco

   if @@rowcount = 0
   begin
      -- No existe cuenta de ahorro
      exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file = @t_file,
      @t_from = @w_sp_name,
      @i_num  = 251001
      return 251001
   end

   -- Traer los resultados de 20 en 20
   set rowcount 20

   select '9002' = convert(varchar(10), sd_fecha, 103),      -- 'FECHA'          
          '9943' = sd_saldo_disponible,                      -- 'SDO. DISPONIBLE'
          '9040' = sd_12h + sd_24h + sd_48h + sd_remesas,    -- 'SDO. RETENIDO'  
          '9944' = sd_prom_disponible,                       -- 'SDO. PROMDISP'  
          '9041' = sd_tasa_disponible,                       -- 'VALOR TASA INT.'
          '9042' = sd_int_hoy,                               -- 'VALOR INT.'     
          '9945' = sd_dias                                   -- 'DIAS'        
   from ah_saldo_diario
   where sd_cuenta = @w_cuenta
   and sd_fecha >= @i_fecha_desde
   and sd_fecha <= @i_fecha_hasta
   order by sd_fecha, sd_cuenta, sd_saldo_disponible, sd_12h, sd_24h, sd_48h, sd_remesas, sd_prom_disponible, sd_tasa_disponible, sd_int_hoy, sd_dias

   set rowcount 0
   select 20
end

return 0


go

