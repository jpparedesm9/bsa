/***********************************************************************/ 
/*     Archivo:                         cr_utilz.sp                    */
/*     Stored procedure:                sp_utilizacion                 */
/*     Base de Datos:                   cob_credito                    */
/*     Producto:                        Credito                        */
/*     Disenado por:                    Myriam Davila                  */
/*     Fecha de Documentacion:          21/Nov/95                      */
/***********************************************************************/
/*                         IMPORTANTE                                  */
/*     Este programa es parte de los paquetes bancarios propiedad de   */
/*     'MACOSA',representantes exclusivos para el Ecuador de la        */
/*     AT&T                                                            */
/*     Su uso no autorizado queda expresamente prohibido asi como      */
/*     cualquier autorizacion o agregado hecho por alguno de sus       */
/*     usuario sin el debido consentimiento por escrito de la          */
/*     Presidencia Ejecutiva de MACOSA o su representante              */
/***********************************************************************/
/*                          PROPOSITO                                  */
/*     Este stored procedure permite:                          */
/*     1. Marcar la utilizacion de un cupo de credito y consultar la   */
/*      disponibilidad del mismo                                  */
/*     2. Marcar la utilizacion de un cupo pasivo                      */
/*     3. Marcar la utilizacion del CEM de operaciones asociadas o no  */
/*        a un cupo                                         */
/*     4. Consultar la disponibilidad del CEM para operaciones que no  */
/*   estan asociadas a un cupo                                 */
/*                                                                     */
/***********************************************************************/
/*                         MODIFICACIONES                              */
/*     FECHA               AUTOR               RAZON                   */
/*     11/Nov/95     Ivonne Ordonez      Emision Inicial               */
/*     12/Oct/96     F.Arellano          Facilidades                   */
/*     06/Ene/98     M.Davila            Nueva funcionalidad           */
/*                                       Upgrade                       */
/*     25/May/98     Tatiana Granda      Adaptacion para Bco Estado    */
/*     13/Ago/98     Monica Vidal        Correcciones Especificaci.    */
/*     30/Jun/99     Dario Barco         Personalizacion CORFINSURA    */
/*      9/sep/99     Dario Barco         Desembolso en sobrepasamiento */
/*     21/feb/01     Sheela Burbano      Gap CD00005                   */
/*     25/feb/01     Sheela Burbano      Gap CD00054                   */
/*     26/feb/01     Sheela Burbano      Gap CD00006                   */
/*     20/abr/01     Sheela Burbano      Interfaces                    */
/*     14/oct/04     Luis Ponce          Optimizacion                  */
/*     17/abr/06     John Jairo Rendon   Optimizacion                  */
/*     26/oct/08     L. Alvarez          utilizaci¢n de cupo fuentes de*/
/*                                       Recursos                      */
/***********************************************************************/
use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_utilizacion')
   drop proc sp_utilizacion
go

