/************************************************************************/
/*      Archivo:                paga_cuota_navidad.sp                   */
/*      Stored procedure:       sp_paga_cuota_navidad                   */
/*      Base de datos:          cob_ahorros                             */
/*      Producto: Cuentas de Ahorros                                    */
/*      Disenado para:  Global Bank - Panama                            */
/*      Fecha de escritura: 23-Mar-2005                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este procedimiento realiza el pago de las cuotas de Navidad     */
/*      si la cuenta ha cumplido con todos los períodos acordados      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*  15/Abr/2005   A. Villarreal   Emision inicial                       */
/*  24/Ago/2005   P. Coello       Considerar pago de cuentas            */
/*                                individuales                          */
/*  17/Feb/2010   J. Loyo         Manejo de la fecha de efectivizacion  */
/*                                teniendo el sabado como habil         */
/*  02/May/2016   Juan Tagle      Migraci�n a CEN                       */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_paga_cuota_navidad')
    drop proc sp_paga_cuota_navidad
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_paga_cuota_navidad (
       @s_ofi         varchar(30),
       @s_srv         varchar(30),
       @s_date        datetime,
       @t_show_version  bit = 0,
       @o_procesadas  int = null out
)
as

declare @w_return               int,
        @w_semanas              tinyint,
        @w_sem_gratis           tinyint,
        @w_mensaje              char(60),
        @w_cuenta               int,
        @w_cta_banco            varchar(24),
        @w_oficina              smallint,
        @w_moneda               tinyint,
        @w_contable             money,
        @w_cuota                catalogo,
        @w_per_inicial          datetime,
        @w_fecha                datetime,
        @w_pago                 money,
        @w_total                money,
        @w_ssn                  money,
        @w_fec_pago             datetime,
        @w_ciudad_matriz        int,
        @w_relacion             char(1),
        @w_cuota_gratis         char(1),
        @w_fecha_cuota          datetime,
        @w_codigo               smallint,
        @w_contador             int,
        @w_sp_name              varchar(30)


/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_paga_cuota_navidad'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_contador = 0

/*** Este valor se devuelve en el sp_fecha_habil   ***/
-- La ciudad matriz para verificar feriados
--select @w_ciudad_matriz = pa_int
--  from cobis..cl_parametro
-- where pa_producto = 'CTE'
--   and pa_nemonico = 'CMA'
--
--if @@rowcount <> 1
--begin
--   exec cobis..sp_cerror
--        @i_num       = 201196
--   return 1
--end

-- Siguiente fecha laborable, es generica y no depende de la fecha de hoy
--select @w_fecha = dateadd(dd, 1, @s_date)
--while 1=1
--  if exists (select df_fecha
--               from cobis..cl_dias_feriados
--              where df_ciudad = @w_ciudad_matriz
--                and df_fecha  = @w_fecha)
--    select @w_fecha = dateadd(dd, 1, @w_fecha)
--  else
--    break


/*** La determinacion del siguiente dia laboral  se             ****/
/*** hace mediante el llamado al siguiente sp  - JLOYO          ****/
    exec @w_return = cob_remesas..sp_fecha_habil
            @i_val_dif  = 'N',
            @i_efec_dia = 'S',
            @i_fecha    = @s_date,
            @i_oficina  =  @s_ofi,
            @i_dif  = 'N',    /**** Ingreso en  horario normal  ***/
            @w_dias_ret = 1,      /*** Dia siguiente habil            ***/
            @o_ciudad_matriz   = @w_ciudad_matriz    out,
            @o_fecha_sig= @w_fecha out

    if @w_return <> 0
        return @w_return


if @w_fecha is null
  begin
     exec cobis..sp_cerror
          @i_num          = 125013
     return 1
  end

-- La fecha en la que se va a pagar las semanas de navidad
select @w_fec_pago = dateadd(yy, datediff(yy, pa_datetime, @s_date), pa_datetime)
  from cobis..cl_parametro
 where pa_producto = 'AHO'
   and pa_nemonico = 'FEPACN'

if @@rowcount = 0
  begin
     exec cobis..sp_cerror
          @i_num    = 253070,
          @i_msg    = 'PARAMETRO DE FECHA PAGO DE NAVIDAD, NO EXISTE'
     return 253070
  end

select @w_relacion = 'N'
if @w_fec_pago >= @w_fecha -- Se paga solo para los codigos de relacion elegidos
   select @w_relacion = 'S'

-- Las semanas que deben estar completas para poder pagar
select @w_semanas = pa_tinyint
  from cobis..cl_parametro
 where pa_producto = 'AHO'
   and pa_nemonico = 'SECOCN'
if @@rowcount = 0
  begin
     exec cobis..sp_cerror
          @i_num    = 253070,
          @i_msg    = 'PARAMETRO DE SEMANAS COMPLETAS DE NAVIDAD, NO EXISTE'
     return 253070
  end

