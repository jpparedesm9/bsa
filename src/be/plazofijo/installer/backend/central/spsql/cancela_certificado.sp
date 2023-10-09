/*****************************************************************************/
/* Archivo:                cancerti.sp                                       */
/* Stored procedure:       sp_cancela_certificado                            */
/* Base de datos:          cob_pfijo                                         */
/* Producto:               Plazo Fijo                                        */
/* Disenado por:           Marcelo Cartagena                                 */
/* Fecha de escritura:     21-Oct-1999                                       */
/*****************************************************************************/
/*                           IMPORTANTE                                      */
/* Este programa es parte de los paquetes bancarios propiedad de             */
/* 'MACOSA', representantes exclusivos para el Ecuador de la                 */
/* 'NCR CORPORATION'.                                                        */
/* Su uso no autorizado queda expresamente prohibido asi como                */
/* cualquier alteracion o agregado hecho por alguno de sus                   */
/* usuarios sin el debido consentimiento por escrito de la                   */
/* Presidencia Ejecutiva de MACOSA o su representante.                       */
/*****************************************************************************/
/*                           PROPOSITO                                       */
/*      Este programa procesa la transaccion de Cancelacion de Certifi-      */
/*      cados por caja.                                                      */
/*****************************************************************************/
/*                              MODIFICACIONES                               */
/*      FECHA           AUTOR           RAZON                                */
/*      09-10-2001      D.Guerrero      Uso cob_cuentas..sp_upd_totales      */
/*      26-Dic-2001     N. Silva        Cob_remesas y verificacion de cj     */
/*      12-Dic-02       Clotilde Vargas Agregar cancelacion de decremen-     */
/*                                      tos de capital de plazo fijo         */
/*      17-Dic-02       Sandro Soto     Requerimientos Branch III            */
/*      26-Dic-02       Clotilde Vargas Aplicar movimiento de 14943          */
/*                                      Agregue ssn_branch                   */
/*      10-Jun-03       Sandro Soto     Agregada transaccion 14972 para el   */
/*                                      pago pr caja de manten. de valor     */
/*      16-Jul-03       C. Vargas       Inclusion Lavado de Dinero BDF       */
/*      11-Feb-13       Nini Salazar    Verificar si la  transacción         */
/*                                      de cancelacion  requiere validación  */
/*                                      identidad del cliente                */
/*****************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where  name = 'sp_cancela_certificado')
   drop proc sp_cancela_certificado
go

create proc sp_cancela_certificado (
@s_ssn           int,
@s_ssn_branch    int            = null,
@s_srv           varchar(30),
@s_lsrv          varchar(30),
@s_user          varchar(30),
@s_sesn          int            = null,
@s_term          varchar(10),
@s_date          datetime,
@s_ofi           smallint,      -- Localidad origen transaccion
@s_rol           smallint,
@s_org_err       char(1)        = null, -- Origen de error: [A], [S]
@s_error         int            = null,
@s_sev           tinyint        = null,
@s_msg           mensaje        = null,
@s_org           char(1),
@t_corr          char(1)        = 'N',
@t_ssn_corr      int            = null, -- Trans a ser reversada
@t_debug         char(1)        = 'N',
@t_file          varchar(14)    = null,
@t_from          varchar(32)    = null,
@t_rty           char(1)        = 'N',
@t_trn           smallint,
@t_filial        smallint       = 1,
@t_ejec          char(1)        = 'N',

@i_filial        smallint       = null,
@i_idcaja        int            = null,
@i_sld_caja      money          = null,
@i_idcierre      int            = null,
@i_cert          cuenta,
@i_cau           char(10),
@i_total         money          = 0,
@i_efe           money          = 0,   --efectivo
@i_prop          money          = 0,   --cheques propio
@i_loc           money          = 0,   --cheques locales
@i_plaz          money          = 0,   --cheques del exterior
@i_mon           tinyint,              --moneda
@i_nocaja        char(1)        = 'N',
/*Parametros para lavado de dinero - gestor */
@i_ape1          varchar(30)    = null,
@i_ape2          varchar(30)    = null,
@i_nom1          varchar(30)    = null,
@i_nom2          varchar(30)    = null,
@i_tipoid        varchar(3)     = null,
@i_numeroid      varchar(20)    = null,
@i_nacionalidad  varchar(10)    = null,
@i_direccion     varchar(80)    = null,
@i_cod_gestor    int            = null,
@i_trnb          int            = null,
@i_gestor        char(1)        = null,
/*Parametros para lavado de dinero - gestor */
@o_nombre        varchar(25)    = null out)
with encryption
as
declare  
@w_return            int,
@w_sp_name           varchar(30),
@w_factor            int,
@w_operacion         int,
@w_secuencial        int,
@w_sub_secuencia     int,
@w_secuencia         int,
@w_estado            varchar(1),
@w_signo             char(1),
@w_caja              char(1),
@w_tot_efectivo      money,
@w_tot_chqlocal      money,
@w_tot_chqremes      money,
@w_fondo             money,
@w_diferencia        money,
@w_efectivo_dep      money,
@w_efec_cert         money,
@w_loc_cert          money,
@w_plaz_cert         money,
@w_ente_benef        int,
@w_fecha_activacion  datetime,
@w_fecha_vencimiento datetime,
@w_monto             money,
@w_tasa              float,
@w_plazo             smallint,
@w_periodicidad      catalogo,
@w_retiene_impuesto  char(1),
@w_moneda            tinyint,
@w_oficina           smallint,
@w_valor_tran        money,
@w_valor_tran_efec   money,
@w_valor_tran1       money,
@w_num_tran          int,
@w_moneda_operacion  tinyint,
@w_srv_host          varchar(32),
@w_tipo_ejec         char(1),
@w_estado_ejec       char(1),
@w_time_out          char(1),
@w_error_ejec        char(1),
@w_num_error         int,
@w_msg_error         varchar(64),
@w_fl_conslds        char(1),
@w_estado_cta        char(1),
@w_idcierre          int,
@w_sld_caja          money,
@w_usadeci           char(1),
@w_numdeci           tinyint,
@w_mm_estado         catalogo,
@w_sec               int,
@w_fecha_aplicacion  datetime,
@w_fecha_hoy         datetime,
@w_mm_secuencia      int,
@w_mm_secuencial     int,
@w_retiene_capital   char(1),
@w_mm_sub_secuencia  int,
@w_beneficiario      descripcion,
@w_nefe              varchar(10),
@w_vxp               varchar(10),
@w_estado_proc       char(1),
@w_cont_mov          int,
@w_sec_historia	     int,
@w_rev_conta         char(1),
@w_error             int ,
@w_ente              int ,            --REQ330
@w_tipo_id           char(2),         --REQ330
@w_ced_ruc           varchar(30)   ,  --REQ330
@w_estado_id         int       ,  --REQ330
@w_mensaje           varchar(64),
@w_msg_valida        varchar(64),     --REQ330
@w_titularidad       char(1)
/*  Captura nombre de Stored Procedure  */
select   @w_sp_name   = 'sp_cancela_certificado'
select   @w_fecha_hoy = convert(datetime, convert (varchar,@s_date,101))