create proc sp_utilizacion(
   @s_ssn              int      = null,
   @s_user             login    = null,
   @s_sesn             int    = null,
   @s_term             descripcion = null,
   @s_date             datetime = null,
   @s_srv              varchar(30) = null,
   @s_lsrv             varchar(30) = null,
   @s_rol              smallint = null,
   @s_ofi              smallint  = null,
   @s_org              char(1) = null,
   @t_trn              smallint = null,
   @t_debug            char(1)  = 'N',
   @t_file             varchar(14) = null,
   @t_from             varchar(30) = null,
   @i_tipo             char(1) = null,
   @i_linea            int = null,
   @i_linea_banco      cuenta = null,
   @i_producto         char(4) = null,
   @i_toperacion       catalogo = null,
   @i_moneda           tinyint = null,
   @i_monto            money = null,
   @i_tramite          int = null,
   @i_cliente          int = null,
   @i_moneda_linea     tinyint = null,
   @i_opcion           char(1) = null,   -- P=Pasiva, A=Activa
   @i_valida_sobrepasa char(1) = 'N',
   @i_modo_sobrepasa   tinyint = 0,
   @i_tipo_tramite     char(1) = null,
   @i_opecca          int      = null,
   @i_fecha_valor      datetime = null,         --SBU: 27/sep/99
   @i_secuencial       int      = 0,
   @i_modo             tinyint  = null,      --SBU:  CD00005
   @i_monto_cex        money = null,      --SBU interfaces
   @i_numoper_cex      cuenta = null,
   @i_valida           tinyint = null,
   @i_batch            char(1) = 'N',
   @i_tramite_unif     int         = null,
   @i_tipo_tram_unif   char(1)     = null
)
as
declare
   @w_today                   datetime,       -- FECHA DEL DIA
   @w_sp_name                 varchar(32),    -- NOMBRE STORED PROC
   @w_error                   int,
   @w_monto_local             money,          -- CALCULO TEMPORAL
   @w_def_moneda              tinyint,        -- moneda LOCAL
   @w_monto_reservado         money,          -- MONTO EN TRAMITE
   @w_tipo_tramite            char(1),        -- TIPO DE TRAMITE
   @w_monto_renovaciones      money,       -- DIFERENCIA EN MONTO PARA RENOVACIONES
   @w_tramite                 int,
   @w_return                  int,
   @w_opcion                  tinyint,
   @w_psob                    float,     -- Porcentaje de sobrepasamiento
   @w_msob                    money,     -- Monto maximo de sobrepasamiento
   @w_montoc_psob             money,
   @w_montoc_falta            money,
   @w_montol_psob             money,
   @w_montol_falta            money,
   @w_sobrepasa               char(1),
   @w_estado                  char(1),
   @w_monto_otros             money,
   @w_utilizado_otros         money,
   @w_reservado_otros         money,
   @w_gru_cliente             int,
   @w_sectoreco               catalogo,
   @w_max_ries_grupo          money,
   @w_ries_grupo            money,
   @w_ries_reservado_grupo    money,
   @w_ries_disp_grupo         money,
   @w_max_ries_sector         money,
   @w_ries_sector           money,
   @w_ries_reservado_sector   money,
   @w_ries_disp_sector        money,
   @w_operacion                char(1),
   @w_cliente                 int,
   @w_est_tramite           char(1),
   @w_max_ries_cliente        money,
   @w_ries_cliente             money,
   @w_ries_reservado_cliente  money,
   @w_ries_disp_cliente       money,
   @w_riesgo_actual            money,
   @w_producto                varchar(3),
   @w_plazo                   int,
   @w_tmp_plazo               char(10),
   @w_fecha_fin                datetime,
   @w_fecha_ini                datetime,
   @w_entramite_grupo         money,
   @w_entramite_sector        money,
   @w_entramite_rcliente      money,
   @w_local_utiliz             money,     --SBU Interfaces
   @w_local_reserv             money,
   @w_ries_utiliz           money,
   @w_ries_reserv           money,
   @w_fac_conres            char(1),
   @w_monto_reno              money,
   @w_monto_aux               money,
   @w_cotiza                  float,
   @w_tipo_pasiva             char(1),
   @w_paramcem                char(1),
   @w_rowcount                int,
   @w_cant_util               smallint,
   @w_primera                 char(1)

   select @i_moneda = 0 --Toda utilizacion es en pesos

if @i_opcion = 'W'
   return 0

   /*VALIDAR SI ES PRIMERA UTILIZACION*/
if @i_opcion = 'U'
begin
   select
   @w_cant_util = isnull(count(op_operacion), 0)
   from cr_linea, cob_cartera..ca_operacion
   where li_num_banco = @i_linea_banco
   and li_num_banco  = op_lin_credito
   and op_estado in (1, 2, 3, 4, 9)
   and op_tramite>li_tramite --VALIDACION PARA UTILIZACION SOBRE AMPLIACION DE CUPO

   if @w_cant_util = 0
      select @w_primera = 'S'
   else
      select @w_primera = 'N'

   select @w_primera

   return 0
