USE cob_cartera
go
if exists (select 1 from sysobjects where name = 'sp_man_ciclo')
  drop procedure sp_man_ciclo
go

/****************************************************************/
/*   ARCHIVO:           man_ciclo.sp                            */
/*   NOMBRE LOGICO:     sp_man_ciclo                            */
/*   PRODUCTO:              CARTERA                             */
/****************************************************************/
/*                     IMPORTANTE                               */
/*   Esta aplicacion es parte de los  paquetes bancarios        */
/*   propiedad de MACOSA S.A.                                   */
/*   Su uso no autorizado queda  expresamente  prohibido        */
/*   asi como cualquier alteracion o agregado hecho  por        */
/*   alguno de sus usuarios sin el debido consentimiento        */
/*   por escrito de MACOSA.                                     */
/*   Este programa esta protegido por la ley de derechos        */
/*   de autor y por las convenciones  internacionales de        */
/*   propiedad intelectual.  Su uso  no  autorizado dara        */
/*   derecho a MACOSA para obtener ordenes  de secuestro        */
/*   o  retencion  y  para  perseguir  penalmente a  los        */
/*   autores de cualquier infraccion.                           */
/****************************************************************/
/*                     PROPOSITO                                */
/*   Este procedimiento permite obtener la el numero de ciclo   */
/*   de un cliente                                              */
/****************************************************************/
/*                     MODIFICACIONES                           */
/*   FECHA         AUTOR               RAZON                    */
/*   04-Abr-2017   Andy Gonzalez     Emision Inicial.           */
/*   04-Abr-2017   Tania Baidal      Interciclo por cliente     */
/*   11/08/2021    ACHP              #166473 Ciclo indv no es   */
/*                                   consistente en la renovacion*/
/*   04/03/2022    DCU               Caso: 179643               */
/****************************************************************/

create proc sp_man_ciclo (
@t_show_version         bit             = 0,  -- show the version of the stored procedure
@s_ssn                  int             = null,
@s_user                 login           = null,
@s_sesn                 int             = null,
@s_term                 varchar(30)     = null,
@s_date                 datetime        = null,
@s_srv                  varchar(30)     = null,
@s_lsrv                 varchar(30)     = null,
@s_rol                  smallint        = NULL,
@s_ofi                  smallint        = NULL,
@s_org_err              char(1)         = NULL,
@s_error                int             = NULL,
@s_sev                  tinyint         = NULL,
@s_msg                  descripcion     = NULL,
@s_org                  char(1)         = NULL,
@t_rty                  char(1)         = null,
@t_trn                  smallint        = null,
@t_debug                char(1)         = 'N',
@t_file                 varchar(14)     = null,
@t_from                 varchar(30)     = null,
@i_grupo                int             = null,
@i_modo                 char(1)         = null,
@i_operacion            int             = null,
@i_ciclo                int             = null,  -- SECUENCIAL DE CICLO
@i_tciclo               char(1)         = null,  -- TIPO DE CICLO
@i_prestamo             varchar(15)     = null,
@i_tramite              int             = null,
@i_cuenta_aho_grupal    varchar(16)     = null,
@i_titular_cta          int             = null,
@i_titular_cta2         int             = null,
@i_debito_cta_grupal    char(1)         = null,
@i_fecha_ini            datetime        = null,
@i_grupal               char(1)         = null,
@i_tramite_grupal       int             = null,
@i_cliente              int             = null
)

as

declare
@w_titular_cta          int,
@w_titular_cta2         int,
@w_fecha_ini_op         datetime,
@w_ciclo                int,
@w_saldo_vencido        money,
@w_ahorro_ini           money,
@w_ahorro_ini_int       money,
@w_ahorro_voluntario    money,
@w_incentivos           money,
@w_extras               money,
@w_devoluciones         money,
@w_sp_name              cuenta,
@w_ciclo_det            int,
@w_count                int

select @w_sp_name  = 'sp_man_ciclo'

-- LGU obtener los ID de los titulares del grupo
select
   @w_titular_cta  = gr_titular1,
   @w_titular_cta2 = gr_titular2