-------------------------------------
-- Verificar codigo de Transaccion --
-------------------------------------
if @t_trn <> 14544
begin
  /* Error en codigo de transaccion */
   select @w_error = 141040
   goto ERROR
end

select @w_nefe = pa_char
from   cobis..cl_parametro
where  pa_producto = 'PFI'
and    pa_nemonico = 'NEFE'

if @@rowcount = 0
begin
   select @w_error = 141140
   goto ERROR
end

select @w_vxp  = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'VXP'
and    pa_producto = 'PFI'

if @@rowcount = 0 begin
   select @w_error = 141140
   goto ERROR
end

-----------------------------------
-- Valida si se ha aperturado caja
-----------------------------------
if @s_org = 'U' and @i_nocaja <> 'S'
begin
   if @i_idcaja=0 /*Version ATX*/ -- ELI 11/11/2002
   begin
      if exists (select 1 from cob_remesas..re_caja with (nolock)
                    where  cj_filial      = @i_filial
                    and    cj_oficina     = @s_ofi
                    and    cj_rol         = @s_rol
                    and    cj_operador    = @s_user
                    and    cj_moneda      = @i_mon
                    and    cj_transaccion = 15 )
         select @t_debug = 'N'
     else
     begin
        select @w_error = 201063
        goto ERROR
     end
   end
   else /*Version Branch Explorer*/
   begin
      exec @w_return = cob_remesas..sp_verifica_caja
      @t_trn     = @t_trn,
      @s_user    = @s_user,
      @i_ofi     = @s_ofi,
      @i_srv     = @s_srv,
      @s_date    = @s_date,
      @i_filial  = @i_filial,
      @i_mon     = @i_mon,
      @i_idcaja  = @i_idcaja

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end -- FIN ELI 11/11/2002