end

select  @w_paramcem = pa_char
from    cobis..cl_parametro
where   pa_producto = 'CRE'
and     pa_nemonico = 'CEM'
set transaction isolation level read uncommitted

if @i_tramite is not null   --Las operaciones pasivas de redescuento no son riesgo del cliente
begin
   select   @w_tipo_pasiva    = dt_tipo
   from  cob_cartera..ca_default_toperacion
   where    dt_toperacion     =  (select tr_toperacion
                from cr_tramite
                where tr_tramite = @i_tramite)
       if @w_tipo_pasiva  = 'R'
          return 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if (@i_tipo is null)
or (@i_linea is null and @i_linea_banco is null and @i_modo = 0)   --SBU: CD00005
or (@i_monto is null)
or (@i_moneda is null)
begin
   if @i_batch <> 'S'
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 2101001

   return 2101001
end

select @w_sp_name = 'sp_utilizacion'

if @i_fecha_valor = '01/01/1900'
   select @i_fecha_valor = @s_date


if @i_linea_banco = ' '
   select @i_linea_banco = null


if (@i_linea is null and @i_linea_banco is null)
   select @i_modo = 1
else
   select @i_modo = 0

if @i_tramite is null --control de operaciones sin responsabilidad
begin

   if exists (select 1
      from   cob_cartera..ca_default_toperacion
      where  dt_toperacion = @i_toperacion
      and    dt_tipo_linea = '65'
      and    dt_tipo = 'D')
      return 0
end

if @i_tramite is not null   --Control de operaciones sin responsabilidad
begin

   select distinct @w_fac_conres = fa_con_respon
   from cr_facturas
   where fa_tramite = @i_tramite

   if @w_fac_conres = 'N'   --Sale sin procesar   SBU  01/dic/2001
      return 0
end

---PRINT 'cr_utilz.sp @i_opcion %1! - @i_opcion %2! - @i_modo %3!  @i_monto %4!',@i_opcion,@i_opcion,@i_modo,@i_monto

-- Verificar si se trata de lineas Activas o Pasivas  JSB 99-04-03
if (@i_opcion <> 'P' or @i_opcion is NULL) and (@i_modo = 0)   --SBU  CD00005
begin

   exec @w_return = sp_utiliz0
   @s_ssn               = @s_ssn,
   @s_user              = @s_user,
   @s_sesn              = @s_sesn,
   @s_term              = @s_term,
   @s_date              = @s_date,
   @s_srv               = @s_srv,
   @s_lsrv              = @s_lsrv,
   @s_rol               = @s_rol,
   @s_ofi               = @s_ofi,
   @t_debug             = @t_debug,
   @t_file              = @t_file,
   @t_from              = @t_from,
   @i_tipo              = @i_tipo,
   @i_linea             = @i_linea,
   @i_linea_banco       = @i_linea_banco,
   @i_producto          = @i_producto,
   @i_toperacion        = @i_toperacion,
   @i_moneda            = @i_moneda,
   @i_monto             = @i_monto,
   @i_tramite           = @i_tramite,
   @i_cliente           = @i_cliente,
   @i_moneda_linea      = @i_moneda_linea,
   @i_opcion            = @i_opcion,   -- P=Pasiva, A=Activa
   @i_valida_sobrepasa  = @i_valida_sobrepasa,
   @i_modo_sobrepasa    = @i_modo_sobrepasa,
   @i_tipo_tramite      = @i_tipo_tramite,
   @i_opecca           = @i_opecca,
   @i_fecha_valor       = @i_fecha_valor,
   @i_secuencial        = @i_secuencial,
   @i_modo              = 0,
   @i_monto_cex         = @i_monto_cex,      --SBU interfaces
   @i_valida            = @i_valida,  --pga 15nov01
   @i_numoper_cex       = @i_numoper_cex,
   @i_batch             = @i_batch,
   @i_tramite_unif      = @i_tramite_unif,  -- JAR REQ 218 Paquete2. Cupos.
   @i_tipo_tram_unif    = @i_tipo_tram_unif -- JAR REQ 218 Paquete2. Cupos.

   if @w_return != 0
      return @w_return

