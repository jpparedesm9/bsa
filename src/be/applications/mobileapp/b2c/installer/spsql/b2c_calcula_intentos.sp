use cob_bvirtual
go
if object_id('sp_calcula_intentos') is not null
                drop proc sp_calcula_intentos
go

/*****************************************************************************/
/*   ARCHIVO:         calcula_intentos.sp                                    */
/*   NOMBRE LOGICO:   sp_calcula_intentos                                    */
/*   PRODUCTO:        COBIS INTERNET BANKING                                 */
/*****************************************************************************/
/*                             IMPORTANTE                                    */
/*****************************************************************************/
/*   Esta aplicacion es parte de los  paquetes bancarios propiedad de        */
/*   COBISCORP                                                               */
/*   Su uso no autorizado queda  expresamente  prohibido asi como cualquier  */
/*   alteracion o agregado hecho por alguno de sus usuarios sin el debido    */
/*   consentimiento por escrito de COBISCORP.                                */
/*   Este programa esta protegido por la ley de derechos de autor y por las  */
/*   convenciones  internacionales de propiedad intelectual.                 */
/*   Su uso  no  autorizado dara derecho a COBISCORP para obtener ordenes de */
/*   secuestro o retencion  y  para  perseguir  penalmente a  los autores de */
/*   cualquier infraccion.                                                   */
/*****************************************************************************/
/*                           PROPOSITO                                       */
/*   Stored Procedure para manejo de intentos fallidos en el ingreso a BVI   */
/*****************************************************************************/
/*                        MODIFICACIONES                                     */
/*****************************************************************************/
/*  FECHA        VERSION  AUTOR              RAZON                           */
/*****************************************************************************/
/*  13-Nov-2002           D Villafuerte      Emision inicial                 */
/*  27-Ene-2005           Lenin F. Ponton    Person Global Bank              */
/*  20-Dic-2011           FJI                Modificar envio num intento     */
/*  21-Dic-2011  4.0.0.1  NES                Notificacion                    */
/*  03-Abr-2012  4.0.0.2  GQU                Internacionalizacion(CIB4.1.0.5)*/
/*  23-Abr-2012  4.0.0.3  CEC                Versionamiento                  */
/*  26-Abr-2012  4.0.0.4  DME                singularizaci=n num_intentos    */
/*  28-May-2012  4.0.0.5  GQU                Corr. parametros sp_despacho_ins*/
/*  04-Sep-2012  4.0.0.6  JOCH               Nuevo esquema de notificaciones */
/*  27/Nov-2017  4.0.0.7  ERA                Se descomenta la línea de tipo=0*/
/*****************************************************************************/
Create Procedure sp_calcula_intentos (  
   @t_show_version bit         = 0,         -- GQU 03-Abr-2012  
   @s_date         datetime    = null,  
   @s_culture      varchar(20) = 'NEUTRAL', -- GQU 03-Abr-2012  
   @i_ente         int         = 0,  
   @i_cultura      varchar(10) = 'NEUTRAL',  
   @i_login        varchar(128)= null,  
   @i_nom_cliente  varchar(64) = null,  
   @i_servicio     tinyint     = 0,       -- Canal de conexion  
   @i_canal        tinyint     = 0,       -- Canal donde el cliente tiene su login  
   @i_estado       char(1)     = null,  
   @i_intento_1    smallint    = 0,  
   @i_intento_2    smallint    = 0,  
   @i_intento_5    smallint    = 0,  
   @i_intento_6    smallint    = 0,  
   @i_tipo         tinyint     = 0,  
   @o_msg          varchar(125)= null output,  
   @o_activar      char(1)     = 'S' output  
)  
  