end


/*CVA May/22/03 Validacion de la causa por si Cajas mandara otro valor */
if @i_cau not in ('1','2','3','4','5','6')
begin
   /* Nemonico de Causa del deposito no es valido */
   select @w_error = 141168
   goto ERROR
end


-----------------------------------------
-- Verificacion de Datos con certificado
-----------------------------------------
select @w_valor_tran = $0
select @w_valor_tran_efec = $0

if not exists(select 1
              from cobis..re_estado_sucursal with (nolock)
              where es_filial        = @i_filial
              and   es_oficina       = @s_ofi
              and   es_fecha_estado  = @s_date
              and   es_estado = 'A' ) begin

    select @w_error = 141256
    goto ERROR
end

if not exists(SELECT  1
              FROM    cobis..ad_estado_producto with (nolock)  
              WHERE   ep_modulo       = 14
              AND     ep_oficina      = @s_ofi
              AND     ep_fecha_estado = @s_date
              and     ep_estado = 'A') begin

    select @w_error = 141257
    goto ERROR
end

select
@o_nombre           = op_descripcion,
@w_moneda_operacion = op_moneda,
@w_operacion        = op_operacion,
@w_sec_historia	    = op_historia,
@w_ente             = op_ente         --REQ330 
from   cob_pfijo..pf_operacion
where  op_num_banco = @i_cert

if @@rowcount <> 1
begin
    select @w_error = 141004
    goto ERROR
end

/*********REQ330 VALIDACION IDENTIDAD CLIENTE**************/

if exists ( select 1 from cobis..cl_val_iden 
            where  vi_transaccion = @t_trn 
            and    vi_estado      = 'V' 
            and    (vi_ind_causal = 'N' or (vi_ind_causal = 'S' and vi_causal = @i_cau)))  and @t_corr <> 'S'    
begin

   select be_ente,
          be_condicion,
          en_ced_ruc,
          en_tipo_ced
     into #tabla_benf
   from  cob_pfijo..pf_beneficiario, cobis..cl_ente
   where en_ente = be_ente
   and   be_rol in ('T','A')
   and   be_tipo <> 'F'
   and   be_operacion = (select op_operacion from cob_pfijo..pf_operacion where op_num_banco = @i_cert)

   if @@rowcount = 0
    begin
       goto ERROR
    end

   while 1 = 1
    begin  
      
       select @w_ente        = be_ente,
              @w_titularidad = be_condicion,
              @w_tipo_id     = en_tipo_ced,
              @w_ced_ruc     = en_ced_ruc
       from #tabla_benf
   
       if @@rowcount = 0
          break
             
       if @w_titularidad = 'O'
          select @w_titularidad = 'S'
       if @w_titularidad = 'Y'
          select @w_titularidad = 'M'     
             
       -----------------------------------------------
       --inseta registro a validar la huella
       -----------------------------------------------
         exec @w_return    = cobis..sp_consulta_homini
         @s_term           = @s_term,
         @s_ofi            = @s_ofi,    
         @t_trn            = 1608,
         @i_operacion      = 'I',
         @i_titularidad    = @w_titularidad,
         @i_tipo_ced       = @w_tipo_id,
         @i_ced_ruc        = @w_ced_ruc,
         @i_ref            = @i_cert,
         @i_user           = @s_user,
         @i_trn            = @t_trn,
         @i_id_caja        = @i_idcaja,
         @i_sec_cobis      = @s_ssn  
         
         if @w_return <> 0 or @@error <> 0
         begin
            goto ERROR
         end 
        
         delete from #tabla_benf
         where be_ente    = @w_ente
         and   en_ced_ruc = @w_ced_ruc

     end --END WHILE
   
         -----------------------------------------------
         --invocar al servicio de validacion de huella
         -----------------------------------------------
         exec @w_return    = cobis..sp_consulta_homini
         @s_term           = @s_term,
         @s_ofi            = @s_ofi,
         @i_operacion      = 'V',
         @i_ref            = @i_cert,
         @i_user           = @s_user,
         @i_id_caja        = @i_idcaja,
         @i_trn            = @t_trn,
         @i_sec_cobis      = @s_ssn,
         @o_codigo         = @w_estado_id out ,
         @o_mensaje        = @w_msg_valida out      
         
         if @w_return <> 0 or @@error <> 0
         begin
            goto ERROR
         end 
       
         -- VALIDACION MENSAJES RESTRICTIVOS HOMINI 
         if @w_estado_id <> 0
         begin
            select @w_error  = @w_estado_id,
                   @w_mensaje = @w_msg_valida
            goto ERROR
         end