end

-- Manejo de lineas pasivas de Comext @i_opcion = 'P' JSB 99-04-03
if @i_opcion = 'P'
begin
   if (@i_tipo is not NULL) and (@i_linea_banco is not null)
   begin
      if @i_tipo in  ('D', 'Y')    -- Se trata de un desembolso, reversa de desembolso  SBU: 27/sep/99
      begin
         select @w_opcion = 4
      end
      else
      begin
         if @i_tipo in ('R', 'X')  -- Se trata de una recuperacion, reversa de recuperacion  SBU: 27/sep/99
            select @w_opcion = 5
      end
   end
end

if (@i_opcion <> 'P' or @i_opcion is NULL) and (@i_modo = 1)
begin

/* OBTENCION DE DATOS INICIALES */
/********************************/
--SELECCION DE CODIGO DE ct_moneda LOCAL
select @w_def_moneda = pa_tinyint
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'MLOCR'
select @w_rowcount = @@rowcount
set transaction isolation level read uncommitted

if @w_rowcount = 0
begin
   if @i_batch <> 'S'
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 2101005
   return 2101005
end

if @i_tramite is not null
begin

  --JSB 2000-02-04 Obtener el codigo de cliente
  if @i_opcion = 'A'
  begin
      select @w_cliente = tr_cliente
      from cr_tramite
      where tr_tramite = @i_tramite

      if @w_cliente is not  null
         select @i_cliente = @w_cliente
      else
      begin

         if @i_batch <> 'S'
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 2101001

         return 2101001
      end
  end
  --JSB

  select @w_producto = tr_producto,
         @w_est_tramite = tr_estado,
         @w_fecha_ini = tr_fecha_crea,
         @w_tipo_tramite = tr_tipo,
         @w_sobrepasa    = tr_sobrepasa
  from cr_tramite
  where tr_tramite = @i_tramite

  if @@rowcount = 0
  begin
     if @i_batch <> 'S'
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 2101005

     return 2101005
  end
end

--- SELECCION DE DATOS DEL CLIENTE
if @i_cliente is not null
begin
   select @w_gru_cliente = en_grupo,
       @w_sectoreco = en_sector,
       @w_max_ries_cliente = isnull(en_max_riesgo, 0),   --SBU  CD0005
       @w_ries_cliente = isnull(en_riesgo, 0),
       @w_ries_reservado_cliente = isnull(en_reservado, 0)
   from cobis..cl_ente
   where en_ente = @i_cliente
   set transaction isolation level read uncommitted

   select @w_ries_disp_cliente = @w_max_ries_cliente - @w_ries_cliente - @w_ries_reservado_cliente
end

if @w_gru_cliente is not null
begin
    select
    @w_max_ries_grupo = isnull(gr_max_riesgo, 0),  --SBU  CD0005
         @w_ries_grupo = isnull(gr_riesgo, 0),
         @w_ries_reservado_grupo = isnull(gr_reservado, 0)
    from cobis..cl_grupo
    where gr_grupo = @w_gru_cliente
    set transaction isolation level read uncommitted

    select @w_ries_disp_grupo = @w_max_ries_grupo - @w_ries_grupo - @w_ries_reservado_grupo
end

if @w_sectoreco is not null
begin
    select
    @w_max_ries_sector = isnull(se_max_riesgo, 0), --SBU  CD0005
         @w_ries_sector = isnull(se_riesgo, 0),
         @w_ries_reservado_sector = isnull(se_reservado, 0)
    from cobis..cl_sectoreco
    where se_sector = @w_sectoreco

    select @w_ries_disp_sector = @w_max_ries_sector - @w_ries_sector - @w_ries_reservado_sector