from cobis..cl_grupo
where gr_grupo = @i_grupo

if (@i_modo = 'I' and @i_grupal = 'S')
begin

   if not exists(select 1 from cob_cartera..ca_ciclo where ci_grupo = @i_grupo)
   begin
      select @w_ciclo = 1
   end
   else
   begin
      select @w_ciclo = isnull(max(ci_ciclo), 0) + 1
     from cob_cartera..ca_ciclo
     where ci_grupo = @i_grupo
   end

   set rowcount 0

   insert into ca_ciclo (
      ci_grupo,           ci_operacion,            ci_ciclo,                ci_tciclo,
      ci_prestamo,        ci_tramite,              ci_cuenta_aho_grupal,    ci_titular_cta,
      ci_titular_cta2,    ci_debito_cta_grupal,    ci_fecha_ini)
   select
      @i_grupo,           op_operacion,             @w_ciclo,                'N',
      op_banco,           op_tramite,               @i_cuenta_aho_grupal,    @w_titular_cta,
      @w_titular_cta2,    'S',                      op_fecha_liq
   from ca_operacion
   where op_tramite = @i_tramite_grupal

   if @@error <> 0
   begin
      /* Error en insercion del ciclo */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 70011005,
      @i_msg   = "[sp_man_ciclo] Error en insercion de ciclo "
      return 1
   end

    ----Para caso#166473
    select tg_cliente 
    into #cr_tramite_grupal
    from cob_credito..cr_tramite_grupal 
    where tg_tramite = @i_tramite_grupal and tg_participa_ciclo = 'S' and tg_monto > 0
	and   tg_referencia_grupal <> tg_prestamo

    select cliente = dc_cliente, ciclo = max(dc_ciclo) + 1
	into #ciclos_cliente
    from cob_cartera..ca_det_ciclo, #cr_tramite_grupal
    where dc_cliente = tg_cliente group by dc_cliente

   --recuperar todos los valores para insertar detalle
   insert into ca_det_ciclo(
      dc_grupo,        dc_ciclo_grupo,         dc_cliente,
      dc_operacion,    dc_referencia_grupal,
      dc_ciclo,        dc_tciclo,              dc_saldo_vencido,
      dc_ahorro_ini,   dc_ahorro_ini_int,      dc_ahorro_voluntario,
      dc_incentivos,   dc_extras,              dc_devoluciones)
   select
      @i_grupo,        @w_ciclo,               tg_cliente,
      tg_operacion,    tg_referencia_grupal, --LPO
      1,               'N',                    @w_saldo_vencido,
      @w_ahorro_ini,   @w_ahorro_ini_int,      @w_ahorro_voluntario,
      @w_incentivos,   @w_extras,              @w_devoluciones
   from cob_credito..cr_tramite_grupal
   where tg_tramite = @i_tramite_grupal
   and   tg_grupo   = @i_grupo
   and convert(varchar,tg_operacion) <> tg_prestamo  -- para que tome solo las operaciones liquidadas y grupales
   and tg_grupal = 'S'
   and tg_referencia_grupal <> tg_prestamo

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 70011005,
      @i_msg   = "[sp_man_ciclo] Error en insercion de detalle de ciclo "
      return 1
   end

   -- Actualizar el ciclo del cliente -- caso#166473
   update cob_cartera..ca_det_ciclo
   set dc_ciclo = ciclo
   from #ciclos_cliente
   where dc_cliente = cliente
   and dc_ciclo_grupo = @w_ciclo
   and dc_grupo = @i_grupo
      
   --ACTUALIZAR CICLO DEL GRUPO
   update cobis..cl_grupo
   set gr_num_ciclo = @w_ciclo
   where gr_grupo = @i_grupo

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 70011005,
      @i_msg   = "[sp_man_ciclo] Error al actualizar ciclo del grupo"
      return 1
   end

   --ACTUALIZAR CICLO DEL CLIENTE EN EL GRUPO
    UPDATE cobis..cl_cliente_grupo SET
        cg_nro_ciclo = cg_nro_ciclo + 1
    FROM cob_credito..cr_tramite_grupal
    WHERE cg_grupo = @i_grupo
    AND cg_ente = tg_cliente
    AND convert(varchar,tg_operacion) <> tg_prestamo  -- para que tome solo las operaciones liquidadas y grupales

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 70011005,
      @i_msg   = "[sp_man_ciclo] Error al actualizar ciclo del cliente en el grupo"
      return 1
   end