end
            
  
/*********************************************************/
if @w_moneda_operacion <> @i_mon
begin
   /* Moneda no corresponde a Orden de Pago */
    select @w_error = 141167
    goto ERROR
end

if @t_corr = 'N'
begin
   select @w_caja        = 'N'
   select @w_estado_proc = 'E'
end
else
begin
   select @w_caja        = 'S'
   select @w_estado_proc = 'A'
end

if @i_cau = '1'   --Cancelacion
begin
   select @w_num_tran = 14903
   set rowcount 1

      /* SI NO ENCUENTRO EN EFECTIVO VERIFICO SI SE GENERO ORIGINALMENTE (14903) EN OTRA FORMA DE PAGO 
      PERO LA EMISION (14943) SE HIZO EN EFECTIVO */
      select
      @w_valor_tran    = isnull(ec_valor,0),
      @w_valor_tran_efec= @i_efe,
      @w_secuencial    = ec_secuencial,
      @w_sub_secuencia = ec_sub_secuencia,
      @w_secuencia     = ec_secuencia,
      @w_beneficiario  = ec_descripcion
      from   pf_emision_cheque x
      where  ec_operacion         = @w_operacion
      and    ec_tran              = @w_num_tran
      and    ec_estado            = @w_estado_proc
      and    ec_fecha_emision is not null
      and    isnull(ec_caja, 'N') = @w_caja
      and    exists( select 1
                     from   pf_emision_cheque y  with (nolock)
                     where  y.ec_operacion      = @w_operacion
                     and    y.ec_tran           = 14943
                     and    y.ec_estado         = 'A'
                     and    y.ec_fecha_emision is not null
                     and    y.ec_fpago          = @w_nefe
                     and    y.ec_valor          = @i_efe
                     and    y.ec_numero         = x.ec_secuencial)
      order by ec_fecha_mov

   set rowcount 0
end

if @i_cau = '2'  --Cancelacion de Intereses
begin

   select  @w_num_tran  = 14905
     
   set rowcount 1
      /* SI NO ENCUENTRO EN EFECTIVO VERIFICO SI SE GENERO ORIGINALMENTE (14095) EN OTRA FORMA DE PAGO 
      PERO LA EMISION (14943) SE HIZO EN EFECTIVO */
      select
      @w_valor_tran    = isnull(ec_valor,0),
      @w_valor_tran_efec= @i_efe,
      @w_secuencial    = ec_secuencial,
      @w_sub_secuencia = ec_sub_secuencia,
      @w_secuencia     = ec_secuencia,
      @w_beneficiario  = ec_descripcion
      from   pf_emision_cheque x
      where  ec_operacion         = @w_operacion
      and    ec_tran              in( 14905,14155)
      and    ec_estado            = @w_estado_proc
      and    ec_fecha_emision is not null
      and    isnull(ec_caja, 'N') = @w_caja
      and    exists( select 1
                     from   pf_emision_cheque y  with (nolock)
                     where  y.ec_operacion      = @w_operacion
                     and    y.ec_tran           = 14943
                     and    y.ec_estado         = 'A'
                     and    y.ec_fecha_emision is not null
                     and    y.ec_fpago          = @w_nefe
                     and    y.ec_valor          = @i_efe
                     and    y.ec_numero         = x.ec_secuencial)
      order by ec_fecha_mov

   set rowcount 0