end

-- TRANSFORMAR A ct_moneda LOCAL LOS DATOS DE LA OPERACION
if @i_moneda <> @w_def_moneda
begin
   select
   @w_monto_local =  isnull(@i_monto * cv_valor,0)
   from cob_conta..cb_vcotizacion
   where cv_moneda = @i_moneda
   and cv_fecha = (select max(cv_fecha)
                   from   cob_conta..cb_vcotizacion
                   where  cv_moneda = @i_moneda
                   and cv_fecha <= isnull(@i_fecha_valor, @s_date))

   if @w_monto_local is null
   begin

      if @i_batch <> 'S'
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 2101003

      return 2101003
   end
end
else
   select @w_monto_local = @i_monto

/* Monto de Riesgo Actual */
select @w_riesgo_actual = @w_monto_local  -- DBA: 16/NOV/99

if @i_tipo in ('D', 'X')
begin
   if @w_producto = 'CEX'
         select @w_local_utiliz = 0,
                @w_ries_utiliz  = 0,
                @w_local_reserv = -1 * @w_monto_local,
           @w_ries_reserv  = -1 * @w_riesgo_actual

   if @w_producto = 'CCA'
         select @w_local_utiliz = @w_monto_local,
                @w_ries_utiliz  = @w_riesgo_actual,
                @w_local_reserv = @w_monto_local,
           @w_ries_reserv  = @w_riesgo_actual

   if @w_producto not in ('CCA','CEX')
         select @w_local_utiliz = @w_monto_local,
                @w_ries_utiliz  = @w_riesgo_actual,
                @w_local_reserv = 0,
           @w_ries_reserv  = 0
end

if @i_tipo in ('Y', 'R')
begin
   if @w_producto = 'CEX'
         select @w_local_utiliz = 0,
                @w_ries_utiliz   = 0,
                @w_local_reserv = @w_monto_local,
           @w_ries_reserv  = @w_riesgo_actual
   else
         select @w_local_utiliz = @w_monto_local,
                @w_ries_utiliz   = @w_riesgo_actual,
                @w_local_reserv = 0,
           @w_ries_reserv  = 0
end

if @i_tipo = 'A'
begin
   select @w_local_utiliz = 0,
          @w_ries_utiliz   = 0,
          @w_local_reserv = @w_monto_local,
          @w_ries_reserv  = @w_riesgo_actual
end

--- EJECUCION DE CADA PROCESO
--- SI OPERACION ES D (DESEMBOLSO)
if (@i_tipo = 'D')
begin
   if @i_batch <> 'S'
   begin tran
      --- Actualizar el maximo riesgo del grupo si el cliente  pertenece
      --- a algun grupo economico, y de igual manera al sector economico

      if @w_gru_cliente is not null and @w_paramcem = 'S'
      begin
           update cobis..cl_grupo
           set gr_riesgo = isnull(gr_riesgo,0) + isnull(@w_ries_utiliz,0),
          gr_reservado = isnull(gr_reservado,0) - isnull(@w_ries_reserv,0)   --SBU   CD00054
           where gr_grupo = @w_gru_cliente

           if @@error <> 0
           begin

                   if @i_batch <> 'S'
                   exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 2105001

                   return 2105001
           end
      end -- Fin de grupo is not null

      if @w_sectoreco is not null  and @w_paramcem = 'S'
      begin
         update cobis..cl_sectoreco
         set se_riesgo = isnull(se_riesgo,0) + isnull(@w_ries_utiliz,0),
        se_reservado = isnull(se_reservado, 0) - isnull(@w_ries_reserv,0)  --SBU  CD00054
         where se_sector = @w_sectoreco

         if @@error <> 0
         begin
              if @i_batch <> 'S'
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 2105001

              return 2105001
         end
      end  -- Fin de sectoreco is not null

      if @i_cliente is not null  and @w_paramcem = 'S'
      begin
         update cobis..cl_ente
         set en_riesgo = isnull(en_riesgo,0) + isnull(@w_ries_utiliz,0),
             en_reservado = isnull(en_reservado, 0) - isnull(@w_ries_reserv,0)
         where en_ente = @i_cliente

         if @@error <> 0
         begin
              if @i_batch <> 'S'
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
            @t_from  = @w_sp_name,
              @i_num   = 2105001
              return 2105001
         end

      end  -- Fin de cliente is not null

   if @i_batch <> 'S'
   commit tran
