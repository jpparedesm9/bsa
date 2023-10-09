/************************************************************************/
/*   Stored procedure:     sp_control_efectivo                          */
/*   Base de datos:        cob_cuentas                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'MACOSA'                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   05Nov2006     SAlban   Ingreso de Declaraciones                    */
/*                 KZH      Req SARLAFT_006 - Agregar Origen de fondos  */
/*                          tipo descripcion                            */
/************************************************************************/

use cob_cuentas
go

if exists (select 1 from sysobjects where name = 'sp_control_efectivo')
   drop proc sp_control_efectivo
go

create proc sp_control_efectivo (
@s_ssn                  int = null,
@s_srv                  varchar(30) = null,
@s_lsrv                 varchar(30) = null,
@s_user                 varchar(30) = null,
@s_sesn                 int = null,
@s_term                 varchar(10) = null,
@s_date                 datetime = null,
@s_ofi                  smallint = null,
@t_debug                char(1) = 'N',
@t_file                 varchar(14) = null,
@t_from                 varchar(32) = null,
@t_trn                  int,
@i_cta                  cuenta = null,
@i_tipo_con             smallint = null,
@i_filial               tinyint= null,
@i_oficina              smallint =null,
@i_oficina_recep        smallint =null,
@i_ciudad               varchar (7) = null,--int = null,
@i_oficial              smallint = null,
@i_fecha_ing            datetime = null,
@i_usuario              varchar(30) = null,
@i_producto             smallint = null,
@i_cta_banco            cuenta = null,
@i_nombre_cta           varchar(50) = null,
@i_iden                 numero=null,
@i_oficina_admon        smallint =null,
@i_tipo_tran            char(1) = null,
@i_moneda               char(1) = null,
@i_valor                money = null,
@i_pers_pr_apellido     varchar(30) = null,
@i_pers_sg_apellido     varchar(30) = null,
@i_pers_nombres         varchar(30) = null,
@i_pers_tipo_ident      char(2) = null,
@i_pers_ced_nit         numero = null,
@i_pers_direcc          varchar(40) = null,
@i_titular              varchar(1) = null,
@i_pers1_pr_apellido    varchar(30) = null,
@i_pers1_sg_apellido    varchar(30) = null,
@i_pers1_nombres        varchar(30) = null,
@i_pers1_tipo_ident     char(2) = null,
@i_pers1_ced_nit        numero = null,
@i_pers1_direcc         varchar(40) = null,
@i_pers1_actividad      varchar(30) = null,
@i_secuencial           int         = null,
@i_origen_tran          varchar(5)  = null,
@i_accion               int     = -1,
@i_modo                 int     = null,
@i_fecha_fin            datetime    = null,
@i_fecha_ini            datetime    = null,
@i_valor_inicial        money       = null,
@i_valor_final          money       = null,
@i_tipo_doc_e           varchar(10) = null,
@i_cedula_e             varchar(40) = null,
@i_tipo_doc_t           varchar(10) = null,
@i_cedula_t             varchar(40) = null,
@i_numcta               varchar(50) = null,
@i_consecutivo          int     = 0,
@i_sub_tipo             varchar(5)  = null,
@i_hora                 varchar(10) = NULL,
@i_telefono             varchar(30) = NULL,
@i_telefono_e           varchar(30) = NULL,
@i_telefono_t           varchar(30) = NULL,
@i_titular_t            varchar(2)  = NULL,
@i_nom_benef            varchar(30) = NULL,
@i_papp_benef           varchar(30) = NULL,
@i_sapp_benef           varchar(30) = NULL,
@i_tipo_doc_benef       varchar(30) = NULL,
@i_num_doc_benef        varchar(30) = NULL,
@i_titular_benef        varchar(30) = NULL,
@i_tipoid_iden          varchar(2)  = NULL,
@i_pivote               int     = null,
@i_reproceso            char(1) = '0', -- Estados 0: No reproceso 1: Reproceso del Mismo Archivo 2: Reproceso de Archivo Diferente
@i_proceso              int = NULL ,  --FSAP Sarlaf
@i_declaracion_ah       char(1) = null,
@i_declaracion_cc       char(1) = null,
@i_declaracion_ho       char(1) = null,
@i_declaracion_ot       char(1) = null,
@i_declaracion_cd       char(1) = null,
@i_declaracion_sa       char(1) = null,
@i_declaracion_ve       char(1) = null,
@i_cod_transaccion      int = null,
@i_origen_bines_fondos  varchar (100) = null,   --KZH Req SARLAFT_006 BPT
@i_sec_giro   			varchar(15) = null      --Req 302 ADD MTCN   
)
as
declare 
@w_return               int,
@w_sp_name              varchar(30),
@w_msg                  varchar(255),
@w_direccion            varchar(120),
@w_iden                 varchar(13),
@w_gerente              varchar(30),
@w_oficina              varchar(30),
@w_cod_ofi              smallint,
@w_mmtp                 money,
@w_mmtd                 money,
@w_ente                 int,
@w_secuencial           int,
@w_cta                  cuenta,
@w_tipo_con             smallint,
@w_filial               tinyint,
@w_oficina1             smallint,
@w_oficina_recep        smallint,
@w_ciudad               varchar(7),--int,
@w_oficial              smallint,
@w_tipo_ced             varchar(16),
@w_p_apelledo           varchar(16),
@w_s_apellido           varchar(16),
@w_nombre               varchar(64),
@w_actividad            varchar(10),
@w_des_act              varchar(64),
@w_filtro               varchar(255),
@w_filtro1              varchar(200),
@w_filtro2              varchar(200),
@w_max_consecutivo      int,
@w_sec                  int,
@w_et_tipo_doc_t        varchar(3),
@w_et_cedula_t          numero,
@w_en_oficial           int,
@w_cod_dir              smallint,
@w_telefono             varchar(20),
@w_param_lim_rioe       money,
@w_pivote               varchar(200),
@w_fila                 int,
@w_texto                varchar(40),
@w_ce_consecutivo       int        ,
@w_ce_fecha             datetime   ,
@w_ce_oficina           int        ,
@w_ce_oficial           smallint   ,
@w_ce_usuario           login      ,
@w_ce_ciudad            varchar(7) ,
@w_ce_oficina_recep     smallint   ,
@w_ce_producto          smallint   ,
@w_ce_numcta            cuenta     ,
@w_ce_nom_cta           varchar(50),
@w_ce_iden              numero     ,
@w_ce_transaccion       char(1)    ,
@w_ce_moneda            char(1)    ,
@w_ce_valor             money      ,
@w_ce_apellido1_e       varchar(30),
@w_ce_apellido2_e       varchar(30),
@w_ce_nombre_e          varchar(30),
@w_ce_tipo_doc_e        char(2)    ,
@w_ce_cedula_e          numero     ,
@w_ce_direccion_e       varchar(40),
@w_ce_titular           char(1)    ,
@w_ce_apellido1_t       varchar(30),
@w_ce_apellido2_t       varchar(30),
@w_ce_nombre_t          varchar(30),
@w_ce_tipo_doc_t        char(2)    ,
@w_ce_cedula_t          numero     ,
@w_ce_direccion_t       varchar(40),
@w_ce_activ_econom_t    varchar(30),
@w_ce_origen_tran       varchar(5 ),
@w_ce_hora              varchar(10),
@w_ce_telefono          varchar(30),
@w_ce_telefono_e        varchar(30),
@w_ce_telefono_t        varchar(30),
@w_ce_titular_t         varchar(2 ),
@w_ce_nom_benef         varchar(30),
@w_ce_papp_benef        varchar(30),
@w_ce_sapp_benef        varchar(30),
@w_ce_tipo_doc_benef    varchar(2 ),
@w_ce_num_doc_benef     varchar(13),
@w_ce_titular_benef     varchar(2 ),
@w_ce_tipoid_iden       varchar(2 ),
@w_declaracion_ah       char(1),
@w_declaracion_cc       char(1),
@w_declaracion_ho       char(1),
@w_declaracion_ot       char(1),
@w_declaracion_cd       char(1),
@w_declaracion_sa       char(1),
@w_declaracion_ve       char(1),
@w_cod_transaccion      int,
@w_ingresos             smallint,
@w_origen_bines_fondos  varchar (100) --KZH Req SARLAFT_006 BPT