end

if @i_cau = '3'  --Cancelacion de Renovacion
begin
   select @w_num_tran = 14904

   set rowcount 1

      /* SI NO ENCUENTRO EN EFECTIVO VERIFICO SI SE GENERO ORIGINALMENTE (14904) EN OTRA FORMA DE PAGO 
      PERO LA EMISION (14943) SE HIZO EN EFECTIVO */
      select
      @w_valor_tran    = isnull(ec_valor,0),
      @w_valor_tran_efec= @i_efe,
      @w_secuencial    = ec_secuencial,
      @w_sub_secuencia = ec_sub_secuencia,
      @w_secuencia     = ec_secuencia,
      @w_beneficiario  = ec_descripcion
      from   pf_emision_cheque x
      where  ec_operacion         = @w_operacion
      and    ec_tran              = @w_num_tran
      and    ec_estado            = @w_estado_proc
      and    ec_fecha_emision is not null
      and    isnull(ec_caja, 'N') = @w_caja
      and    exists( select 1
                     from   pf_emision_cheque y  with (nolock)
                     where  y.ec_operacion      = @w_operacion
                     and    y.ec_tran           = 14943
                     and    y.ec_estado         = 'A'
                     and    y.ec_fecha_emision is not null
                     and    y.ec_fpago          = @w_nefe
                     and    y.ec_valor          = @i_efe
                     and    y.ec_numero         = x.ec_secuencial)
      order by ec_fecha_mov

   set rowcount 0
end

if @i_cau = '4'  --Cancelacion por Devolucion de Cheque Protestado
begin
   set rowcount 1
   select @w_num_tran = 14543

      /* SI NO ENCUENTRO EN EFECTIVO VERIFICO SI SE GENERO ORIGINALMENTE (14543) EN OTRA FORMA DE PAGO 
      PERO LA EMISION (14943) SE HIZO EN EFECTIVO */
      select
      @w_valor_tran    = isnull(ec_valor,0),
      @w_valor_tran_efec= @i_efe,
      @w_secuencial    = ec_secuencial,
      @w_sub_secuencia = ec_sub_secuencia,
      @w_secuencia     = ec_secuencia,
      @w_beneficiario  = ec_descripcion
      from   pf_emision_cheque x
      where  ec_operacion         = @w_operacion
      and    ec_tran              = @w_num_tran
      and    ec_estado            = @w_estado_proc
      and    ec_fecha_emision is not null
      and    isnull(ec_caja, 'N') = @w_caja
      and    exists( select 1
                     from   pf_emision_cheque y with (nolock)
                     where  y.ec_operacion      = @w_operacion
                     and    y.ec_tran           = 14943
                     and    y.ec_estado         = 'A'
                     and    y.ec_fecha_emision is not null
                     and    y.ec_fpago          = @w_nefe
                     and    y.ec_valor          = @i_efe
                     and    y.ec_numero         = x.ec_secuencial)
      order by ec_fecha_mov

   set rowcount 0
end

if @i_cau = '5'  --Enajenación
begin
   set rowcount 1
   select @w_num_tran = 14168


      /* SI NO ENCUENTRO EN EFECTIVO VERIFICO SI SE GENERO ORIGINALMENTE (14168) EN OTRA FORMA DE PAGO 
      PERO LA EMISION (14943) SE HIZO EN EFECTIVO */
      select
      @w_valor_tran    = isnull(ec_valor,0),
      @w_valor_tran_efec= @i_efe,
      @w_secuencial    = ec_secuencial,
      @w_sub_secuencia = ec_sub_secuencia,
      @w_secuencia     = ec_secuencia,
      @w_beneficiario  = ec_descripcion
      from   pf_emision_cheque x
      where  ec_operacion         = @w_operacion
      and    ec_tran              = @w_num_tran
      and    ec_estado            = @w_estado_proc
      and    ec_fecha_emision is not null
      and    isnull(ec_caja, 'N') = @w_caja
      and    exists( select 1
                     from   pf_emision_cheque y with (nolock)
                     where  y.ec_operacion      = @w_operacion
                     and    y.ec_tran           = 14943
                     and    y.ec_estado         = 'A'
                     and    y.ec_fecha_emision is not null
                     and    y.ec_fpago          = @w_nefe
                     and    y.ec_valor          = @i_efe
                     and    y.ec_numero         = x.ec_secuencial)
      order by ec_fecha_mov

   set rowcount 0