end

--- SI OPERACION ES Y (REVERSA DE PAGO)
if @i_tipo = 'Y'     --SBU: 27/sep/99
begin
   if @i_batch <> 'S'
   begin tran
       --- Actualizar el maximo riesgo del grupo si el cliente  pertenece
       --- a algun grupo economico, y de igual manera al sector economico

      if @w_gru_cliente is not null and @w_paramcem = 'S'
      begin
           update cobis..cl_grupo
           set gr_riesgo = isnull(gr_riesgo,0) + isnull(@w_ries_utiliz,0),
          gr_reservado = isnull(gr_reservado,0) + isnull(@w_ries_reserv,0)   --SBU   CD00054
           where gr_grupo = @w_gru_cliente

           if @@error <> 0
           begin
                   if @i_batch <> 'S'
                   exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 2105001
                   return 2105001
           end
      end -- Fin de grupo is not null

      if @w_sectoreco is not null and @w_paramcem = 'S'
      begin
         update cobis..cl_sectoreco
         set se_riesgo = isnull(se_riesgo,0) + isnull(@w_ries_utiliz,0),
        se_reservado = isnull(se_reservado, 0) + isnull(@w_ries_reserv,0)  --SBU  CD00054
         where se_sector = @w_sectoreco

         if @@error <> 0
         begin
              if @i_batch <> 'S'
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 2105001
              return 2105001
         end
      end  -- Fin de sectoreco is not null

      if @i_cliente is not null  and @w_paramcem = 'S'
      begin
         update cobis..cl_ente
         set en_riesgo = isnull(en_riesgo,0) + isnull(@w_ries_utiliz,0),
             en_reservado = isnull(en_reservado, 0) + isnull(@w_ries_reserv,0)
         where en_ente = @i_cliente

         if @@error <> 0
         begin
              if @i_batch <> 'S'
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 2105001
              return 2105001
         end
      end  -- Fin de cliente is not null

   if @i_batch <> 'S'
   commit tran
end

--- SI OPERACION ES X (REVERSA DE DESEMBOLSO)
if (@i_tipo = 'X')   --SBU: 27/sep/99
begin
   if @i_batch <> 'S'
   begin tran
         --- Actualizo el maximo riesgo  del grupo  si el cliente pertenece
         --- a algun grupo economico, y de igual manera al sector economico

         if @w_gru_cliente is not null and @w_paramcem = 'S'
         begin
            update cobis..cl_grupo
            set gr_riesgo = isnull(gr_riesgo, 0) - @w_ries_utiliz,
      gr_reservado = isnull(gr_reservado, 0) + @w_ries_reserv   --SBU   CD00054
            where gr_grupo = @w_gru_cliente

            if @@error <> 0
            begin
               if @i_batch <> 'S'
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 2105001
               return 2105001
            end
         end -- Fin de grupo is not null

         if @w_sectoreco is not null and @w_paramcem = 'S'
         begin
            update cobis..cl_sectoreco
            set se_riesgo = isnull(se_riesgo, 0) -  @w_ries_utiliz,
      se_reservado = isnull(se_reservado, 0) + @w_ries_reserv  --SBU  CD00054
            where se_sector = @w_sectoreco

            if @@error <> 0
            begin
                 if @i_batch <> 'S'
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 2105001
                 return 2105001
            end
         end  -- Fin de sectoreco is not null

         if @i_cliente is not null and @w_paramcem = 'S'
         begin
            update cobis..cl_ente
            set en_riesgo = isnull(en_riesgo, 0) -  @w_ries_utiliz,
              en_reservado = isnull(en_reservado, 0) + @w_ries_reserv
            where en_ente = @i_cliente

            if @@error <> 0
            begin
                 if @i_batch <> 'S'
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 2105001
                 return 2105001
            end
         end  -- Fin de cliente is not null

   if @i_batch <> 'S'
      commit tran