-- El numero de semanas gratis que se pagan
select @w_sem_gratis = pa_tinyint
  from cobis..cl_parametro
 where pa_producto = 'AHO'
   and pa_nemonico = 'SEMGCN'
if @@rowcount = 0
  begin
     exec cobis..sp_cerror
          @i_num    = 253070,
          @i_msg    = 'PARAMETRO DE SEMANAS GRATIS DE NAVIDAD, NO EXISTE'
     return 253070
  end

select @w_per_inicial = dateadd(yy, datediff(yy, pa_datetime, @s_date) - 1,
                                    pa_datetime)
  from cobis..cl_parametro
 where pa_producto = 'AHO'
   and pa_nemonico = 'FEIACN'
if @@rowcount = 0
  begin
     exec cobis..sp_cerror
          @i_num    = 253070,
          @i_msg    = 'PARAMETRO DE INICIO DE APERTURA DE CTA DE NAVIDAD, NO EXISTE'
     return 253070
  end

-- Cursor para el pago de Cuotas a Cuentas de Navidad
declare navidad cursor for
select ah_cuenta,
       ah_cta_banco,
       ah_oficina,
       ah_moneda,
       ah_12h + ah_24h + ah_48h + ah_remesas + ah_disponible,
       cn_cuota,
       isnull(cn_cuota_gratis, 'S'),
       cn_fecha_cuota
  from cob_ahorros..ah_cuenta,
       cob_ahorros..ah_cuenta_navidad
 where cn_cuenta           = ah_cuenta
   and cn_fecha_cierre    is null
   and cn_fecha_cuota     is null
   and cn_fecha_apertura  >= @w_per_inicial
   and cn_fecha_apertura   < dateadd(mm, -1, @w_fec_pago)  -- PCO
   and (@w_relacion       = 'N' or (@w_relacion = 'S' and cn_fecha_pago = @s_date))
 order by ah_cta_banco
   for read only

open navidad
fetch navidad into
      @w_cuenta,
      @w_cta_banco,
      @w_oficina,
      @w_moneda,
      @w_contable,
      @w_cuota,
      @w_cuota_gratis,
      @w_fecha_cuota

if @@fetch_status = -1
  begin
     close navidad
     deallocate navidad
     exec cobis..sp_cerror
          @i_num       = 201157

     return 201157
  end

if @@fetch_status = -2
  begin
     close navidad
     deallocate navidad

     return 0
  end