end

if @w_moneda_operacion = @i_mon
begin
   if @w_valor_tran = $0 or @w_valor_tran_efec = $0 
   begin
     select @w_error = 141012
     goto ERROR
   end
end

select @w_usadeci = mo_decimales
from   cobis..cl_moneda
where  mo_moneda = @w_moneda_operacion

if @w_usadeci = 'S'
    select @w_numdeci = isnull(pa_tinyint,0)
    from   cobis..cl_parametro
    where  pa_nemonico = 'DCI'
    and    pa_producto = 'PFI'
else
   select @w_numdeci = 0

if round(@w_valor_tran_efec, @w_numdeci) <> round(@i_efe, @w_numdeci)
begin
   select @w_error = 141012
   goto ERROR
end



BEGIN TRAN

--------------------------------------
-- Actualizacion de Totales de cajero
--------------------------------------
if @t_trn = 14544 and @i_nocaja <> 'S'
begin
   exec @w_return = cob_remesas..sp_upd_totales
   @i_ofi             = @s_ofi,
   @i_rol             = @s_rol,
   @i_user            = @s_user,
   @i_trn             = @t_trn,
   @i_nodo            = @s_srv,
   @i_tipo            = 'L',
   @i_corr            = @t_corr,
   @i_efectivo        = @i_efe,
   @i_chq_locales     = @i_loc,
   @i_chq_ot_plaza    = @i_plaz,
   @i_ssn             = @s_ssn,
   @i_filial          = @i_filial,
   @i_idcaja          = @i_idcaja,
   @i_idcierre        = @i_idcierre,
   @i_saldo_caja      = @i_sld_caja,
   @i_mon             = @i_mon,
   @i_causa           = @i_cau

   if @w_return <> 0
   begin
     select @w_error = 205000
     goto ERROR
   end
end