As  
declare  
  @w_total              smallint,  
  @w_max_intentos       smallint,  
  @w_max_intentos_abs   smallint,  
  @w_fecha_ult_int      datetime,  
  @w_sp_name            varchar(64),  
  @w_fecha_hoy          datetime,  
  @w_emailbco         varchar(30),  
  @w_email_cliente      varchar(128),  
  @w_return             int,  
  @w_body               varchar(255),  
  @w_template           smallint,  
  @w_num_error          int,  
  @w_msg_error          varchar(255),  
  @w_version            char(8),      -- GQU 02-Abr-2012  
  @w_usuario_b_i18n     VARCHAR(255), -- GQU 02-Abr-2012  
  @w_clave_inc_i18n     VARCHAR(255), -- GQU 02-Abr-2012  
  @w_ud_tiene_i18n      VARCHAR(255), -- GQU 02-Abr-2012  
  @w_intentos_i18n      VARCHAR(255), -- GQU 02-Abr-2012  
  @w_cta_bloq_i18n      VARCHAR(255), -- GQU 02-Abr-2012  
  @w_ud_espere_i18n     VARCHAR(255), -- GQU 02-Abr-2012  
  @w_ud_acerquese_i18n  VARCHAR(255), -- GQU 02-Abr-2012  
  @w_aux1               varchar(10)   -- JOCH 04-Sep-2012   
    
select @w_sp_name = 'sp_calcula_intentos', -- GQU 03-Abr-2012  
       @w_version = '4.0.0.6'  
-- Mostrar la version del programa  
if @t_show_version = 1  
begin  
   print 'Stored procedure = ' + @w_sp_name + ' : ' +  @w_version  
   return 0  
end  
  
---- INTERNACIONALIZACION ----  
EXEC cobis..sp_ad_establece_cultura  
    @o_culture = @i_cultura OUT  
------------------------------  
  
--- recupera fecha actual del server  
select @w_fecha_hoy = getdate()  
  
-- Determina numero maximo de intentos  
select @w_max_intentos = pa_tinyint  
from cobis..cl_parametro  
where pa_nemonico = 'NINT'  
  and pa_producto = 'BVI'  
if @@rowcount = 0  
   select @w_max_intentos = 3  
  
-- Determina numero maximo absoluto de intentos  
select @w_max_intentos_abs = pa_tinyint  
from cobis..cl_parametro  
where pa_nemonico = 'NINTA'  
  and pa_producto = 'BVI'  
if @@rowcount = 0  
   select @w_max_intentos = 6  
  
--LPO: 20050126  
if @i_servicio in (1,8,10)
     select @w_total = @i_intento_1  
else  
   if @i_servicio = 2  
      select @w_total = @i_intento_2  
   else  
      select @w_total = @i_intento_1 + @i_intento_2 + @i_intento_5 + @i_intento_6  
  
-- Clave NOK  
if @i_tipo = 0  
begin  
  
   --if @w_total = @w_max_intentos - 1  
   if ((@w_total + 1) % (@w_max_intentos)) = 0  --LPO:20050126  
   begin  
      -- Bloqueo de login  
      update bv_login  
      set   lo_estado   = 'B',  
            lo_fecha_ult_int = @w_fecha_hoy   --LPO: 20050126  
      where lo_login    = @i_login  
      and lo_servicio   = @i_canal  
  
  
      select @w_email_cliente = me_num_dir  
      from bv_medio_envio  
      where me_ente  = @i_ente  
      and me_login   = @i_login  
      and me_tipo    = 'MAIL'  
      and me_default ='S'  
  
      if not (@w_email_cliente is null)  
      begin  
         --Etiqueta USUARIO BLOQUEADO  
         SELECT  @w_usuario_b_i18n = re_valor -- GQU 03-Abr-2012  
         FROM    cobis..ad_etiqueta_i18n  
         WHERE   pc_identificador    = 'b-cob_bvirtual'  
         AND     pc_codigo           = 'USU_BLOQ'  
         AND     re_cultura          = @i_cultura  
  
            -----------------------------  
            --- Envio de Notificacion ---  
            -----------------------------  
            select @w_aux1 = convert(varchar,@w_max_intentos-1)  
              
           /* exec @w_return = cob_bvirtual..sp_bv_enviar_notif_ib  
                @s_culture        = @i_cultura,  
                @s_date           = @s_date,  
                @i_titulo         = @w_usuario_b_i18n,  
                @i_servicio       = @i_canal,  
                @i_ente_ib        = @i_ente,      --Codigo IB de cliente  
                @i_notificacion   = 'N18',           --Codigo de la notificacion  
                @i_producto       = 18,        --Codigo del producto  
                @i_num_producto   = '',          --Numero del producto  
                @i_tipo_mensaje   = 'F',    --Tipo de mensaje a enviar E-Mensaje de Error F-mensaje de finalizada correctamente la transaccion I-Mensaje para oficiales o funcionarios del banco  
                @i_login          = @i_login,  
                @i_aux1           = @w_aux1  
  
         if  @w_return <> 0  
         begin  
            -- Error en la inserci=n de mensaje a despachar  
            exec cobis..sp_cerror  
                @t_from       = @w_sp_name,  
                @i_num        = 1850154,  
                @s_culture    = @i_cultura  
              return 1850154  
         end */ 
      end  
  
   end  
  