end

--- SI OPERACION ES R (RECUPERACION)

if @i_tipo in ('R', 'A') --SBU: 27/sep/99
begin
   if @i_batch <> 'S'
   begin tran
         --- Actualizo el maximo riesgo  del grupo  si el cliente pertenece
         --- a algun grupo economico, y de igual manera al sector economico

         if @w_gru_cliente is not null and @w_paramcem = 'S'
         begin
            update cobis..cl_grupo
            set gr_riesgo = isnull(gr_riesgo, 0) - @w_ries_utiliz,
      gr_reservado = isnull(gr_reservado, 0) - @w_ries_reserv   --SBU   CD00054
            where gr_grupo = @w_gru_cliente

            if @@error <> 0
            begin
               if @i_batch <> 'S'
               exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 2105001
               return 2105001
            end
         end -- Fin de grupo is not null

         if @w_sectoreco is not null and @w_paramcem = 'S'
         begin

            update cobis..cl_sectoreco
            set se_riesgo = isnull(se_riesgo, 0) -  @w_ries_utiliz,
      se_reservado = isnull(se_reservado, 0) - @w_ries_reserv  --SBU  CD00054
            where se_sector = @w_sectoreco

            if @@error <> 0
            begin
                 if @i_batch <> 'S'
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 2105001
                 return 2105001
            end
         end  -- Fin de sectoreco is not null

         if @i_cliente is not null     and @w_paramcem = 'S'
         begin

            update cobis..cl_ente
            set en_riesgo = isnull(en_riesgo, 0) -  @w_ries_utiliz,
              en_reservado = isnull(en_reservado, 0) - @w_ries_reserv
            where en_ente = @i_cliente

            if @@error <> 0
            begin
                 if @i_batch <> 'S'
                 exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 2105001
                 return 2105001
            end
         end  -- Fin de cliente is not null

   if @i_batch <> 'S'
   commit tran
end