if @t_corr = 'N'
begin

   update pf_emision_cheque with (rowlock) set
   ec_caja       = 'S',
   ec_fecha_caja = @s_date,
   ec_estado     = 'A'
   where   ec_operacion     = @w_operacion
   and     ec_tran          = @w_num_tran
   and     ec_estado        = 'E'
   and     ec_fecha_emision is not null
   and     ec_secuencial    = @w_secuencial
   and     ec_sub_secuencia = @w_sub_secuencia
   and     ec_secuencia     = @w_secuencia
   
   if @@rowcount = 0
   begin
     select @w_error = 141111
     goto ERROR
   end

   select   @w_sub_secuencia 	= ec_sub_secuencia,
   	    @w_secuencia	= ec_secuencia     
   from	    pf_emision_cheque with (nolock)  
   where    ec_operacion      = @w_operacion
   and      ec_tran           = 14943
   and      ec_estado         = 'A'
   and      ec_fecha_emision is not null
   and      ec_fpago          = @w_nefe
   and      ec_valor          = @i_efe
   and      ec_numero         = @w_secuencial
   and      ec_fecha_mov      = @s_date

   select @w_mm_estado = 'A', @w_sec = @s_ssn,
          @w_fecha_aplicacion = convert(datetime,convert(varchar,@s_date,101))

   update pf_mov_monet with (rowlock)
   set mm_fecha_aplicacion  = @w_fecha_aplicacion,
       mm_secuencial        = @w_sec,
       mm_estado            = @w_mm_estado,
       mm_fecha_real        = getdate(),
       mm_usuario           = @s_user,
       mm_ssn_branch	    = @s_ssn_branch 
   where  mm_operacion      = @w_operacion
   and    mm_tran           = 14943 --Emision de ordenes de pago
   and	  mm_estado 	    = 'A'
   and	  mm_valor          = @i_efe
   and    mm_secuencia 		= @w_secuencia
   and    mm_sub_secuencia 	= @w_sub_secuencia
   
   if @@error <> 0
   begin
     select @w_error = 145020
     goto ERROR
   end

   update pf_mov_monet with (rowlock)
   set mm_oficina         = @s_ofi, --Oficina de cancelacion de intereses
       mm_beneficiario    = @w_ente_benef,
       mm_usuario         = @s_user
   where  mm_operacion    = @w_operacion
   and    mm_tran         = 14943 --Emision de ordenes de pago
   and    mm_producto     = 'CAJPF' --Nemonico para cuenta definitiva

   if @@error <> 0
   begin
     select @w_error = 145020
     goto ERROR
   end

   update  pf_transaccion with (rowlock) 
   set	   tr_ofi_usu 	= @s_ofi
   from pf_transaccion, pf_transaccion_det
   where tr_operacion  	= td_operacion 
   and	 tr_secuencial	= td_secuencial 
   and	 tr_secuencia 	= @w_secuencia
   and	 tr_estado  	= 'ING'
   and	 tr_fecha_mov  	= @s_date
   and	 tr_tran  	in (14903,14943,14904)
   and   tr_tipo_trn 	in ('EOP')
   and	 td_concepto	= 'EFEC'
   and	 td_aux		= @w_sub_secuencia
   and	 td_monto	= @i_efe

   if @@error <> 0
   begin
     select @w_error = 145020
     goto ERROR
   end
end
else
begin
   /****************************************************/
   /*       REVERSOS DE VALORES EN CAJAS               */
   /****************************************************/

/*      update pf_emision_cheque set
      ec_caja          = null,
      ec_fecha_caja    = null,
      ec_secuencia     = @w_secuencia,
      ec_estado        = null,
      ec_fecha_emision = null
      where  ec_operacion  = @w_operacion
      and    ec_tran       = @w_num_tran
      and    ec_estado     = @w_estado_proc
      and    ec_fecha_emision is not null
      and    ec_secuencial    = @w_secuencial
      and    ec_sub_secuencia = @w_sub_secuencia
      and    ec_secuencia     = @w_secuencia

      if @@rowcount = 0 or @@error <> 0
      begin
         select @w_error = 141111
         goto ERROR
      end
*/

