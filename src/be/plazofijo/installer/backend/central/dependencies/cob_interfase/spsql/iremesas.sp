/************************************************************************/
/*  Archivo               : icartera.sp                                 */
/*  Stored procedure      : sp_icartera                                 */
/*  Base de datos         : cob_pfijo                                   */
/*  Producto              : Plazo_fijo                                  */
/*  Disenado por          : Oscar Saavedra                              */
/*  Fecha de documentacion: 29 de Noviembre de 2016                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Este programa busca desacoplar el modulo de remesas con el modulo   */
/*  de plazo fijo                                                       */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA          AUTOR              RAZON                             */
/*  29/Nov/2016    Oscar Saavedra     Emision Inicial DPF-H91368        */
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if OBJECT_ID(N'tempdb..#re_detpago_his', N'U') is not null
   drop table #re_detpago_his
   
create table #re_detpago_his (
operacion       varchar(24)    null,
reintegro       char(1)        null,
fecha_reint     datetime       null )

if OBJECT_ID(N'tempdb..#re_banco', N'U') is not null
   drop table #re_banco

create table #re_banco (
ba_banco      varchar(24)      null )

if OBJECT_ID(N'tempdb..#re_banco_org_ach', N'U') is not null
   drop table #re_banco_org_ach

create table #re_banco_org_ach (
br_banco     varchar(24)   null,
br_filial    int           null
)
    
if OBJECT_ID(N'tempdb..#re_banco_desc', N'U') is not null
   drop table #re_banco_desc

create table #re_banco_desc (
iba_banco        varchar(24)      null,
iba_descripcion  varchar(64)      null)

 
if exists (select 1 from sysobjects where  name = 'sp_iremesas')
   drop proc sp_iremesas
go

create proc sp_iremesas (
   @s_ssn               int             = NULL,
   @s_date              datetime        = NULL,
   @s_term              varchar(30)     = NULL,
   @s_sesn              int             = NULL,
   @s_srv               varchar(30)     = NULL,
   @s_lsrv              varchar(30)     = NULL,
   @s_user              varchar(30)     = NULL,
   @s_ofi               smallint        = NULL,
   @s_rol               smallint        = NULL,
   @s_ssn_corr          int             = NULL,
   @s_org               char(1)         = NULL,
   @s_ssn_branch        int             = NULL,
   @t_debug             char(1)         = NULL,
   @t_file              varchar(14)     = NULL,
   @t_trn               smallint        = NULL,
   @t_corr              char(1)         = 'N', 
   @t_ssn_corr          int             = NULL, 
   @i_operacion         varchar(2)      = NULL,
   @i_categoria         char(1)         = NULL,
   @i_tipo_ente         char(1)         = NULL,
   @i_rol_ente          char(1)         = NULL,
   @i_tipo_def          char(1)         = NULL,
   @i_prod_banc         smallint        = NULL,
   @i_producto          tinyint         = NULL,
   @i_moneda            int             = NULL,
   @i_tipo              char(1)         = NULL,
   @i_codigo            int             = NULL,
   @i_servicio          varchar(10)     = NULL,
   @i_rubro             varchar(10)     = NULL,
   @i_disponible        money           = NULL,
   @i_contable          money           = NULL,
   @i_promedio          money           = NULL,
   @i_personaliza       char(1)         = NULL,
   @i_oficina           int             = NULL,
   @i_filial            int             = NULL,
   @i_fecha             datetime        = NULL,
   @i_cod_ope           varchar(24)     = NULL,
   @i_reintegro         char(1)         = NULL,
   @i_banco             varchar(24)     = NULL,
   @i_operacion_cta     int             = NULL,
   @i_numdias           int             = NULL,
   @i_operacion_fecha   char(1)         = NULL,
   @i_hd_secuencial     int             = NULL,
   @i_ofiorig           int             = NULL,
   @i_fecha_crea        datetime        = NULL,
   @i_of_destino        int             = NULL,
   @i_tidpo_doc         char(3)         = NULL,
   @i_doc               varchar(30)     = NULL,
   @i_beneficiario      varchar(20)     = NULL,
   @i_tipo_ben          char(1)         = NULL,
   @i_monto             money           = NULL, 
   @i_conv_convenio     int             = NULL, 
   @i_fecha_reintegro   datetime        = NULL,
   @i_cod_operacion     int             = NULL,
   @i_mon               int             = NULL,
   @i_efectivo          money           = NULL,
   @i_chq_locales       money           = NULL,
   @i_idcaja            int             = NULL,
   @i_idcierre          int             = NULL,
   @i_saldo_caja        money           = NULL,
   @i_sldcaja           money           = NULL,
   @i_op_cod_operacion  int             = NULL,
   @i_fecha_proceso     datetime        = NULL,
   @i_operacion_giro    int             = NULL,
   @i_fecha_ini         datetime        = NULL,
   @i_fecha_fin         datetime        = NULL,
   @i_cuenta            smallint        = NULL,
   @i_bco               varchar(15)     = NULL,
   @i_prop              money           = NULL,
   @i_loc               money           = NULL,
   @i_cext              money           = NULL,
   @i_sld_caja          money           = NULL,
   @i_causa             char(1)         = NULL,
   @i_transaccion       int             = NULL,
   @i_estado            char(1)         = NULL,
   @i_cliente           int             = NULL,
   @i_rol_ent           char(1)         = NULL,
   @i_estado_pq         char(1)         = NULL,
   @i_giro              char(1)         = NULL,
   @o_existe_remesas    char(1)         = NULL OUT,
   @o_valor_total       money           = NULL OUT,
   @o_num_chq_devueltos int             = NULL OUT,
   @o_dia               int             = NULL OUT,
   @o_fecha_proc        datetime        = NULL OUT,
   @o_hd_secuencial     int             = NULL OUT,
   @o_valor             money           = NULL OUT,
   @o_cantidad          money           = NULL OUT,
   @o_existe_caja       int             = NULL OUT,
   @o_cod_paquete       int             = NULL OUT) 