select @w_param_lim_rioe = pa_money
from   cobis..cl_parametro
where  pa_producto = 'REM'
and    pa_nemonico = 'MRIOE'


/**********REEMPLAZAR PUNTO POR ESPACIOS ***/
if @i_pers_sg_apellido = '.' or @i_pers1_sg_apellido = '.' or @i_sapp_benef = '.' 
   select @i_pers_sg_apellido  = ' ',
          @i_pers1_sg_apellido = ' ',
          @i_sapp_benef        = ' ' 

/* Captura nombre de Stored Procedure */
select @w_sp_name = 'sp_control_efectivo'

if @t_trn =2669 and @i_tipo_con=1 /* Busca los datos de la cuenta*/
begin
   if @i_producto = 0 --consulta unicamente el cliente
      select
      @w_iden       = en_ced_ruc,
      @w_cod_ofi    = en_oficina,
      @w_tipo_ced   = en_tipo_ced,
      @w_gerente    = fu_nombre,
      @w_oficial    = en_oficial,
      @w_oficina    = of_nombre,
      @w_p_apelledo = p_p_apellido,
      @w_s_apellido = p_s_apellido,
      @w_nombre     = en_nombre,
      @w_actividad  = en_actividad,
      @w_ente       = en_ente,
      @w_cod_dir    = en_direccion
      from   cobis..cl_ente,   cobis..cc_oficial,
            cobis..cl_funcionario,  cobis..cl_oficina
      where   en_ced_ruc  = @i_iden
      and     oc_oficial     = en_oficial
      and     oc_funcionario = fu_funcionario
      and     en_oficina  = of_oficina
      and     en_tipo_ced = @i_tipoid_iden
   else

   if @i_producto = 3
      select
      @w_iden       = cc_ced_ruc,
      @w_direccion  = cc_descripcion_ec,
      @w_cod_ofi    = cc_oficina,
      @w_oficina    = of_nombre,
      @w_gerente    = fu_nombre,
      @w_oficial    = cc_oficial,
      @w_tipo_ced   = en_tipo_ced,
      @w_p_apelledo = p_p_apellido,
      @w_s_apellido = p_s_apellido,
      @w_nombre     = en_nombre,
      @w_actividad  = en_actividad,
      @w_ente       = en_ente,
      @w_cod_dir    = en_direccion
      from   cob_cuentas..cc_ctacte, cobis..cc_oficial,
             cobis..cl_funcionario, cobis..cl_oficina,
             cobis..cl_ente
      where cc_cta_banco   = @i_cta
      and   oc_oficial     = cc_oficial
      and   oc_funcionario = fu_funcionario
      and   cc_oficina     = of_oficina
      and   cc_filial      = of_filial
      and   cc_cliente     = en_ente
   else
   if @i_producto = 4
      select
      @w_iden       = ah_ced_ruc,
      @w_direccion  = ah_descripcion_ec,
      @w_cod_ofi    = ah_oficina,
      @w_oficina    = of_nombre,
      @w_gerente    = fu_nombre,
      @w_oficial    = ah_oficial,
      @w_tipo_ced   = en_tipo_ced,
      @w_p_apelledo = p_p_apellido,
      @w_s_apellido = p_s_apellido,
      @w_nombre     = en_nombre,
      @w_actividad  = en_actividad,
      @w_ente       = en_ente,
      @w_cod_dir    = en_direccion
      from   cob_ahorros..ah_cuenta, cobis..cc_oficial,
             cobis..cl_funcionario, cobis..cl_oficina,
             cobis..cl_ente
      where ah_cta_banco   = @i_cta
      and   oc_oficial     = ah_oficial
      and   oc_funcionario = fu_funcionario
      and   ah_oficina     = of_oficina
      and   ah_filial      = of_filial
      and   ah_cliente     = en_ente
   else
   begin
      select
      @w_iden      = ce_iden,
      @w_direccion = 'SD',
      @w_cod_ofi   = ce_oficina,
      @w_oficina   = of_nombre,
      @w_gerente   = fu_nombre,
      @w_oficial   = ce_oficial,
      @w_nombre    = ce_nom_cta
      from  cob_cuentas..cc_ctrl_efectivo, cobis..cc_oficial,
            cobis..cl_funcionario, cobis..cl_oficina
      where ce_numcta      = @i_cta
      and   oc_oficial     = ce_oficial
      and   oc_funcionario = fu_funcionario
      and   ce_oficina     = of_oficina

      select
      @w_tipo_ced   = en_tipo_ced,
      @w_p_apelledo = p_p_apellido,
      @w_s_apellido = p_s_apellido,
      @w_actividad  = en_actividad,
      @w_ente       = en_ente,
      @w_cod_dir    = en_direccion
      from  cobis..cl_ente
      where en_subtipo =  'P'
      and   en_ced_ruc =  @w_iden

      if @@rowcount = 0
      begin
         select
         @w_tipo_ced   = en_tipo_ced,
         @w_p_apelledo = p_p_apellido,
         @w_s_apellido = p_s_apellido,
         @w_actividad  = en_actividad,
         @w_ente       = en_ente,
         @w_cod_dir    = en_direccion
         from  cobis..cl_ente
         where en_subtipo =  'C'
         and   en_ced_ruc =  @w_iden
      end
   end

   select @w_mmtp = pa_money
   from  cobis..cl_parametro
   where pa_nemonico = 'MMTP'
   and   pa_tipo     = 'M'
   and   pa_producto = 'CTE'

   select @w_mmtd = pa_money
   from   cobis..cl_parametro
   where  pa_nemonico = 'MMTD'
   and    pa_tipo     = 'M'
   and    pa_producto = 'CTE'


   select @w_des_act = valor
   from   cobis..cl_catalogo
   where  tabla  = (select codigo
                    from cobis..cl_tabla
                    where tabla = 'cl_actividad')
   and    codigo = @w_actividad

   select @w_direccion = di_descripcion
   from   cobis..cl_direccion
   where  di_ente      = @w_ente
   and    di_direccion = @w_cod_dir

   select @w_telefono =  te_valor
   from   cobis..cl_telefono
   where  te_ente      = @w_ente
   and    te_direccion = @w_cod_dir

   select @w_iden,
          @w_direccion,
          @w_oficina,
          @w_cod_ofi,
          @w_gerente,
          @w_oficial,
          @w_mmtp,
          @w_mmtd,
          @w_tipo_ced,
          @w_p_apelledo,
          @w_s_apellido,
          @w_nombre,
          @w_ente,
          @w_telefono
   