if @t_debug = 'S' print '@w_num_tran ' + cast ( @w_num_tran as varchar )
if @t_debug = 'S' print '@i_efe ' + cast ( @i_efe as varchar )
if @t_debug = 'S' print '@w_valor_tran ' + cast ( @w_valor_tran as varchar )
if @t_debug = 'S' print '@w_secuencial ' + cast ( @w_secuencial as varchar )
if @t_debug = 'S' print '@s_date ' + cast ( @s_date as varchar )
if @t_debug = 'S' print '@w_secuencia ' + cast ( @w_secuencia as varchar )
if @t_debug = 'S' print '@w_sub_secuencia ' + cast ( @w_sub_secuencia as varchar )

   select @w_rev_conta = 'N'


   if @i_efe = @w_valor_tran begin
      update pf_emision_cheque with (rowlock)
      set	ec_caja          = null,
         	ec_fecha_caja    = null,
         	ec_estado        = null,
        	ec_fecha_emision = null
      where  ec_operacion      = @w_operacion
      and    ec_tran           = @w_num_tran
      and    ec_estado         = 'A'
      and    ec_fecha_emision is not null
      and    ec_secuencial     = @w_secuencial
      and    ec_sub_secuencia = @w_sub_secuencia
      and    ec_secuencia     = @w_secuencia

      if @@error <> 0
      begin
        select @w_error = 145020
        goto ERROR
      end

      select @w_rev_conta = 'S'

   end
   else begin
      update pf_emision_cheque with (rowlock)
      set	ec_caja          = null,
         	ec_fecha_caja    = null
      where  ec_operacion      = @w_operacion
      and    ec_tran           = @w_num_tran
      and    ec_estado         = 'A'
      and    ec_fecha_emision is not null
      and    ec_secuencial     = @w_secuencial
      and    ec_sub_secuencia = @w_sub_secuencia
      and    ec_secuencia     = @w_secuencia

      if @@error <> 0
      begin
        select @w_error = 145020
        goto ERROR
      end
  end  

   select   @w_sub_secuencia 	= ec_sub_secuencia,
   	    @w_secuencia	= ec_secuencia     
   from	    pf_emision_cheque  with (nolock)
   where    ec_operacion      = @w_operacion
   and      ec_tran           = 14943
   and      ec_estado         = 'A'
   and      ec_fecha_emision is not null
   and      ec_fpago          = @w_nefe
   and      ec_valor          = @i_efe
   and      ec_numero         = @w_secuencial
   and      ec_fecha_mov      = @s_date

   update pf_emision_cheque with (rowlock) set
   ec_estado        = 'R'
   where  ec_operacion      = @w_operacion
   and    ec_tran           = 14943
   and    ec_estado         = 'A'
   and    ec_fecha_emision is not null
   and    ec_fpago          = @w_nefe
   and    ec_valor          = @i_efe
   and    ec_numero         = @w_secuencial
   and    ec_fecha_mov      = @s_date
 
   if @@error <> 0 begin
      select @w_error = 141111
      goto ERROR
   end

   /*CVA Dic/28/2002 Reversar los movimientos por emision de ordenes 14943 */

   update pf_mov_monet with (rowlock)
   set  mm_estado 		= 'R',
       	mm_ssn_branch	    = @s_ssn_branch 
   where  mm_operacion  	= @w_operacion
   and    mm_secuencia 		= @w_secuencia
   and    mm_sub_secuencia 	= @w_sub_secuencia
   and    mm_valor	   	= @i_efe                    

   if @@error <> 0 begin
      select @w_error = 141111
      goto ERROR
   end

   ----------------------------------------------------------------------
   -- Proceso para insertar en pf_historia el reverso de la orden de pago
   -----------------------------------------------------------------------
   insert pf_historia (hi_operacion  , hi_secuencial  ,   hi_fecha,
                       hi_trn_code   , hi_valor       ,   hi_funcionario,
                       hi_oficina    , hi_fecha_crea  ,   hi_fecha_mod,
                       hi_observacion)
   values             (@w_operacion,   @w_sec_historia,   @s_date,
                       @w_num_tran,    @i_efe,            @s_user, 
                       @s_ofi,         @s_date,           @s_date,
                       'REVERSAR ORDEN DE PAGO')
   if @@error <> 0 begin
      select @w_error = 143006
      goto ERROR
   end

   ---------------------------
   -- Actualizar pf_operacion
   ---------------------------
   update pf_operacion with (rowlock)
   set    op_historia  = @w_sec_historia + 1  
   where  op_operacion = @w_operacion
 
   if @@error <> 0 begin
      select @w_error = 143006
      goto ERROR
   end

   if @w_rev_conta = 'S' begin

      exec @w_return = sp_aplica_conta
      @i_anulacion     = 'S',
      @i_operacionpf   = @w_operacion,
      @i_tipo_trn      = 'EOP',
      @i_fecha         = @s_date,
      @i_secuencia     = @w_secuencia

      if @w_return <> 0 begin
         select @w_error = @w_return
         goto ERROR
      end
   end  
end

if @t_ejec = 'R'
begin
   select 'results_submit_rpc', 
   r_nombre = @o_nombre

   exec @w_return = cob_remesas..sp_resultados_branch_caja
   @i_sldcaja = @i_sld_caja,
   @i_idcierre = @i_idcierre,
   @i_ssn_host = @s_ssn

   if @w_return <> 0 begin
      select @w_error = @w_return
      goto ERROR
   end
end

COMMIT TRAN

return 0

ERROR:

while @@trancount > 0 ROLLBACK TRAN

exec cobis..sp_cerror
@t_from   = @w_sp_name,
@i_num    = @w_error,
@i_msg    = @w_mensaje

return @w_error

go