-- Incrementa numero de intentos  
   if @i_servicio in (1,8,10)
      select @i_intento_1 = @i_intento_1 + 1  
     else if @i_servicio = 2  
        select @i_intento_2 = @i_intento_2 + 1  
       else if @i_servicio = 5  
          select @i_intento_5 = @i_intento_5 + 1  
         else if @i_servicio = 6  
            select @i_intento_6 = @i_intento_6 + 1  
  
-- Control de mensaje  
  
   --Mensaje CLAVE INCORRECTA  
   SELECT  @w_clave_inc_i18n = re_valor -- GQU 03-Abr-2012  
   FROM    cobis..ad_etiqueta_i18n  
   WHERE   pc_identificador    = 'b-cob_bvirtual'  
   AND     pc_codigo           = 'CLAV_INC'  
   AND     re_cultura          = @i_cultura  
  
   --Mensaje PASSWORD INCORRECTO, UD. TIENE  
   SELECT  @w_ud_tiene_i18n = re_valor -- GQU 03-Abr-2012  
   FROM    cobis..ad_etiqueta_i18n  
   WHERE   pc_identificador    = 'b-cob_bvirtual'  
   AND     pc_codigo           = 'UD_TIENE'  
   AND     re_cultura          = @i_cultura  
  
   --Mensaje PASSWORD INCORRECTO, SU CUENTA HA SIDO BLOQUEADA,  
   SELECT  @w_cta_bloq_i18n = re_valor -- GQU 03-Abr-2012  
   FROM    cobis..ad_etiqueta_i18n  
   WHERE   pc_identificador    = 'b-cob_bvirtual'  
   AND     pc_codigo           = 'CTA_BLOQ'  
   AND     re_cultura          = @i_cultura  
  
   --Mensaje UD DEBE ESPERAR 24 HORAS ANTES DE ACTIVARLA NUEVAMENTE  
   SELECT  @w_ud_espere_i18n = re_valor -- GQU 03-Abr-2012  
   FROM    cobis..ad_etiqueta_i18n  
   WHERE   pc_identificador    = 'b-cob_bvirtual'  
   AND     pc_codigo           = 'UD_ESP'  
   AND     re_cultura          = @i_cultura  
  
   --Mensaje UD DEBE ACERCARSE A LAS OFICINAS DEL BANCO PARA SU ACTIVACION  
   SELECT  @w_ud_acerquese_i18n = re_valor -- GQU 03-Abr-2012  
   FROM    cobis..ad_etiqueta_i18n  
   WHERE   pc_identificador    = 'b-cob_bvirtual'  
   AND     pc_codigo           = 'UD_ACER'  
   AND     re_cultura          = @i_cultura  
  
   --Mensaje INTENTO(S) ADICIONAL(ES) ANTES QUE SU CUENTA QUEDE BLOQUEADA  
   if (@w_max_intentos - @w_total - 1)=1  -- DME 26-Abr-2012  
   begin  
      SELECT  @w_intentos_i18n = re_valor -- GQU 03-Abr-2012  
      FROM    cobis..ad_etiqueta_i18n  
      WHERE   pc_identificador    = 'b-cob_bvirtual'  
      AND     pc_codigo           = 'INTENTO'  
      AND     re_cultura          = @i_cultura  
   end  
   else  
   begin  
      SELECT  @w_intentos_i18n = re_valor  
      FROM    cobis..ad_etiqueta_i18n  
      WHERE   pc_identificador    = 'b-cob_bvirtual'  
      AND     pc_codigo           = 'INTENTOS'  
      AND     re_cultura          = @i_cultura  
   end  
  
   select @o_msg = @w_clave_inc_i18n  
  
   if @w_total + 1 < @w_max_intentos  
      select @o_msg = @w_ud_tiene_i18n + ' ' +  
                       convert(varchar,@w_max_intentos - @w_total - 1) + ' '  
                       + @w_intentos_i18n  
  
   if @w_total + 1 = @w_max_intentos or (@w_total + 1 < @w_max_intentos_abs and @w_total + 1 > @w_max_intentos)  
   begin  
      select @o_msg = @w_cta_bloq_i18n + ', ' +  
                      @w_ud_espere_i18n  
      select @o_activar = 'N'  
   end  
   if @w_total + 1 >= @w_max_intentos_abs  
   begin  
      select @o_msg = @w_cta_bloq_i18n + ', ' +  
                      @w_ud_acerquese_i18n  
      select @o_activar = 'N'  
   end  
  
  
   -- Actualizacion de numero de intentos  
  
   update bv_login  
   set lo_intento_1  = @i_intento_1,  
       lo_intento_2  = @i_intento_2,  
       lo_intento_5  = @i_intento_5,  
       lo_intento_6  = @i_intento_6  
   where lo_login            = @i_login  
      and lo_servicio        = @i_canal  
      and lo_estado = 'A'
   if @@rowcount != 1  
   begin  
   -- Error en actualizacion de login  
      exec cobis..sp_cerror  
          @t_from       = @w_sp_name,  
          @i_num        = 1850067
        return 1850067  
   end  