end

if @t_trn =2669 and @i_tipo_con=0  /* Adicion de Registros*/
begin
   if exists(select 1
             from   cc_ctrl_efectivo
             where  ce_consecutivo = @i_secuencial
             and   ce_oficina_recep = @s_ofi )
             
   begin          
      select @w_secuencial = @i_secuencial
      
      select @w_ingresos   =   ts_causa1
      from   cob_cuentas..cc_tran_servicio
      where  ts_secuencial = @i_secuencial
      
   end   
   else
   begin
      select @w_ingresos = 0

      if @i_secuencial is not null
         select @w_secuencial = @i_secuencial
      else
      begin
         exec @w_return = cobis..sp_cseqnos
         @t_debug      = @t_debug,
         @t_file       = @t_file,
         @t_from       = @w_sp_name,
         @i_tabla      = 'cc_ctrl_efectivo',
         @o_siguiente  = @w_secuencial out
         if @w_return <> 0
            return @w_return
      end  

      insert into cc_ctrl_efectivo
      (ce_consecutivo,       ce_fecha,             ce_oficina,        ce_oficial,        ce_usuario, ce_ciudad,
       ce_oficina_recep,     ce_producto,          ce_numcta,         ce_nom_cta,        ce_iden,
       ce_transaccion,       ce_moneda,            ce_valor,          ce_apellido1_e,    ce_apellido2_e,
       ce_nombre_e,          ce_tipo_doc_e,        ce_cedula_e,       ce_direccion_e,    ce_titular,
       ce_apellido1_t,       ce_apellido2_t,       ce_nombre_t,       ce_tipo_doc_t,     ce_cedula_t,
       ce_direccion_t,       ce_activ_econom_t,    ce_origen_tran,    ce_hora,           ce_telefono,
       ce_telefono_e,        ce_telefono_t,        ce_titular_t,      ce_nom_benef,      ce_papp_benef,
       ce_sapp_benef,        ce_tipo_doc_benef,    ce_num_doc_benef,  ce_titular_benef,
       ce_tipoid_iden,       ce_declaracion_ah,    ce_declaracion_cc, ce_declaracion_ho,
       ce_declaracion_ot,    ce_declaracion_cd,    ce_declaracion_sa,
       ce_declaracion_ve,    ce_cod_transaccion,   ce_origen_bines_fondos,
       ce_sec_giro)   
      values                                       
      (@w_secuencial,        @i_fecha_ing,         @i_oficina_admon,  @i_oficial,          @i_usuario, @i_ciudad,
       @i_oficina_recep,     @i_producto,          @i_cta_banco,      @i_nombre_cta,       @i_iden,
       @i_tipo_tran,         @i_moneda,            @i_valor,          @i_pers_pr_apellido, @i_pers_sg_apellido,
       @i_pers_nombres,      @i_pers_tipo_ident,   @i_pers_ced_nit,   @i_pers_direcc,      @i_titular,
       @i_pers1_pr_apellido, @i_pers1_sg_apellido, @i_pers1_nombres,  @i_pers1_tipo_ident, @i_pers1_ced_nit,
       @i_pers1_direcc,      @i_pers1_actividad,   @i_origen_tran,    @i_hora,             @i_telefono,
       @i_telefono_e,        @i_telefono_t,        @i_titular_t,      @i_nom_benef,        @i_papp_benef,
       @i_sapp_benef,        @i_tipo_doc_benef,    @i_num_doc_benef,  @i_titular_benef,
       @i_tipoid_iden,       @i_declaracion_ah,    @i_declaracion_cc, @i_declaracion_ho,
       @i_declaracion_ot,    @i_declaracion_cd,    @i_declaracion_sa,
       @i_declaracion_ve,    @i_cod_transaccion,   @i_origen_bines_fondos, --KZH Req SARLAFT_006 BPT
       @i_sec_giro)--Req 302 ADD MTCN
      
      
      if @@error <> 0
      begin
         /* Error en insercion en la tabla cc_ctrl_efectivo */
         exec cobis..sp_cerror
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_num     = 208089
      
         return 208089
      end
      
      select @w_secuencial
   end

   /* Creacion de Transaccion de Servicio */
   select @w_ingresos = @w_ingresos + 1
   insert into cob_cuentas..cc_tran_servicio
          (ts_secuencial, ts_tipo_transaccion, ts_tsfecha,
           ts_usuario,    ts_oficina,          ts_hora,     ts_producto,
           ts_cta_banco,  ts_valor,            ts_terminal, ts_causa1)
   values (@s_ssn,        @t_trn,              @s_date,
           @s_user,       @s_ofi,              getdate(),   @i_producto,
           @i_cta_banco,  @i_valor,            @s_term,     @w_ingresos)

   /* Error en creacion de transaccion de servicio */
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 203005
      return 203005
   end