--- SI OPERACION ES C (CONTROL DE DISPONIBILIDAD)
if (@i_tipo = 'C')
begin
   if @i_tramite is null
      select @w_tipo_tramite = @i_tipo_tramite

   --Incluir financiamientos  JSB 99-04-03
   if @w_tipo_tramite <> 'O' and @w_tipo_tramite <> 'R' and  @w_tipo_tramite <> 'T' and  @w_tipo_tramite <> 'U'
      -- SALIR SIN PROCESAR
      return 0

      -- OBTENGO LA DIFERENCIA EN MONTO PARA ESTE TRAMITE
      if @w_tipo_tramite = 'R'
      begin
         --emg optimizacion may-31-02
         select @w_monto_reno = isnull(x.tr_monto * a.cv_ult_valor,0),
                @w_cotiza = isnull(a.cv_ult_valor,0),
                @w_monto_aux = isnull(x.tr_monto,0)
         from   cr_tramite x, cob_conta..cb_ult_fecha_cotiz_mon a
         where  x.tr_tramite = @i_tramite
         and    a.cv_moneda = x.tr_moneda

         select @w_monto_renovaciones =
          isnull(@w_monto_aux * @w_cotiza, 0) -
          (select isnull(sum(y.or_monto_original * b.cv_ult_valor), 0)
          from  cr_op_renovar y, cob_conta..cb_ult_fecha_cotiz_mon b
          where  y.or_tramite = @i_tramite
          and  b.cv_moneda = y.or_moneda_original
          group by y.or_tramite
          having isnull(sum(y.or_monto_original * b.cv_ult_valor), 0)  < @w_monto_reno )

          select @w_monto_renovaciones = isnull(@w_monto_renovaciones,0)
          select @w_riesgo_actual = @w_monto_renovaciones
      end

      if (@i_cliente is not null and @i_valida is null)
      begin
         select @w_entramite_rcliente = sum(lr_reservado * cv_ult_valor)
         from   cr_tramite , cr_lin_reservado x,
      cob_conta..cb_ult_fecha_cotiz_mon
         where  lr_cliente    = @i_cliente
    and    lr_tramite >= 0
         and    lr_tramite <> @i_tramite    -- EXCLUYO EL TRAMITE
    and    tr_tramite = lr_tramite
         and    tr_estado not in ('Z','X','R','S')            -- NO RECHAZADOS DEFINITIVAMENTE
    and    cv_moneda = x.lr_moneda

    select @w_entramite_rcliente = isnull(@w_entramite_rcliente, 0)

         select @w_ries_disp_cliente = @w_ries_disp_cliente - @w_entramite_rcliente

          if ((@w_ries_disp_cliente < @w_riesgo_actual) and @w_paramcem = 'S')
          begin
             if @i_batch <> 'S'
             exec cobis..sp_cerror
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_num     = 2101115
             return 2101115
          end
      end

      if (@w_gru_cliente is not null and @i_valida is null)
      begin
         select @w_entramite_grupo = sum(lr_reservado * cv_ult_valor)
         from   cr_tramite , cr_lin_reservado x, cobis..cl_ente,
      cob_conta..cb_ult_fecha_cotiz_mon
         where  lr_tramite <> @i_tramite
         and    tr_tramite = lr_tramite
         and    tr_estado not in ('Z','X','R','S')          -- NO RECHAZADOS DEFINITIVAMENTE
         and    en_ente = lr_cliente
         and    en_grupo   = @w_gru_cliente
    and    cv_moneda = x.lr_moneda

    select @w_entramite_grupo = isnull(@w_entramite_grupo, 0)

         select @w_ries_disp_grupo = @w_ries_disp_grupo - @w_entramite_grupo

         if ((@w_ries_disp_grupo < @w_riesgo_actual)  and @w_paramcem = 'S')
         begin
             if @i_batch <> 'S'
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 2101137
             return 2101137
         end
      end -- Fin de grupo is not null

      if (@w_sectoreco is not null and @i_valida is null and @w_paramcem = 'S')
      begin
         select @w_entramite_sector = sum(lr_reservado * cv_ult_valor)
         from   cr_tramite , cr_lin_reservado x, cobis..cl_ente,
      cob_conta..cb_ult_fecha_cotiz_mon
         where  lr_tramite <> @i_tramite
         and    tr_tramite = lr_tramite
         and    tr_estado not in ('Z','X','R','S')       -- NO RECHAZADOS DEFINITIVAMENTE
         and    en_ente = lr_cliente
         and    en_sector  = @w_sectoreco
         and    lr_moneda = cv_moneda
    and    cv_moneda = x.lr_moneda

    select @w_entramite_sector = isnull(@w_entramite_sector, 0)

         select @w_ries_disp_sector = @w_ries_disp_sector - @w_entramite_sector

         if ((@w_ries_disp_sector < @w_riesgo_actual) and @w_paramcem = 'S')
            print 'Sobrepasa maximo riesgo de sector economico'

      end  -- Fin de sectoreco is not null

end

end   -- (@i_opcion <> 'P' or @i_opcion = NULL) and (@i_modo = 1)

return 0
ERROR:
if @i_batch <> 'S' begin
   exec cobis..sp_cerror
   @t_from    = @w_sp_name,
   @i_num     = @w_error
   return @w_error
end

go