end  
  
if @i_tipo = 1  
begin     -- Clave OK  
   --LPO: 20050126  
   select @w_fecha_ult_int = isnull(lo_fecha_ult_int, @w_fecha_hoy)  
   from bv_login  
   where lo_login    = @i_login  
   and   lo_servicio = @i_canal  
  
  
   if datediff(dd, @w_fecha_ult_int, @w_fecha_hoy) >= 1  
   begin  
      if @w_total + 1 <= @w_max_intentos_abs  --Es el mismo día  
      begin  
         if @i_canal in (1,8,10)
         begin  
            update bv_login  
            set lo_estado           = 'A',    --LPO: 20050126 Estado Activo  
                lo_fecha_ult_int    = null,   --LPO: 20050126  
                lo_intento_1        = null  
            where lo_login  = @i_login  
            and lo_servicio = @i_canal  
            if @@rowcount != 1  
            begin  
            -- Error en actualizacion de login  
               exec cobis..sp_cerror  
                   @t_from       = @w_sp_name,  
                   @i_num        = 1850067
                 return 1850067  
            end  
         end  
         else if @i_canal = 2  
         begin  
                 update bv_login  
                 set lo_estado           = 'A',   --LPO: 20050126 Estado Activo  
                     lo_fecha_ult_int    = null,   --LPO: 20050126  
                     lo_intento_2        = null  
                 where lo_login  = @i_login  
                 and lo_servicio = @i_canal  
               if @@rowcount != 1  
               begin  
               -- Error en actualizacion de login  
                  exec cobis..sp_cerror  
                      @t_from       = @w_sp_name,  
                      @i_num        = 1850067 
                    return 1850067  
               end  
         end  
      end  
      select @o_msg = null  
   end  
end  
  
return 0  