end

if @t_trn =2670 /* Actualizacion*/
begin

   if exists (select 1
              from  cob_cuentas..cc_ctrl_efectivo
              where ce_consecutivo   = @i_secuencial
              and   ce_oficina_recep = @s_ofi
              and   ce_fecha         = @s_date)
    begin
       update cob_cuentas..cc_ctrl_efectivo set
       ce_fecha          = @i_fecha_ing,
       ce_oficina_recep  = @i_oficina_recep,
       ce_usuario        = @i_usuario,
       ce_ciudad         = @i_ciudad,
       ce_producto       = @i_producto,
       ce_transaccion    = @i_tipo_tran,
       ce_moneda         = @i_moneda,
       ce_valor          = @i_valor,
       ce_apellido1_e    = @i_pers_pr_apellido,
       ce_apellido2_e    = @i_pers_sg_apellido,
       ce_nombre_e       = @i_pers_nombres,
       ce_tipo_doc_e     = @i_pers_tipo_ident,
       ce_cedula_e       = @i_pers_ced_nit,
       ce_direccion_e    = @i_pers_direcc,
       ce_titular        = @i_titular,
       ce_apellido1_t    = @i_pers1_pr_apellido,
       ce_apellido2_t    = @i_pers1_sg_apellido,
       ce_nombre_t       = @i_pers1_nombres,
       ce_tipo_doc_t     = @i_pers1_tipo_ident,
       ce_cedula_t       = @i_pers1_ced_nit,
       ce_direccion_t    = @i_pers1_direcc,
       ce_activ_econom_t = @i_pers1_actividad,
       ce_hora           = @i_hora,
       ce_telefono       = @i_telefono,
       ce_telefono_e     = @i_telefono_e,
       ce_telefono_t     = @i_telefono_t,
       ce_titular_t      = @i_titular_t,
       ce_nom_benef      = @i_nom_benef,
       ce_papp_benef     = @i_papp_benef,
       ce_sapp_benef     = @i_sapp_benef,
       ce_tipo_doc_benef = @i_tipo_doc_benef,
       ce_num_doc_benef  = @i_num_doc_benef,
       ce_titular_benef  = @i_titular_benef,
       ce_iden           = @i_iden,
       ce_numcta         = @i_cta_banco,
       ce_oficina        = @i_oficina,
       ce_nom_cta        = @i_nombre_cta,
       ce_tipoid_iden    = @i_tipoid_iden,
       ce_declaracion_ah = @i_declaracion_ah,
       ce_declaracion_cc = @i_declaracion_cc,
       ce_declaracion_ho = @i_declaracion_ho,
       ce_declaracion_ot = @i_declaracion_ot,
       ce_declaracion_cd = @i_declaracion_cd,
       ce_declaracion_sa = @i_declaracion_sa,
       ce_declaracion_ve = @i_declaracion_ve,
       ce_origen_bines_fondos = @i_origen_bines_fondos, ---KZH Req SARLAFT_006 BPT
       ce_sec_giro		 = @i_sec_giro  --Req 302 ADD MTCN 
       where  ce_consecutivo   = @i_secuencial
       and    ce_oficina_recep = @s_ofi
       and    ce_fecha         = @s_date

       if @@error <> 0
       begin
          /* Error en creacion de registro en cc_ctabloqueada */
          exec cobis..sp_cerror
          @t_debug      = @t_debug,
          @t_file       = @t_file,
          @t_from       = @w_sp_name,
          @i_num        = 208090
          return 208090
       end
    end
    else
    begin
       exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 101001
       return 101001
    end
   /* Creacion de Transaccion de Servicio */

   insert into cob_cuentas..cc_tran_servicio
           (ts_secuencial, ts_tipo_transaccion, ts_tsfecha,
            ts_usuario,    ts_oficina,          ts_hora, ts_producto,
            ts_cta_banco,  ts_valor,            ts_terminal)
    values (@s_ssn,        @t_trn,              @s_date,
            @s_user,       @s_ofi,              getdate(), @i_producto,
            @i_cta_banco,  @i_valor,            @s_term)

   /* Error en creacion de transaccion de servicio */
   if @@error <> 0
   begin
      exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 203005
      return 203005
   end
end