with encryption   
as

declare
   @w_error           int,
   @w_mensaje         varchar(255),
   @w_producto        int,
   @w_return          int,
   @w_sp_name         varchar(24),
   @w_deposito_min    money     

select @w_sp_name = 'sp_iremesas'

/* VALIDACION EXISTENCIA DEL PRODUCTO DE AHORROS */
select @w_producto = COUNT(1) 
from   cobis..cl_producto 
where  pd_producto = 10
and    pd_estado   = 'V'

if @w_producto = 0
begin
   /* MAPEO DE VARIBALES */
   select @o_existe_remesas    = 'N' 
   select @o_valor_total       = 0
   select @o_hd_secuencial     = 0
   select @o_cod_paquete       = 0
  
   if @i_operacion = 'AA' and @i_operacion_fecha = 'D'
      select @o_dia = datepart(dw, @i_fecha) 

   if @i_operacion = 'AA' and @i_operacion_fecha = 'M'
      select @o_fecha_proc = convert(varchar(12),dateadd(dd,-@i_numdias,@i_fecha),101)
end


/* LA LECTURA DE LA INFORMACION DE COBIS SE HABILITARA DEPENDIENDO DE LA NECESIDAD */
if @w_producto > 0 
begin 
   
   select @o_existe_remesas = 'S'

   if @i_operacion = 'A'
   begin
      
      exec @w_return = cob_remesas..sp_genera_costos
           @i_categoria    = @i_categoria,
           @i_tipo_ente    = @i_tipo_ente,
           @i_rol_ente     = @i_rol_ente,
           @i_tipo_def     = @i_tipo_def,
           @i_prod_banc    = @i_prod_banc,
           @i_producto     = @i_producto,
           @i_moneda       = @i_moneda,
           @i_tipo         = @i_tipo,
           @i_codigo       = @i_codigo,
           @i_servicio     = @i_servicio,
           @i_rubro        = @i_rubro,
           @i_disponible   = @i_disponible,
           @i_contable     = @i_contable,
           @i_promedio     = @i_promedio,
           @i_personaliza  = @i_personaliza,
           @i_filial       = @i_filial,
           @i_oficina      = @s_ofi,
           @i_fecha        = @s_date,
           @o_valor_total  = @w_deposito_min out

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end

      select @o_valor_total = @w_deposito_min
   end
   
   if @i_operacion = 'B'
   begin
   
      select lc_long_cta
      from cob_remesas..re_long_cta_ach
      where lc_tipo_cta_ach = @i_producto
      
      if @@rowcount = 0
      begin
         select @w_error = 351090
         goto ERROR
      end
   end
   
   if @i_operacion = 'C'
   begin
    
      insert into #re_detpago_his 
      select hd_cod_ope, hd_reintegro, hd_fecha_reintegro
      from cob_remesas_his..re_detpago_his
      where hd_cod_ope   = @i_cod_ope
        and hd_reintegro = @i_reintegro
        
      if @@error <> 0
      begin
         select @w_error = 351090
         goto ERROR
      end
   end
   
   if @i_operacion = 'D'
   begin
      insert into #re_banco
      select ba_banco 
      from cob_remesas..re_banco
      where ba_banco = @i_banco
   end
   
   /*
   if @i_operacion = 'E'
   begin
   
      insert into #re_banco_org_ach
      select br_banco, br_filial
      from cob_remesas..re_banco_org_ach
      where br_banco = @i_banco
   end
   */
   
   if @i_operacion = 'F'
   begin
      select @o_num_chq_devueltos = isnull(count(*),0)
      from cob_remesas..re_cheque_rec
      where cr_status         = 'D'
        and cr_tipo_cheque    in ('T','L')
        and cr_procedencia    <> 'B'
        and cr_producto       = 14
        and cr_cta_depositada = @i_operacion_cta
   end
   
   if @i_operacion = 'G'
   begin
      exec @w_return     = cob_remesas..sp_mant_fecha
           @i_fecha      = @i_fecha,
           @i_operacion  = @i_operacion_fecha,
           @i_numdias    = @i_numdias,
           @o_dia        = @o_dia        out,
           @o_fecha_proc = @o_fecha_proc out

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'H'
   begin

      select @o_hd_secuencial = max(isnull(hd_secuencial,0))
      from cob_remesas_his..re_detpago_his
   end
   
   if @i_operacion = 'I'
   begin
   
      insert cob_remesas_his..re_detpago_his
             (hd_secuencial,    hd_ofiexp,        hd_fecha_giro,          hd_ofi_desti,
              hd_tipo_doc_bene, hd_num_doc_bene,  hd_dig_verif_nit_bene,  hd_apellidos_bene,
              hd_nombres_bene,  hd_direc_bene,    hd_tel_bene,            hd_tipo_bene,
              hd_forma_pago,    hd_valor_giro,    hd_valor_comis,         hd_valor_porte,
              hd_valor_iva,     hd_cod_convenio,  hd_reintegro,           hd_cod_ope,
              hd_estado,        hd_fecha_pago,    hd_sec_pago,            hd_sec_bloqueo,
              hd_fecha_reintegro
      )
      values (@i_hd_secuencial, @i_ofiorig,       @i_fecha_crea,          @i_of_destino,
              @i_tidpo_doc,     @i_doc,           null,                   null, 
              @i_beneficiario,  null,             null,                   @i_tipo_ben,
              42,               @i_monto,         null,                   null,
              null,             @i_conv_convenio, 'N',                    @i_cod_operacion,
              'P',              null,             null,                   null,
              @i_fecha_reintegro
      )
      
      if @@error <> 0
      begin
         select @w_error = @@error
         goto ERROR    
      end   
   end
   
   if @i_operacion = 'J'
   begin
   
      exec @w_return = cob_remesas..sp_upd_totales
           @i_ofi          = @s_ofi,
           @i_rol          = @s_rol,
           @i_user         = @s_user,
           @i_mon          = @i_mon,
           @i_trn          = @t_trn,
           @i_nodo         = @s_srv,
           @i_tipo         = 'L',
           @i_corr         = @t_corr,
           @i_efectivo     = @i_efectivo,
           @i_cheque       = 0,
           @i_chq_locales  = @i_chq_locales,
           @i_chq_ot_plaza = 0,
           @i_otros        = 0,
           @i_interes      = 0,
           @i_adj_int      = 0,
           @i_adj_cap      = 0,
           @i_ssn          = @s_ssn,
           @i_filial       = @i_filial,     --AJ01
           @i_idcaja       = @i_idcaja,     --AJ01
           @i_idcierre     = @i_idcierre,   --AJ01
           @i_saldo_caja   = @i_saldo_caja  --AJ01

     if @w_return <> 0
     begin
        select @w_error = @w_return
        goto ERROR    
     end      
   end
  
   if @i_operacion = 'K'
   begin
   
      exec @w_return = cob_remesas..sp_verifica_caja
           @t_trn    = @t_trn, 
           @s_user   = @s_user,
           @s_ofi    = @s_ofi,
           @s_srv    = @s_srv,
           @s_date   = @s_date,
           @i_filial = @i_filial,
           @i_ofi    = @s_ofi,
           @i_mon    = @i_moneda,
           @i_idcaja = @i_idcaja
      
      if @w_return <> 0
      begin
        select @w_error = @w_return
        goto ERROR    
      end
   end
  
   if @i_operacion ='L'
   begin
  
      exec @w_return = cob_interfase..sp_iremesas
           @i_operacion = 'L',
           @i_sldcaja   = @i_sldcaja,
           @i_idcierre  = @i_idcierre,
           @i_ssn_host  = @s_ssn
           
      if @w_return <> 0
      begin
        select @w_error = @w_return
        goto ERROR    
      end
   end
   if @i_operacion ='M'
   begin
      UPDATE  cob_remesas_his..re_detpago_his
      SET     hd_reintegro       = 'S',
              hd_estado          = 'D',
              hd_fecha_reintegro = @i_fecha_proceso
      WHERE   hd_cod_ope         = @i_op_cod_operacion 
        
      if @@error <> 0
      begin
         select @w_error  = 45
         goto ERROR    
      end   
   end
   if @i_operacion ='N'
   begin
      select @o_hd_secuencial = 0
      select @o_hd_secuencial = 1
      from   cob_remesas_his..re_detpago_his
      where  hd_cod_ope       = @i_operacion_giro
        and  hd_estado        = 'O'
   end
  
   if @i_operacion ='O'
   begin
      if @i_producto = 11  --devolucion
         UPDATE  cob_remesas_his..re_detpago_his
         SET     hd_reintegro    = 'N',
                 hd_estado       = 'P'        
         WHERE   hd_cod_ope      = @i_operacion_giro
      else --pago
         UPDATE  cob_remesas_his..re_detpago_his
         SET     hd_estado       = 'P',      
                 hd_fecha_pago   = null
         WHERE   hd_cod_ope      = @i_operacion_giro
       
      if @@error <> 0
      begin
         select @w_error  = @@error
         goto ERROR    
      end   
   end
  
   if @i_operacion ='P'
   begin
      select  @o_valor            = @o_valor + isnull(sum(pp_monto),0),
              @o_cantidad         = @o_cantidad + isnull(count(1),0)
      from    sb_pagopostal_pend, cob_remesas_his..re_detpago_his
      where   pp_cod_operacion    = hd_cod_ope
      and     pp_oficina_destino  = @i_oficina
      and     pp_estado           = 'D'
      and     pp_cod_convenio     is not null
      and     pp_oper_proceso     is null
      and     hd_estado           = 'R'
      and     hd_reintegro        = 'S' 
      and     hd_fecha_reintegro  >= @i_fecha_ini 
      and     hd_fecha_reintegro  <= @i_fecha_fin
      group by pp_oficina_destino, 
              pp_tipo_benef
   end
   
   if @i_operacion ='Q'
   begin
      select  @o_valor            = @o_valor + isnull(sum(pp_monto),0),
              @o_cantidad         = @o_cantidad + isnull(count(1),0)
      from    sb_pagopostal_pend, cob_remesas_his..re_detpago_his
      where   pp_cod_operacion    = hd_cod_ope
      and     pp_oficina_destino  = @i_oficina
      and     pp_estado           = 'D'
      and     pp_cod_convenio     is not null
      and     pp_oper_proceso     is null
      and     pp_tipo_benef       = 'P' 
      and     hd_estado           = 'R'
      and     hd_reintegro        = 'S' 
      and     hd_fecha_reintegro  >= @i_fecha_ini 
      and     hd_fecha_reintegro  <= @i_fecha_fin
      group by pp_oficina_destino, 
              pp_tipo_benef
   end
   
   if @i_operacion ='R'
   begin
      select  @o_valor            = @o_valor + isnull(sum(pp_monto),0),
              @o_cantidad         = @o_cantidad + isnull(count(1),0)
      from    sb_pagopostal_pend, cob_remesas_his..re_detpago_his
      where   pp_cod_operacion    = hd_cod_ope
      and     pp_oficina_destino  = @i_oficina
      and     pp_estado           = 'D'
      and     pp_cod_convenio     is not null
      and     pp_oper_proceso     is null
      and     pp_tipo_benef       = 'O'
      and     hd_estado           = 'R'
      and     hd_reintegro        = 'S' 
      and     hd_fecha_reintegro  >= @i_fecha_ini 
      and     hd_fecha_reintegro  <= @i_fecha_fin
      group by pp_oficina_destino, 
              pp_tipo_benef
   end
   
   if @i_operacion ='S'
   begin
      select 'R', 
             pp_oficina_destino, 
             pp_tipo_benef, 
             count(1),   
             sum (pp_monto)
      from sb_pagopostal_pend, 
           cob_remesas_his..re_detpago_his
      where pp_cod_operacion   = hd_cod_ope
        and pp_estado          = 'D'
        and pp_cod_convenio    is not null
        and pp_oper_proceso    is null
        and hd_estado          = 'R'
        and hd_reintegro       = 'S' 
        and hd_fecha_reintegro = @i_fecha
      group by pp_oficina_destino, 
            pp_tipo_benef
   end     
   
   if @i_operacion ='T'
   begin  
      select
         Cuenta = pcc_cuenta,
         Banco  = (select ba_descripcion from cob_remesas..re_banco where ba_banco = x.pcc_banco),
         Sec    = pcc_secuencial
         from   sb_ctas_comercl x
         where  pcc_secuencial > @i_hd_secuencial
         and    (pcc_banco     = @i_bco    or @i_bco is null)
         and    (pcc_cuenta    = @i_cuenta or @i_cuenta is null)
         order  by pcc_secuencial

   end
   
   if @i_operacion ='U'
   begin  
      UPDATE cob_remesas_his..re_detpago_his
         SET hd_reintegro ='S',
             hd_estado    ='R'        
       WHERE hd_cod_ope   = isnull(@i_codigo, 0)
      
      if @@error <> 0
      begin
         select @w_error = @@error
         goto ERROR
      end
   end
   
   if @i_operacion ='V'
   begin  
      UPDATE cob_remesas_his..re_detpago_his
         SET hd_estado        = 'C',      
             hd_fecha_pago    = @s_date
        from sb_productos_neg_tmp 
       where pn_producto      = 7 
         and pn_cod_operacion = @i_codigo
         and pn_oficina       = @s_ofi 
         and hd_cod_ope       = pn_num_formato  -- codppp del giro original

      if @@error <> 0
      begin
         select @w_error = @@error
         goto ERROR
      end
   end
   
   if @i_operacion ='W'
   begin  
      select 
              Cuenta  = pcc_cuenta, 
              Banco   = (select ba_descripcion from cob_remesas..re_banco where ba_banco = x.pcc_banco), 
              Subtipo = pcc_subtipo,
              Sec     = pcc_secuencial
      from    sb_ctas_comercl x, sb_subtipos_ins
      where   pcc_subtipo        = si_cod_subtipo
      and     si_cod_instrumento = @i_cod_operacion
      and     si_estado          = 'A'
      and     (   (si_param_oficina = 'N')
       or     ( si_param_oficina = 'S' 
                 and si_cod_subtipo in
                  ( select so_cod_subtipo
                    from sb_subtipos_oficina
                    where so_oficina = @i_oficina
                  )
               )
              ) 
      and     pcc_secuencial > @i_hd_secuencial
      and    (pcc_banco      = @i_bco  or @i_bco is null)
      and    (pcc_cuenta     = @i_cuenta or @i_cuenta is null)
      order   by pcc_secuencial
   end
   
   if @i_operacion = 'X'
   begin   
      exec @w_return = cob_remesas..sp_verifica_caja
           @s_srv    = @s_srv,
           @s_ofi    = @s_ofi,
           @t_trn    = @t_trn,
           @s_user   = @s_user,
           @s_date   = @s_date,
           @i_filial = @i_filial,
           @i_ofi    = @s_ofi,
           @i_mon    = @i_moneda,
           @i_idcaja = @i_idcaja
         
      if @w_return <> 0
         return @w_return
   end
   
   if @i_operacion = 'Y'
   begin   
      exec @w_return       = cob_remesas..sp_upd_totales
           @i_ofi          = @s_ofi,
           @i_rol          = @s_rol,
           @i_user         = @s_user,
           @i_mon          = @i_moneda,
           @i_trn          = @t_trn,
           @i_nodo         = @s_srv,
           @i_tipo         = @i_tipo,
           @i_corr         = @t_corr,
           @i_efectivo     = @i_efectivo,
           @i_cheque       = @i_prop,
           @i_chq_locales  = @i_loc,
           @i_chq_ot_plaza = @i_cext,
           @i_ssn          = @s_ssn,
           @i_filial       = @i_filial,
           @i_idcaja       = @i_idcaja,
           @i_idcierre     = @i_idcierre,
           @i_saldo_caja   = @i_sld_caja,
           @i_causa        = @i_causa
      
      if @w_return <> 0
         return @w_return
   end

   if @i_operacion = 'Z'
   begin   
      exec @w_return   = cob_remesas..sp_resultados_branch_caja
           @i_sldcaja  = @i_sld_caja,
           @i_idcierre = @i_idcierre,
           @i_ssn_host = @s_ssn
   end
   
   if @i_operacion = 'AA'
   begin
      exec @w_return     = cob_remesas..sp_mant_fecha
           @i_fecha      = @i_fecha,
           @i_operacion  = @i_operacion_fecha,
           @i_numdias    = @i_numdias,
           @o_dia        = @o_dia        out,
           @o_fecha_proc = @o_fecha_proc out

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'AB'
   begin
      if OBJECT_ID(N'tempdb..#Equivalencias', N'U') is not null
      begin
         insert into #Equivalencias(
         eq_modulo,         eq_mod_int,       eq_tabla,
         eq_val_cfijo,      eq_val_num_ini,   eq_val_num_fin,
         eq_val_interfaz,   eq_descripcion)
         select 
         eq_modulo,         eq_mod_int,       eq_tabla,
         eq_val_cfijo,      eq_val_num_ini,   eq_val_num_fin,
         eq_val_interfaz,   eq_descripcion
         from cob_remesas..re_equivalencias
     end
   end
   
   if @i_operacion = 'AC'
   begin
      select @o_existe_caja = count(1)
      from   cob_remesas..re_caja
      where  cj_filial      = @i_filial
      and    cj_oficina     = @s_ofi
      and    cj_rol         = @s_rol
      and    cj_operador    = @s_user
      and    cj_moneda      = @i_moneda
      and    cj_transaccion = @i_transaccion
   end

   if @i_operacion = 'AD'
   begin
      UPDATE cob_remesas_his..re_detpago_his
         SET hd_reintegro       = 'S',
             hd_estado          = @i_estado,
             hd_fecha_reintegro = @i_fecha_proceso
       WHERE hd_cod_ope = @i_op_cod_operacion 
           
       if @@error <> 0
       begin 
           select @w_error = @@error
           goto ERROR    
       end
   end
   
   if @i_operacion = 'AE'
   begin
      update #re_banco_desc set
      iba_descripcion = ba_descripcion
      from cob_remesas..re_banco, #re_banco_desc
      where ba_banco = iba_banco
      
      if @@error <> 0
      begin 
          select @w_error = @@error
          goto ERROR    
      end
   end   
   
   if @i_operacion = 'AF'
   begin	
      select @o_cod_paquete = isnull(gp_prod_banc_pq, 0) 
        from cob_remesas..pa_integrantes_paquete, cob_remesas..pa_gestion_paquete
       where gp_numpq     = ip_numsol
         and ip_rol_ent   = @i_rol_ent
         and gp_estado_pq = @i_estado_pq
         and ip_cliente   = @i_cliente
         and gp_giro      = @i_giro
	
   end
end

return 0

ERROR:

   exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = @w_error
        
   return @w_error
go