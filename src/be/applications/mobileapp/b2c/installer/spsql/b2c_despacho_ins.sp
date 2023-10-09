use cob_bvirtual
go

if object_id('sp_despacho_ins') is not null
begin
  drop procedure sp_despacho_ins
  if object_id('sp_despacho_ins') is not null
    print 'FAILED DROPPING PROCEDURE sp_despacho_ins'
end
go

/******************************************************************************/
/*      Stored procedure:       bv_despacho_ins.sp                            */
/*      Base de datos:          cob_bvirtual                                  */
/*      Producto:               Internet Banking                              */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/*  Registrar los datos de las notificaciones que van a ser procesadas en BVI */
/******************************************************************************/
/*                              MODIFICACIONES                                */
/******************************************************************************/
/* FECHA        VERSION       AUTOR              RAZON                        */
/******************************************************************************/
/* 26-May-1999  1.0.0         Juan Arthos           Emision Inicial           */
/* 15-Mar-2002  1.0.1         D Villafuerte      Person Bco Tequendama        */
/* 24-Nov-2010  1.0.2         NES                Nuevo esquema de notificacion*/
/* 16-Feb-2011  1.0.3         Joel Chalen        Agregar prametro tipo correo */
/* 11-Abr-2012  4.0.0.0       GQU                Internacionaliz. (CIB4.1.0.5)*/
/* 01-Jun-2013  4.0.0.1       Joel Chalen        Quitar llamada a sp_cerror   */
/* 11-Dic-2013  4.0.0.2       SCH                IEN Notificador              */
/******************************************************************************/
Create Procedure sp_despacho_ins(
@t_show_version       bit               = 0,         -- GQU 11-Abr-2012
@s_culture            varchar(10)       = 'NEUTRAL', -- GQU 11-Abr-2012
@s_ssn                int               = null,
@s_user               varchar(14)       = null,
@s_sesn               int               = null,
@s_term               varchar(30)       = null,
@s_date               datetime          = null,
@s_srv                varchar(30)       = null,
@s_lsrv               varchar(30)       = null,
@s_ofi                smallint          = null,
@s_org                char(1)           = null,
@s_rol                int               = null,
@t_trn                int               = null,
@t_debug              char(1)           = 'N',
@t_file               varchar(14)       = null,
@t_from               varchar(30)       = null,
@i_cliente            int               = null,
@i_servicio           int               = null,
@i_estado             char(1)           = 'P',
@i_tipo               varchar(10)       = null,
@i_tipo_mensaje       char(1)           = '',
@i_prioridad          tinyint           = '',
@i_num_dir            varchar(64)       = '',
@i_var1               varchar(64)       = null,
@i_var2               varchar(64)       = null,
@i_var3               varchar(64)       = null,
@i_var4               varchar(255)      = null,
@i_var5               varchar(255)      = null,
@i_var6               varchar(255)      = null,
@i_var7               varchar(255)      = null,
@i_from               varchar(255)      = null,
@i_to                 varchar(255)      = null,
@i_cc                 varchar(255)      = null,
@i_bcc                varchar(255)      = null,
@i_subject            varchar(255) = null,
@i_body               ntext             = null,
@i_content_manager    varchar(255)      = null,
@i_retry              char(1)           = 'N',
@i_fecha_envio        datetime          = null,
@i_hora_ini           datetime          = null,
@i_hora_fin           datetime          = null,
@i_tries              smallint          = 0,
@i_max_tries          smallint          = 0,
@i_te_id              smallint          = 0,
@o_siguiente          int               = null out
)

As

declare
  @w_sp_name           varchar(64),
  @w_version           char(8),
  @w_siguiente         int,
  @w_nd_fecha_auto     datetime,
  @w_ndias             int

select @w_sp_name = 'sp_despacho_ins'
select @w_version = '4.0.0.2'

---- VERSIONAMIENTO DEL PROGRAMA ----
if @t_show_version = 1
  begin
   print 'Stored procedure = ' + @w_sp_name + ' : ' +  @w_version
   return 0
  end
------------------------------
---- INTERNACIONALIZACION ----
exec cobis..sp_ad_establece_cultura
    @o_culture = @s_culture OUT
------------------------------
exec cobis..sp_cseqnos
  @i_tabla     = 'bv_notificaciones_despacho',
  @o_siguiente = @w_siguiente out

  if @w_siguiente = NULL
  begin
    print 'ERROR: Secuencial bv_notificaciones_despacho no existe'
    return 0
  end

-- Determina n+mero de d¦as para fecha para autoborrado
   select @w_ndias = pa_int
   from cobis..cl_parametro
   where pa_nemonico = 'DBM'
     and pa_producto = 'BVI'

   if @@rowcount = 0
      select @w_ndias = 30


-- Determina fecha de autoborrado
   select @w_nd_fecha_auto = dateadd(dd, @w_ndias, getdate())

-- Elimina hora y minutos
   select @w_nd_fecha_auto = convert(varchar, @w_nd_fecha_auto,101)

-- Determina fecha de proceso

   select @s_date = fp_fecha
   from cobis..ba_fecha_proceso
   if @@rowcount = 0
      select @s_date = convert (varchar, getdate(), 101)

   select @o_siguiente = @w_siguiente


-- Insertar en bv_notificaciones_despacho
begin tran
   insert into bv_notificaciones_despacho
        (nd_id,               nd_servicio,             nd_ente,
         nd_tipo,             nd_tipo_mensaje,         nd_prioridad,
         nd_num_dir,          nd_estado,               nd_num_err,
         nd_txt_err,          nd_ret_status,           nd_fecha_reg,
         nd_fecha_mod,        nd_fecha_auto,           nd_var1,
         nd_var2,             nd_var3,                 nd_var4,
         nd_var5,             nd_var6,                 nd_var7,
         nd_from,             nd_to,                   nd_cc,
         nd_bcc,              nd_subject,              nd_body,
         nd_content_manager,  nd_retry,                nd_tries,
         nd_max_tries,        nd_fecha_envio,          nd_hora_ini,
         nd_hora_fin,         nd_te_id)
   values
        (@w_siguiente ,       @i_servicio,              @i_cliente,
         @i_tipo,             @i_tipo_mensaje,          @i_prioridad,
         @i_num_dir,          @i_estado,                0,
         ' ',                 0,                        @s_date,
         getdate(),           @w_nd_fecha_auto,         @i_var1,
         @i_var2,             @i_var3,                  @i_var4,
         @i_var5,             @i_var6 ,                 @i_var7,
         @i_from,             @i_to,                    @i_cc,
         @i_bcc,              @i_subject,               @i_body,
         @i_content_manager,  @i_retry,                 @i_tries,
         @i_max_tries,        @i_fecha_envio,           @i_hora_ini,
         @i_hora_fin,         @i_te_id)

   if @@error != 0
   begin   
      rollback tran
      print 'ERROR: Al insertar bv_notificaciones_despacho'
      return 0
   end
commit tran
return 0