if @t_trn =2672 /* Busqueda*/
begin
   if exists(select 1
             from   cob_cuentas..cc_ctrl_efectivo
             where  ce_consecutivo=@i_secuencial
             and    ce_oficina_recep = @s_ofi
             and    ce_fecha = @s_date)
   begin
      select convert(varchar(10),ce_fecha,101),
             ce_ciudad,
             ce_oficina_recep,
             ce_producto,
             ce_numcta,
             ce_nom_cta,
             ce_transaccion,
             ce_moneda,
             ce_valor,
             ce_apellido1_e,
             ce_apellido2_e,
             ce_nombre_e,
             ce_tipo_doc_e,
             ce_cedula_e,
             ce_direccion_e,
             ce_titular,
             ce_apellido1_t,
             ce_apellido2_t,
             ce_nombre_t,
             ce_tipo_doc_t,
             ce_cedula_t,
             ce_direccion_t,
             ce_activ_econom_t,
             ce_origen_tran,
             ce_hora,
             ce_telefono,
             ce_telefono_e,
             ce_telefono_t,
             ce_titular_t,
             --ce_nom_benef,
             --ce_papp_benef,
             --ce_sapp_benef,
             --ce_tipo_doc_benef,
             --ce_num_doc_benef,
             --ce_titular_benef,
             ce_iden,
             ce_tipoid_iden,
             ce_declaracion_ah ,
             ce_declaracion_cc ,
             ce_declaracion_ho ,
             ce_declaracion_ot ,
             ce_declaracion_cd ,
             ce_declaracion_sa ,
             ce_declaracion_ve,
             ce_cod_transaccion,
             ce_origen_bines_fondos, --KZH Req SARLAFT_006 BPT
             tn_descripcion,          --KZH Req SARLAFT_006 BPT
             ce_sec_giro 			--Req 302 ADD MTCN
      from   cob_cuentas..cc_ctrl_efectivo, cobis..cl_ttransaccion
      where  ce_consecutivo=@i_secuencial
      and    ce_oficina_recep = @s_ofi
      and    ce_fecha = @s_date
      and    ce_cod_transaccion = tn_trn_code --KZH Req SARLAFT_006 BPT

   end
   else
   begin   
      
      if @@rowcount <> 1
      begin
         /* No existe tipo chequera */
         exec cobis..sp_cerror
              @t_debug     = @t_debug,
              @t_file      = @t_file,
              @t_from      = @w_sp_name,
              @i_num       = 208091
         return 208091
      end
   end
end