while @@fetch_status = 0
  begin
     select @w_total = convert(money, @w_cuota) * @w_semanas,
            @w_contador = @w_contador + 1

     select @w_pago = case when @w_total <= @w_contable
                           then convert(money, @w_cuota) * @w_sem_gratis
                           else 0 end
     select @w_mensaje = 'SE PAGARA A LA CUENTA US$ ' + str(@w_pago, 6, 2)

     BEGIN tran

     exec @w_ssn = ADMIN...rp_ssn 1, 2

     -- 1. Levanta el bloqueo contra debitos
     exec @w_return = cob_ahorros..sp_bloqueo_mov_ah
          @s_ssn                = @w_ssn,
          @s_ssn_branch         = 1,
          @s_srv                = @s_srv,
          @s_user               = 'automatico',
          @s_sesn               = 1,
          @s_term               = 'consola',
          @s_date               = @s_date,
          @s_org                = 'U',
          @s_ofi                = @w_oficina,
          @s_rol                = 1,
          @t_trn                = 212,
          @i_cta                = @w_cta_banco,
          @i_mon                = @w_moneda,
          @i_tbloq              = '2',     --Bloqueo contra debitos
          @i_aut                = 'automatico',
          @i_causa              = '3',
          @i_solicit            = 'PAGO SEMANAS GRATIS',
          @i_observacion        = @w_mensaje,
          @o_oficina_cta        = @w_codigo out

     if @w_return <> 0
       begin
          select @w_mensaje = 'CUENTA DE NAVIDAD NO SE LEVANTO BLOQUEO'
          print 'NO SE LEVANTO BLOQUEO EN CUENTA NAVIDAD ' + @w_cta_banco
          rollback tran

          -- Grabar en la tabla de errores
          insert cob_ahorros..re_error_batch
          values (@w_cta_banco, @w_mensaje)

          if @@error <> 0
            begin
               -- Error en grabacion de archivo de errores
               exec cobis..sp_cerror
                    @i_num       = 203056

               -- Cerrar y liberar cursor
               close navidad
               deallocate navidad

               select @o_procesadas = @w_contador
               return 203056
            end
          goto LEER
       end

     -- 2. Si estß autorizado el pago o hay algo que pagar se genera NC
     if @w_cuota_gratis = 'S' and @w_pago > 0
       begin
          exec @w_return = cob_ahorros..sp_ahndc_automatica
               @s_srv         = @s_srv,
               @s_ofi         = @w_oficina,
               @s_ssn         = @w_ssn,
               @s_date        = @s_date,
               @t_trn         = 253,
               @i_cta         = @w_cta_banco,
               @i_val         = @w_pago,
               @i_cau         = '243',
               @i_mon         = @w_moneda,
               @i_fecha       = @s_date

          if @w_return <> 0
            begin
               select @w_mensaje = 'CUENTA DE NAVIDAD NO SE PAGO CUOTA DE NAVIDAD'
               print '---> NOTA DE CREDITO CUENTA NAVIDAD ' + @w_cta_banco + ' ' + convert(varchar(10),@w_return)
               rollback tran

               select @w_mensaje = @w_mensaje + mensaje
                 from cobis..cl_errores
                where numero = @w_return

               -- Grabar en la tabla de errores
               insert cob_ahorros..re_error_batch
               values (@w_cta_banco, @w_mensaje)

               if @@error <> 0
                 begin
                    -- Error en grabacion de archivo de errores
                    exec cobis..sp_cerror
                         @i_num       = 203056

                    -- Cerrar y liberar cursor
                    close navidad
                    deallocate navidad

                    select @o_procesadas = @w_contador
                    return 203056
                 end

               goto LEER
            end
       end
     else
       begin
          select @w_mensaje = 'CUENTA DE NAVIDAD NO TIENE LAS CUOTAS COMPLETAS'

          insert cob_ahorros..re_error_batch
          values (@w_cta_banco, @w_mensaje)

          if @@error <> 0
            begin
               -- Error en grabacion de archivo de errores
               exec cobis..sp_cerror
                    @i_num       = 203056

               -- Cerrar y liberar cursor
               close navidad
               deallocate navidad

               select @o_procesadas = @w_contador
               return 203056
            end
       end

     -- 3. Bloquea la cuenta contra creditos
     exec @w_return = cob_ahorros..sp_bloqueo_mov_ah
          @s_ssn                = @w_ssn,
          @s_ssn_branch         = 1,
          @s_srv                = @s_srv,
          @s_user               = 'automatico',
          @s_sesn               = 1,
          @s_term               = 'consola',
          @s_date               = @s_date,
          @s_org                = 'U',
          @s_ofi                = @w_oficina,
          @s_rol                = 1,
          @t_trn                = 211,
          @i_cta                = @w_cta_banco,
          @i_mon                = @w_moneda,
          @i_tbloq              = '1',     --Bloqueo contra creditos
          @i_aut                = 'automatico',
          @i_causa              = '16',
          @i_solicit            = 'PAGO SEMANAS GRATIS',
          @i_observacion        = @w_mensaje,
          @o_oficina_cta        = @w_codigo out

     if @w_return <> 0
       begin
          select @w_mensaje = 'CUENTA DE NAVIDAD NO SE GENERO EL BLOQUEO'
          print '===NO SE GENERO EL BLOQUEO EN CUENTA NAVIDAD ' + @w_cta_banco
          rollback tran

          -- Grabar en la tabla de errores
          insert cob_ahorros..re_error_batch
          values (@w_cta_banco, @w_mensaje)

          if @@error <> 0
            begin
               -- Error en grabacion de archivo de errores
               exec cobis..sp_cerror
                    @i_num       = 203056

               -- Cerrar y liberar cursor
               close navidad
               deallocate navidad

               select @o_procesadas = @w_contador
               return 203056
            end
          goto LEER
       end

     -- 4. Actualiza los datos de la cuenta de navidad
     update cob_ahorros..ah_cuenta_navidad
        set cn_cuota_gratis  = 'N',
            cn_usuario_cuota = 'automatico',
            cn_fecha_cuota   = @s_date
      where cn_cuenta = @w_cuenta

     if @@error <> 0
       begin
          select @w_mensaje = 'CUENTA DE NAVIDAD NO SE GENERO EL BLOQUEO'
          print '===NO SE GENERO EL BLOQUEO EN CUENTA NAVIDAD ' + @w_cta_banco
          rollback tran

          -- Grabar en la tabla de errores
          insert cob_ahorros..re_error_batch
          values (@w_cta_banco, @w_mensaje)

          if @@error <> 0
            begin
               -- Error en grabacion de archivo de errores
               exec cobis..sp_cerror
                    @i_num       = 203056

               -- Cerrar y liberar cursor
               close navidad
               deallocate navidad

               select @o_procesadas = @w_contador
               return 203056
            end
          goto LEER
       end

     COMMIT tran
LEER:
     fetch navidad into
           @w_cuenta,
           @w_cta_banco,
           @w_oficina,
           @w_moneda,
           @w_contable,
           @w_cuota,
           @w_cuota_gratis,
           @w_fecha_cuota
  end

close navidad
deallocate navidad
select @o_procesadas = @w_contador

return 0

go