end

if (@i_modo = 'I' and @i_grupal = 'N')
begin
   --/////////////////////////////////////////////////////
   -- LGU-ini 18/abr/2017 se solicita poner como cabecera a la emergente
      if exists(select 1 from cob_cartera..ca_ciclo where ci_grupo = @i_grupo)
      begin
            select @w_ciclo = isnull(max(ci_ciclo), 0) + 1
            from cob_cartera..ca_ciclo
            where ci_grupo = @i_grupo
      end
      else
      begin
            select @w_ciclo = 1
      end

      set rowcount 0

      insert into ca_ciclo   (
         ci_grupo,          ci_operacion,         ci_ciclo,             ci_tciclo,
         ci_prestamo,       ci_tramite,           ci_cuenta_aho_grupal, ci_titular_cta,
         ci_titular_cta2,   ci_debito_cta_grupal, ci_fecha_ini)
      select
         @i_grupo,          op_operacion,         @w_ciclo,              'E',
         op_banco,          op_tramite,           @i_cuenta_aho_grupal , @w_titular_cta,
         @w_titular_cta2,  'S',                   op_fecha_ini
      from ca_operacion
      where op_operacion = @i_operacion

      if @@error <> 0
      begin
            /* Error en insercion del ciclo */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 70011005,
            @i_msg   = "[sp_man_ciclo] Error en insercion de ciclo "
            return 1
      end

      /*if exists(select 1 from cob_cartera..ca_det_ciclo where dc_grupo = @i_grupo
              and dc_ciclo_grupo = @w_ciclo and dc_cliente = @i_cliente)
      begin
         select @w_ciclo_det = max(dc_ciclo) + 1
         from cob_cartera..ca_det_ciclo
         where dc_grupo       = @i_grupo
         and dc_ciclo_grupo   = @w_ciclo
         and dc_cliente       = @i_cliente
      end
      else
      begin
         select @w_ciclo_det = 1
      end*/
	  
	  --select @w_ciclo_det = max(dc_ciclo) + 1 from ca_det_ciclo where dc_cliente = xxxx
   --/////////////////////////////////////////////////////////
   -- LGU-ini 18/abr/2017 se solicita poner como cabecera a la emergente

   --recuperar todos los valores para insertar detalle
      insert into ca_det_ciclo(
         dc_grupo,            dc_ciclo_grupo,         dc_cliente,    -- 3
         dc_operacion,        dc_referencia_grupal,   dc_ciclo,      -- 6
         dc_tciclo,           dc_saldo_vencido,       dc_ahorro_ini, -- 9
         dc_ahorro_ini_int,   dc_ahorro_voluntario,   dc_incentivos, -- 12
         dc_extras,           dc_devoluciones)
      select
         @i_grupo,            @w_ciclo,               tg_cliente,    -- 3
         tg_operacion,        tg_referencia_grupal,/*LPO*/   @w_ciclo_det,  -- 6
         'E',                 @w_saldo_vencido,       @w_ahorro_ini, -- 9
         @w_ahorro_ini_int,   @w_ahorro_voluntario,   @w_incentivos, -- 12
         @w_extras,           @w_devoluciones
      from cob_credito..cr_tramite_grupal
      where tg_operacion  = @i_operacion
      and   tg_grupo      = @i_grupo

      if @@error != 0
      begin
         /* Error en insercion de garantia */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 70011005,
         @i_msg   = "[sp_man_ciclo] Error en insercion de ciclo "
         return 1
      end
end

return 0
go
IF OBJECT_ID(N'dbo.sp_man_ciclo') IS NOT NULL
    PRINT N'<<< CREATED PROCEDURE dbo.sp_man_ciclo >>>'
ELSE
    PRINT N'<<< FAILED CREATING PROCEDURE dbo.sp_man_ciclo >>>'
go