if @t_trn =2796
begin
   set rowcount 0
   select @w_filtro =
          ' where ce_oficina_recep = ' + convert(varchar(10),@i_oficina) +
          ' and   ce_fecha between ''' + convert(varchar(10),@i_fecha_ini,101) + ''' and ''' + convert(varchar(10),@i_fecha_fin,101) + '''' +
          ' and   ce_valor between ' + convert(varchar(50),@i_valor_inicial) + ' and ' + convert(varchar(50),@i_valor_final)
   --print '@w_filtro: %1! ', @w_filtro

   if @i_accion = 0
   begin
      select @w_filtro1 = ' and ce_tipo_doc_e  = ''' + @i_tipo_doc_e  + '''' +
                          ' and ce_cedula_e    = ''' + @i_cedula_e + ''''
      select @w_filtro =  @w_filtro  + @w_filtro1
      --print '@w_filtro1: %1! ', @w_filtro1
   end

   if @i_accion = 1
   begin
       select @w_filtro1 = ' and ce_tipo_doc_t  = ''' + @i_tipo_doc_t  + '''' +
                           ' and ce_cedula_t    = ''' + @i_cedula_t + ''''
       select @w_filtro  =  @w_filtro  + @w_filtro1
       --print '@w_filtro1: %1! ', @w_filtro1
   end

   if @i_accion = 2
   begin
       --print '@i_numcta %1!',@i_numcta
       if @i_numcta is null
          select @w_filtro1 = ' and ce_iden  = ''' + @i_iden  + ''''
       else
          select @w_filtro1 = ' and ce_iden     = ''' + @i_iden  + '''' +
                              ' and ce_producto = ' + convert(varchar(5),@i_producto)  +
                              ' and ce_numcta   = ''' + @i_numcta  +  ''''

       select @w_filtro =  @w_filtro  + @w_filtro1
   end

   if @i_accion = 3
   begin
       select @w_filtro1 = ' and ce_tipo_doc_benef  = ''' + @i_tipo_doc_benef  + '''' +
                           ' and ce_num_doc_benef   = ''' + @i_num_doc_benef + ''''
       select @w_filtro =  @w_filtro  + @w_filtro1
   end


   select @w_filtro2 = ' order by ce_oficina_recep, ce_fecha , ce_consecutivo  '

   -- crea la tabla temporal
   create table #control_efectivo (
   ce_pivote                       numeric identity      not   null,
   ce_consecutivo                  int                   null,
   ce_fecha                        datetime              null,
   ce_oficina                      smallint              null,
   ce_oficial                      smallint              null,
   ce_usuario                      varchar(14)           null,
   ce_ciudad                       varchar(7)            null,
   ce_oficina_recep                smallint              null,
   ce_producto                     smallint              null,
   ce_numcta                       varchar(24)           null,
   ce_nom_cta                      varchar(50)           null,
   ce_iden                         varchar(13)           null,
   ce_transaccion                  char(1)               null,
   ce_moneda                       char(1)               null,
   ce_valor                        money                 null,
   ce_apellido1_e                  varchar(30)           null,
   ce_apellido2_e                  varchar(30)           null,
   ce_nombre_e                     varchar(30)           null,
   ce_tipo_doc_e                   char(2)               null,
   ce_cedula_e                     varchar(13)           null,
   ce_direccion_e                  varchar(40)           null,
   ce_titular                      char(1)               null,
   ce_apellido1_t                  varchar(30)           null,
   ce_apellido2_t                  varchar(30)           null,
   ce_nombre_t                     varchar(30)           null,
   ce_tipo_doc_t                   char(2)               null,
   ce_cedula_t                     varchar(13)           null,
   ce_direccion_t                  varchar(40)           null,
   ce_activ_econom_t               varchar(30)           null,
   ce_origen_tran                  varchar(30)           null,
   ce_hora                         varchar(10)           null,
   ce_telefono                     varchar(30)           null,
   ce_telefono_e                   varchar(30)           null,
   ce_telefono_t                   varchar(30)           null,
   ce_titular_t                    varchar(2)            null,
   ce_nom_benef                    varchar(30)           null,
   ce_papp_benef                   varchar(30)           null,
   ce_sapp_benef                   varchar(30)           null,
   ce_tipo_doc_benef               varchar(2)            null,
   ce_num_doc_benef                varchar(13)           null,
   ce_titular_benef                varchar(2)            null,
   ce_tipoid_iden                  varchar(2)            null,
   ce_declaracion_ah               char(1)               null,
   ce_declaracion_cc               char(1)               null,
   ce_declaracion_ho               char(1)               null,
   ce_declaracion_ot               char(1)               null,
   ce_declaracion_cd               char(1)               null,
   ce_declaracion_sa               char(1)               null,
   ce_declaracion_ve               char(1)               null,
   ce_origen_bines_fondos          varchar(100)          null ) --KZH Req SARLAFT_006 BPT )


   if @i_modo = 1
       select @i_pivote = 0

   select @w_fila = @i_pivote + 9

   set rowcount @w_fila

   exec ( 'insert into #control_efectivo ' +
       'select            '  +
       'ce_consecutivo   ,'  +
       'ce_fecha         ,'  +
       'ce_oficina       ,'  +
       'ce_oficial       ,'  +
       'ce_usuario       ,'  +
       'ce_ciudad        ,'  +
       'ce_oficina_recep ,'  +
       'ce_producto      ,'  +
       'ce_numcta        ,'  +
       'ce_nom_cta       ,'  +
       'ce_iden          ,'  +
       'ce_transaccion   ,'  +
       'ce_moneda        ,'  +
       'ce_valor         ,'  +
       'ce_apellido1_e   ,'  +
       'ce_apellido2_e   ,'  +
       'ce_nombre_e      ,'  +
       'ce_tipo_doc_e    ,'  +
       'ce_cedula_e      ,'  +
       'ce_direccion_e   ,'  +
       'ce_titular       ,'  +
       'ce_apellido1_t   ,'  +
       'ce_apellido2_t   ,'  +
       'ce_nombre_t      ,'  +
       'ce_tipo_doc_t    ,'  +
       'ce_cedula_t      ,'  +
       'ce_direccion_t   ,'  +
       'ce_activ_econom_t,'  +
       'ce_origen_tran   ,'  +
       'ce_hora          ,'  +
       'ce_telefono      ,'  +
       'ce_telefono_e    ,'  +
       'ce_telefono_t    ,'  +
       'ce_titular_t     ,'  +
       'ce_nom_benef     ,'  +
       'ce_papp_benef    ,'  +
       'ce_sapp_benef    ,'  +
       'ce_tipo_doc_benef,'  +
       'ce_num_doc_benef ,'  +
       'ce_titular_benef ,'  +
       'ce_tipoid_iden   ,'  +
       'ce_declaracion_ah ,'  +
       'ce_declaracion_cc ,'  +
       'ce_declaracion_ho ,'  +
       'ce_declaracion_ot ,'  +
       'ce_declaracion_cd ,'  +
       'ce_declaracion_sa ,'  +
       'ce_declaracion_ve  '  +
       'ce_cod_transaccion , '  +
       'ce_origen_bines_fondos ' + --KZH Req SARLAFT_006 BPT
       ' from     cob_cuentas..cc_ctrl_efectivo '  +
       @w_filtro +
       @w_filtro2
        )


       select @w_pivote = ' where ce_pivote > ' +  convert(varchar,@i_pivote)

   exec (
       'select                    '  +
       '''FECHA''                       = convert(varchar(11),ce_fecha,101),'             +
       '''ORIGEN CAPTURA''              = RTRIM(LTRIM(isnull(ce_origen_tran,''COB''))),'  +
       '''OFICINA RECEPTORA''           = ce_oficina_recep,'                              +
       '''OFICINA ORIGEN''              = ce_oficina                     ,'  +
       '''VALOR''                       = ce_valor                       ,'  +
       '''DEB/CRED''                    = RTRIM(LTRIM(ce_transaccion))   ,'  +
       '''COD.PROD.''                   = ce_producto                    ,'  +
       '''No.CTA''                      = RTRIM(LTRIM(ce_numcta))        ,'  +
       '''No.ID''                       = RTRIM(LTRIM(ce_iden))          ,'  +
       '''TELEFONO TITULAR''            = RTRIM(LTRIM(ce_telefono))      ,'  +
       '''TIPO.ID.CONSIGNA''            = RTRIM(LTRIM(ce_tipo_doc_e))    ,'  +
       '''No.ID.CONSIGNA''              = RTRIM(LTRIM(ce_cedula_e))      ,'  +
       '''APPE1.CONSIGNA''              = RTRIM(LTRIM(ce_apellido1_e))   ,'  +
       '''APPE2.CONSIGNA''              = RTRIM(LTRIM(ce_apellido2_e))   ,'  +
       '''NOMBRE.CONSIGNA''             = RTRIM(LTRIM(ce_nombre_e))      ,'  +
       '''DIR.CONSIGNA''                = RTRIM(LTRIM(ce_direccion_e))   ,'  +
       '''TELEFONO CONSIGNA''           = RTRIM(LTRIM(ce_telefono_e))    ,'  +
       '''TIPO.ID.ENNOMBREDE''          = RTRIM(LTRIM(ce_tipo_doc_t))    ,'  +
       '''NO.ID.ENNOMBREDE''            = RTRIM(LTRIM(ce_cedula_t))      ,'  +
       '''APPE1.ENNOMBREDE''            = RTRIM(LTRIM(ce_apellido1_t))   ,'  +
       '''APPE2.ENNOMBREDE''            = RTRIM(LTRIM(ce_apellido2_t))   ,'  +
       '''NOMBRE.ENNOMBREDE''           = RTRIM(LTRIM(ce_nombre_t))      ,'  +
       '''DIR.ENNOMBREDE''              = RTRIM(LTRIM(ce_direccion_t))   ,'  +
       '''ACTIVIDAD.ECON.ENNOMBREDE''   = RTRIM(LTRIM(ce_activ_econom_t)),'  +
       '''TELEFONO ENNOMBREDE''         = RTRIM(LTRIM(ce_telefono_t))    ,'  +
       '''NOMBRE BENEF''                = RTRIM(LTRIM(ce_nom_benef))     ,'  +
       '''APELL1 BENEF''                = RTRIM(LTRIM(ce_papp_benef))    ,'  +
       '''APELL2 BENEF''                = RTRIM(LTRIM(ce_sapp_benef))    ,'  +
       '''No. DOC BENEF''               = RTRIM(LTRIM(ce_num_doc_benef)) ,'  +
       '''TIPO DOC BENEF''              = RTRIM(LTRIM(ce_tipo_doc_benef)),'  +
       '''SECUENCIAL''                  = ce_consecutivo                 ,'  +
       '''NOMBRE CTA''                  = RTRIM(LTRIM(ce_nom_cta))       ,'  +
       '''OFICIAL''                     = ce_oficial                     ,'  +
       '''USUARIO''                     = RTRIM(LTRIM(ce_usuario))       ,'  +
       '''COD CIUDAD''                  = RTRIM(LTRIM(ce_ciudad))        ,'  +
       '''COD MONEDA''                  = RTRIM(LTRIM(ce_moneda))        ,'  +
       '''HORA''                        = RTRIM(LTRIM(ce_hora))          ,'  +
       '''ORIGEN DE BIENES Y FONDOS''   = RTRIM(LTRIM(ce_origen_bines_fondos))'  +  --KZH Req SARLAFT_006 BPT
       ' from     #control_efectivo              '  +
          @w_pivote
        )
   return  0
end


if @t_trn =2864
begin

   select @w_max_consecutivo = max(ce_consecutivo) + 1
     from cc_ctrl_efectivo

   -- INSERTA INFORMACION EN LA TABLA TEMPORAL INTERMEDIA
   if @i_reproceso = '0'
   begin

      truncate table cob_cuentas..cc_ctrl_efectivo_tmp2

      insert cob_cuentas..cc_ctrl_efectivo_tmp2
      select et_consecutivo + @w_max_consecutivo,
             et_fecha,
             et_oficina,
             isnull((select en_oficial
                       from cobis..cl_ente
                      where en_tipo_ced = A.et_tipo_doc_t
                        and en_ced_ruc  = A.et_cedula_t ),1),
             rtrim(ltrim(et_usuario)),
             rtrim(ltrim(et_ciudad)),
             et_oficina_recep,
             et_producto,
             rtrim(ltrim(et_numcta)),
             rtrim(ltrim(et_nom_cta)),
             rtrim(ltrim(et_iden)),
             et_transaccion,
             '0',
             convert(money,convert(float,et_valor) / 100 ),
             et_apellido1_e,
             et_apellido2_e,
             et_nombre_e,
             et_tipo_doc_e,
             rtrim(ltrim(et_cedula_e)),
             et_direccion_e,
             et_titular,
             et_apellido1_t,
             et_apellido2_t,
             et_nombre_t,
             et_tipo_doc_t,
             rtrim(ltrim(et_cedula_t)),
             et_direccion_t,
             et_activ_econom_t,
             'PIT',
             et_hora,
             '', --et_telefono
             et_telefono_e,
             et_telefono_t,
             et_titular_t,
             et_nom_benef,
             et_papp_benef,
             et_sapp_benef,
             et_tipo_doc_benef,
             et_num_doc_benef,
             et_titular_benef,
             null,
             'P',  -- Estado de pendiente por cargar
             ce_declaracion_ah,
             ce_declaracion_cc,
             ce_declaracion_ho,
             ce_declaracion_ot,
             ce_declaracion_cd,
             ce_declaracion_sa,
             ce_declaracion_ve,
             ce_cod_transaccion,
             ce_origen_bines_fondos    --KZH Req SARLAFT_006 BPT
        from cob_cuentas..cc_ctrl_efectivo_tmp A

     if @@error <> 0 return 1
   end
   else
   begin
      -- BORRAR INFORMACION DE REGISTROS EXITOSOS DE PROCESOS ANTERIORES

      delete from cob_cuentas..cc_ctrl_efectivo_tmp2
       where ce_consecutivo >= 1
         and ce_estado_proceso = 'L'

     if @@error <> 0 return 1
   end


  -- ACTUALIZA LA INFORMACIàN EN LA TABLA DEFINITIVA
   select  @w_ce_consecutivo = 0

   while 1=1
   begin
      set rowcount 1

      select @w_ce_consecutivo    = ce_consecutivo   ,
             @w_ce_fecha          = ce_fecha         ,
             @w_ce_oficina        = ce_oficina       ,
             @w_ce_oficial        = ce_oficial       ,
             @w_ce_usuario        = ce_usuario       ,
             @w_ce_ciudad         = ce_ciudad        ,
             @w_ce_oficina_recep  = ce_oficina_recep ,
             @w_ce_producto       = ce_producto      ,
             @w_ce_numcta         = ce_numcta        ,
             @w_ce_nom_cta        = ce_nom_cta       ,
             @w_ce_iden           = ce_iden          ,
             @w_ce_transaccion    = ce_transaccion   ,
             @w_ce_moneda         = ce_moneda        ,
             @w_ce_valor          = ce_valor         ,
             @w_ce_apellido1_e    = ce_apellido1_e   ,
             @w_ce_apellido2_e    = ce_apellido2_e   ,
             @w_ce_nombre_e       = ce_nombre_e      ,
             @w_ce_tipo_doc_e     = ce_tipo_doc_e    ,
             @w_ce_cedula_e       = ce_cedula_e      ,
             @w_ce_direccion_e    = ce_direccion_e   ,
             @w_ce_titular        = ce_titular       ,
             @w_ce_apellido1_t    = ce_apellido1_t   ,
             @w_ce_apellido2_t    = ce_apellido2_t   ,
             @w_ce_nombre_t       = ce_nombre_t      ,
             @w_ce_tipo_doc_t     = ce_tipo_doc_t    ,
             @w_ce_cedula_t       = ce_cedula_t      ,
             @w_ce_direccion_t    = ce_direccion_t   ,
             @w_ce_activ_econom_t = ce_activ_econom_t,
             @w_ce_origen_tran    = ce_origen_tran   ,
             @w_ce_hora           = ce_hora          ,
             @w_ce_telefono       = ce_telefono      ,
             @w_ce_telefono_e     = ce_telefono_e    ,
             @w_ce_telefono_t     = ce_telefono_t    ,
             @w_ce_titular_t      = ce_titular_t     ,
             @w_ce_nom_benef      = ce_nom_benef     ,
             @w_ce_papp_benef     = ce_papp_benef    ,
             @w_ce_sapp_benef     = ce_sapp_benef    ,
             @w_ce_tipo_doc_benef = ce_tipo_doc_benef,
             @w_ce_num_doc_benef  = ce_num_doc_benef ,
             @w_ce_titular_benef  = ce_titular_benef ,
             @w_ce_tipoid_iden    = ce_tipoid_iden   ,
             @w_declaracion_ah    = ce_declaracion_ah,
             @w_declaracion_cc    = ce_declaracion_cc,
             @w_declaracion_ho    = ce_declaracion_ho,
             @w_declaracion_ot    = ce_declaracion_ot,
             @w_declaracion_cd    = ce_declaracion_cd,
             @w_declaracion_sa    = ce_declaracion_sa,
             @w_declaracion_ve    = ce_declaracion_ve,
             @w_cod_transaccion   = ce_cod_transaccion,
             @w_origen_bines_fondos = ce_origen_bines_fondos --KZH Req SARLAFT_006 BPT
        from cob_cuentas..cc_ctrl_efectivo_tmp2
       where ce_consecutivo  > @w_ce_consecutivo

      if @@rowcount = 0
      begin
         set rowcount 0
         break
      end

      -- INSERCION DEFINITIVA
      insert into cob_cuentas..cc_ctrl_efectivo
      (ce_consecutivo,      ce_fecha,            ce_oficina,        
       ce_oficial,          ce_usuario,          ce_ciudad,
       ce_oficina_recep,    ce_producto,         ce_numcta,         
       ce_nom_cta,          ce_iden,             ce_transaccion,    
       ce_moneda,           ce_valor,            ce_apellido1_e, 
       ce_apellido2_e,      ce_nombre_e,         ce_tipo_doc_e,      
       ce_cedula_e,         ce_direccion_e,      ce_titular,
       ce_apellido1_t,      ce_apellido2_t,      ce_nombre_t,       
       ce_tipo_doc_t,       ce_cedula_t,         ce_direccion_t,    
       ce_activ_econom_t,   ce_origen_tran,      ce_hora,        
       ce_telefono,         ce_telefono_e,       ce_telefono_t,      
       ce_titular_t,        ce_nom_benef,        ce_papp_benef,
       ce_sapp_benef,       ce_tipo_doc_benef,   ce_num_doc_benef,  
       ce_titular_benef,    ce_tipoid_iden,      ce_declaracion_ah,  
       ce_declaracion_cc,   ce_declaracion_ho,   ce_declaracion_ot, 
       ce_declaracion_cd,   ce_declaracion_sa,   ce_declaracion_ve, 
       ce_cod_transaccion,  ce_origen_bines_fondos)
      values 
      (@w_ce_consecutivo   ,@w_ce_fecha         ,@w_ce_oficina       ,
       @w_ce_oficial       ,@w_ce_usuario       ,@w_ce_ciudad        ,
       @w_ce_oficina_recep ,@w_ce_producto      ,@w_ce_numcta        ,
       @w_ce_nom_cta       ,@w_ce_iden          ,@w_ce_transaccion   ,
       @w_ce_moneda        ,@w_ce_valor         ,@w_ce_apellido1_e   ,
       @w_ce_apellido2_e   ,@w_ce_nombre_e      ,@w_ce_tipo_doc_e    ,
       @w_ce_cedula_e      ,@w_ce_direccion_e   ,@w_ce_titular       ,
       @w_ce_apellido1_t   ,@w_ce_apellido2_t   ,@w_ce_nombre_t      ,
       @w_ce_tipo_doc_t    ,@w_ce_cedula_t      ,@w_ce_direccion_t   ,
       @w_ce_activ_econom_t,@w_ce_origen_tran   ,@w_ce_hora          ,
       @w_ce_telefono      ,@w_ce_telefono_e    ,@w_ce_telefono_t    ,
       @w_ce_titular_t     ,@w_ce_nom_benef     ,@w_ce_papp_benef    ,
       @w_ce_sapp_benef    ,@w_ce_tipo_doc_benef,@w_ce_num_doc_benef ,
       @w_ce_titular_benef ,@w_ce_tipoid_iden,   @w_declaracion_ah,   
       @w_declaracion_cc,   @w_declaracion_ho,   @w_declaracion_ot,   
       @w_declaracion_cd,   @w_declaracion_sa,   @w_declaracion_ve,   
       @w_cod_transaccion,  @w_origen_bines_fondos ) --KZH Req SARLAFT_006 BPT
      
      if @@error <> 0 return 1
      
      -- ACTUALIZACION DE LA TABLA TEMPORAL INTERMEDIA
      update cob_cuentas..cc_ctrl_efectivo_tmp2
      set    ce_estado_proceso = 'L'  -- Estado de Registro con Cargado Satisfactoriamente
      where  ce_consecutivo    = @w_ce_consecutivo
      
      if @@error <> 0 return 1
   end

   -- ACTUALIZACION PARA LA TABLA SEQNOS
   select @w_max_consecutivo = isnull(max(ce_consecutivo),1)
   from   cob_cuentas..cc_ctrl_efectivo

   update  cobis..cl_seqnos
   set     siguiente = @w_max_consecutivo
   where   tabla = 'cc_ctrl_efectivo'

   if @@error <> 0 return 1

   -- ACTUALIZAR TABLA DE CONTROL DE ARCHIVOS
   if not exists (select 1 from cc_ctrl_efectivo_tmp2
                   where ce_estado_proceso <> 'L')
   begin
      update cc_archivo_control
      set    ac_estado = 'L'
      where  ac_proceso = @i_proceso
      and    ac_estado = 'P'

     if @@error <> 0 return 1
   end
end


if @t_trn =  2867
begin
   return 0

   set rowcount 600

   if @i_modo = 1
       select  distinct ce_consecutivo
       from    cob_cuentas..cc_ctrl_efectivo
       where   ce_oficina_recep = @i_oficina
       and     ce_fecha         = @i_fecha_ing
       and     ce_valor         >= @w_param_lim_rioe
       and     ce_origen_tran   is null
       order by ce_consecutivo
   else  
       select distinct ce_consecutivo
       from   cob_cuentas..cc_ctrl_efectivo
       where  ce_oficina_recep = @i_oficina
       and    ce_fecha         = @i_fecha_ing
       and    ce_valor        >= @w_param_lim_rioe
       and    ce_origen_tran  is null
       and    ce_consecutivo  > @i_secuencial
       order by ce_consecutivo
   set rowcount 0
end

return 0
go

