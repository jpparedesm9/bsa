/************************************************************************/
/*	Archivo: 		reconchq.sp                             */
/*	Stored procedure: 	sp_rem_confcheque            		*/
/*	Base de datos:  	cob_remesas				*/
/*	Producto: 		Remesas 				*/
/*	Disenado por:  Sandra Ortiz/Julio Navarrete V.			*/
/*	Fecha de escritura: 21-Abr-1993					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa la transaccion de:                 	*/
/*      Confirmacion de Cheques de Otras Plazas individualmente.        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	21/Abr/1993	J Navarrete	Emision inicial			*/
/*      18/Mar/1996     D Villafuerte   Cajero Interno                  */
/*	25/May/1996	Juan F. Cadena	Optimizacion			*/
/*      24/Ene/2001     E.Pulido        Aumentar el campo ciudad a 4 dig*/ 
/*      21/Ene/2003     J. Loyo         Aumentar el campo Oficna a 4 dig*/ 
/*      26/Ago/2003     G. Rueda        Retornar c¢digos de error       */
/*      27/Jul/2004     O. Ligua        Cambio de vista para AHO       	*/
/*	20/Sep/2004 	O. Ligua	Validacion de chq. confir solo	*/
/*					si es modo normal		*/
/*	03/Nov/2004 	O. Ligua	Consultar tran. origen reverso	*/
/*					para enviar la misma en rev.	*/
/*      09/Nov/2004     O. Ligua        Tran. Servicio para Cuentas de	*/
/*					Orden - Remesas al Cobro	*/
/*      14/Ene/2004     J.Colorado      Reclasificacion de 15 dias      */
/************************************************************************/
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_rem_confcheque')
	drop proc sp_rem_confcheque

go
create proc sp_rem_confcheque (
    @s_ssn          int,
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user         varchar(30),
    @s_sesn         int=null,
    @s_term         varchar(10),
    @s_date         datetime,
    @s_ofi          smallint,   /* Localidad origen transaccion */
    @s_rol          smallint,
    @s_org_err      char(1) = null, /* Origen de error: [A], [S] */
    @s_error        int = null,
    @s_sev          tinyint = null,
    @s_msg          mensaje = null,
    @s_org          char(1),
    @t_corr         char(1) = 'N',
    @t_ssn_corr     int = null, /* Trans a ser reversada */
    @t_debug        char(1) = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(32) = null,
    @t_rty          char(1) = 'N',
    @t_trn          smallint,
    @p_lssn         int = null,
    @p_rssn         int = null,
    @p_rssn_corr    int = null,
    @p_envio        char(1) = 'N',
    @p_rpta         char(1) = 'N',
    @i_corres       char(12),
    @i_emisor       char(12),
    @i_propie       char(12),
    @i_fecha        smalldatetime,
    @i_secuen       int,
    @i_chq          int,
    @i_val          money,
    @i_hablt        char(1),
    @i_mon          tinyint,
    @i_tipo_rem     char(1)
)
as
declare @w_return       int,
    @w_sp_name          varchar(30),
    @w_mensaje          varchar(120),
    @w_cuenta           int,
    @w_ctadep           cuenta,
    @w_prddep           tinyint,
    @w_prd_abrv         char(3),
    @w_fecha_term       datetime,
    @w_fecha_hoy        datetime,
    @w_fecha_ing        datetime,
    @w_fecha_efe        datetime,
    @w_fecha_car        datetime,
    @w_fecha            smalldatetime,
    @w_oficina          smallint,
    @w_ofi_bco          smallint,
    @w_ciudad           int,
    @w_banco            smallint,
    @w_parroquia        int,
    @w_producto         tinyint,
    @w_nom_producto     descripcion,
    @w_interes          money,
    @w_rssn_corr        int,
    @w_server_rem       descripcion,
    @w_server_local     descripcion,
    @w_rpc              descripcion,
    @w_tipo             char(1),
    @w_num_cheques      tinyint,
    @w_carta            int,
    @w_valor            money,
    @w_bco_p            smallint,
    @w_ofi_p            smallint,
    @w_par_p            int,
    @w_bco_e            smallint,
    @w_ofi_e            smallint,
    @w_par_e            int,
    @w_bco_c            smallint,
    @w_ofi_c            smallint,
    @w_par_c            int,
    @w_oficina_p        smallint,
    @w_tipo_promedio    char(1),
    @w_oficial          smallint,
    @w_cheque_rec       int,
    @w_factor           int,
    @w_ciu_ofi          int,
    @w_oficina_cta      smallint,
    @w_status           char(1),
    @w_cajeroint        char(1),
    @w_cta_girada       varchar(15),
    @w_num_cheque       int,
    @w_codigo           smallint,
    @w_valorc           money,
    @w_numchqs          smallint,
    @w_dias_ret         tinyint,
    @w_cont             tinyint,
    @w_ref              int,
    @w_estado           varchar(15),
    @w_causa            tinyint,
    @w_estadito         char,
    @w_prod_banc        smallint,
    @w_categoria        catalogo,
    @w_estado_actual    char(1),
    @w_ct_num_cheques   int,
    @w_alterno          int,
    @w_codbco           tinyint
    
/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_rem_confcheque'

/* Chequeo de errores generados remotamente */
if @s_org_err is not null           /*  Error del Sistema  */
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = @s_error,
   @i_sev          = @s_sev,
   @i_msg          = @s_msg
   return 1
end

select @w_fecha = @i_fecha
select @w_fecha_hoy = @s_date

/* Valida datos */
if @i_chq = 0 or
   @i_val = 0 or @i_secuen = 0
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 351002
   return 1
end

--Codigo propio de compensacion
select @w_codbco = pa_tinyint
from   cobis..cl_parametro 
where  pa_nemonico = 'CBCO' 
and    pa_producto = 'CTE'

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 201196
   return 201196
end


/* Selecciona Datos del cheque a confirmar */
select @w_prddep     = cr_producto, 
       @w_cuenta     = cr_cta_depositada,
       @w_status     = cr_status,
       @w_cta_girada = cr_cta_girada,
       @w_num_cheque = cr_num_cheque
from cob_remesas..re_cheque_rec --(1)
where cr_cheque_rec = @i_chq

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 351055
   return 1
end
else
   select @w_prd_abrv = pd_abreviatura
   from cobis..cl_producto
   where pd_producto = @w_prddep


/* Separa codigo de banco del corresponsal en sus componentes */
   select @w_bco_c = convert(smallint, substring(@i_corres,1,4))
   select @w_ofi_c = convert(smallint, substring(@i_corres,5,4))
   select @w_par_c = convert(int, substring(@i_corres,9,4))

/* Separa codigo de banco del emisor en sus componentes */
   select @w_bco_e = convert(smallint, substring(@i_emisor,1,4))
   select @w_ofi_e = convert(smallint, substring(@i_emisor,5,4))
   select @w_par_e = convert(int, substring(@i_emisor,9,4))    

/* Separa codigo de banco del propietario en sus componentes */
   select @w_bco_p = convert(smallint, substring(@i_propie,1,4))
   select @w_ofi_p = convert(smallint, substring(@i_propie,5,4))
   select @w_par_p = convert(int, substring(@i_propie,9,4))  

/* Valida si la Carta es Interna o Via Bancos*/
if @w_bco_c = @w_codbco
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 351094
   return 1
end


/* Valida Transaccion de Cajero Interno y la existencia del Cheque */
if @w_cuenta = -1 and @w_prd_abrv = 'CTE'
begin
    select @w_oficina_cta = cd_oficina
    from  cob_cuentas..cc_chq_otrdept
    where cd_banco_chq = @w_bco_p
    and   cd_cta_chq   = @w_cta_girada
    and   cd_num_chq   = @w_num_cheque

    if @@rowcount <> 1
    begin
       exec cobis..sp_cerror
       @t_from         = @w_sp_name,
       @i_num          = 201188
       return 1
    end
    select @w_cajeroint    = 'S',
          @w_oficina_cta  = 11,
          @w_nom_producto = 'CUENTA CORRIENTE',
          @w_ctadep      = '9999999999'
end
else
   select @w_cajeroint = 'N'   

/* Selecciona la oficina de la cta y otros datos*/
if @w_cajeroint = 'N'
begin
   if @w_prd_abrv = 'CTE' 
      select @w_oficina_cta   = cc_oficina,
             @w_ctadep        = cc_cta_banco,
             @i_hablt         = 'C',     
             @w_nom_producto  = 'CUENTA CORRIENTE'
      from cob_cuentas..cc_ctacte
      where cc_ctacte = @w_cuenta
   else
      if @w_prd_abrv = 'AHO'
         select @w_oficina_cta  = ah_oficina,
                @w_ctadep       = ah_cta_banco,
                @i_hablt        = 'A',
                @w_nom_producto = 'CUENTA DE AHORROS'
         from cob_ahorros..ah_cuenta
         where ah_cuenta = @w_cuenta
      else 
         select @w_nom_producto = 'OTRAS CUENTAS'
      if @@rowcount <> 1
      begin
         exec  cobis..sp_cerror
         @t_from         = @t_from,
         @i_num          = 201004
         return 1
      end   
end

/*  Determinacion de condicion de local o remoto  */
if @w_cajeroint = 'N'
begin

                if @w_producto = 3
                   select @w_rpc = 'cob_cuentas..sp_cta_origen' 
                else
                   if @w_producto = 4
                      select @w_rpc = 'cob_ahorros..sp_cta_origen'

                --exec exec @w_return = cob_cuentas..sp_cta_origen  
    exec @w_return = @w_rpc
    @t_debug    = @t_debug,
    @t_file     = @t_file,
    @t_from     = @w_sp_name,
    @i_cta      = @w_ctadep, 
    @i_producto = @w_producto,
    @i_mon      = @i_mon, 
    @i_oficina  = @w_oficina,
    @o_tipo     = @w_tipo out, 
    @o_srv_local= @w_server_local out,
    @o_srv_rem  = @w_server_rem out
    if @w_return <> 0
       return @w_return
end
else
   select @w_tipo         = 'L',
          @w_server_local = @s_lsrv,
          @w_server_rem    = null


select @w_server_local = @s_lsrv

/*  Modo de correccion  */
if   @t_corr = 'N'
     select @w_factor = 1,
            @w_estado_actual = null
else select @w_factor = -1,
            @w_estado_actual = 'R'

/* Valido la existencia de la carta */
begin tran

select @w_num_cheques = ct_num_cheques,
       @w_valor = ct_valor,
       @w_fecha_ing = ct_fecha_emi
from cob_remesas..re_carta
where ct_banco_e   = @w_bco_e
and   ct_oficina_e = @w_ofi_e
and   ct_ciudad_e  = @w_par_e
and   ct_ciudad_p  = @w_par_p
and   ct_fecha_emi = @w_fecha
and   ct_moneda    = @i_mon
and   ct_carta     = @i_secuen
and   ct_banco_c   = @w_bco_c
and   ct_oficina_c = @w_ofi_c
and   ct_ciudad_c  = @w_par_c
if @@rowcount = 0
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 351003
   return 1
end

/* Actualiza el cheque de la carta */
if @w_factor = -1
begin
   if @i_hablt = 'C'
   begin
      if @i_tipo_rem = 'N'
      begin
         select @t_ssn_corr = ts_secuencial,
            @w_alterno  = isnull(ts_cod_alterno,0)
         from cob_cuentas..cc_tran_servicio
         where ts_estado is null
         and   ts_carta = @i_secuen
         and   ts_cheque = @i_chq
         and   ts_cta_banco_dep = @w_ctadep
         and   ts_moneda = @i_mon
         and   ts_saldo = @i_val
         and   ts_correccion = 'N'
         and   ts_usuario = @s_user
         and   ts_terminal = @s_term

         if @@rowcount <> 1
         begin
            /* Error en busqueda de registro */
            exec cobis..sp_cerror
            @t_from       = @w_sp_name,
            @i_num        = 208020
            return 1
         end
      end
      else
      begin
         select @t_ssn_corr = tm_secuencial,
               @w_alterno  = isnull(tm_cod_alterno,0)
         from  cob_cuentas..cc_tran_monet
         where tm_estado is null
         and   tm_tipo_tran = 48
         and   tm_causa = '36'
         and   tm_valor = @i_val
         and   tm_cta_banco = @w_ctadep
         and   tm_usuario = @s_user
         and   tm_terminal = @s_term
         and   tm_moneda = @i_mon
         and   tm_correccion = 'N'

         if @@rowcount <> 1
         begin
            /* Error en busqueda de registro */
            exec cobis..sp_cerror
            @t_from       = @w_sp_name,
            @i_num        = 208020
            return 1
         end
      end
   end
   else
   if @i_hablt = 'A'
   begin
      select 
      @t_ssn_corr = ts_secuencial,
      @w_alterno  = isnull(ts_cod_alterno,0)
      from  cob_ahorros..ah_tran_servicio
      where ts_estado        is null
      and   ts_carta         = @i_secuen
      and   ts_cheque        = @i_chq
      and   ts_cta_banco_dep = @w_ctadep
      and   ts_moneda        = @i_mon
      and   ts_valor         = @i_val
      and   ts_correccion    = 'N'
      and   ts_usuario       = @s_user
      and   ts_terminal      = @s_term

      if @@rowcount <> 1
      begin
         /* Error en busqueda de registro */
         exec cobis..sp_cerror
         @t_from       = @w_sp_name,
         @i_num        = 208020
         return 1
      end
   end
   
   /* Para calcular la fecha de Efectivizacion de la carta en los reversos*/
   select @w_bco_p   = dc_banco_p,
          @w_ofi_p   = dc_oficina_p,
          @w_par_p   = dc_ciudad_p
   from  cob_remesas..re_det_carta
   where dc_carta  = @i_secuen
   and   dc_cheque = @i_chq

   /* Encuentra la ciudad de la oficina */
   select @w_ciudad = of_ciudad
   from  cobis..cl_oficina
   where of_filial = 1
   and   of_oficina = @s_ofi

   /* Encuentra los dias de retencion dado el codigo de banco del cheque */
   select @w_dias_ret = tn_num_dias
   from   cob_remesas..re_transito
   where (tn_banco_p = @w_bco_p or tn_banco_p = 0)
   and    tn_oficina_p = @w_ofi_p
   and    tn_ciudad_p  = @w_par_p
   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 351001
      return 1
   end

   /* Encuentra la fecha de efectivizacion de la carta */
   select @w_fecha_efe = @w_fecha_ing,
          @w_cont      = 1

   while @w_cont <= (@w_dias_ret - 1)
   begin
      select @w_fecha_efe = dateadd(dd,1,@w_fecha_efe)

      if not exists (select df_fecha
                     from  cobis..cl_dias_feriados
                     where df_ciudad = @w_ciudad
                     and   df_fecha = @w_fecha_efe)

         select @w_cont = @w_cont + 1
   end
   
   update cob_remesas..re_cheque_rec set
   cr_status    = 'P',
   cr_fecha_efe = null
   where cr_cheque_rec = @i_chq

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 355000
      return 1
   end

   update cob_remesas..re_det_carta set
   dc_status    = 'P',
   dc_fecha_efe = null
   where dc_carta  = @i_secuen
   and   dc_cheque = @i_chq
   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 355000
      return 1
   end  

   if @w_cajeroint = 'S'
   begin
      update cob_cuentas..cc_chq_otrdept set
      cd_estado          = 'I',   
      cd_fecha_ope       = null
      where cd_banco_chq = @w_bco_p
      and   cd_cta_chq   = @w_cta_girada
      and   cd_num_chq   = @w_num_cheque
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 355019
         return 1
      end
   end        
end
else
begin
   if @w_status = 'P'
   begin
      update cob_remesas..re_cheque_rec set
      cr_status    = 'C',
      cr_fecha_efe = @w_fecha_hoy
      where cr_cheque_rec = @i_chq
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_from   = @w_sp_name,
         @i_num    = 355000
         return 1
      end
   
      update cob_remesas..re_det_carta
      set dc_status = 'C',
          dc_fecha_efe = @w_fecha_hoy  
      where dc_carta  = @i_secuen 
      and   dc_cheque = @i_chq
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 355000
         return 1
      end  

      if @w_cajeroint = 'S'
      begin
         update cob_cuentas..cc_chq_otrdept
         set cd_estado          = 'P',
             cd_fecha_ope       = @w_fecha_hoy
         where cd_banco_chq = @w_bco_p
         and   cd_cta_chq   = @w_cta_girada
         and   cd_num_chq   = @w_num_cheque
         if @@error <> 0
         begin
            exec cobis..sp_cerror
            @t_from         = @w_sp_name,
            @i_num          = 355019
            return 1
         end
      end                  
   end
   else
   begin
      if @w_status = 'D'
      begin
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 355018
         return 1    
      end
      if @w_status = 'C'
      begin
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 355017
         return 1
      end    
   end
end

/* Ubica la fecha de efectivizacion de la carta*/
if exists (select 1
           from   cob_remesas..re_det_carta 
           where  dc_carta    = @i_secuen
           and    dc_moneda   = @i_mon
           and    dc_status in ('P','B')
           and    dc_sub_estado is null)
   select @w_fecha_car = null
else  select @w_fecha_car = @s_date

/* Actualiza la carta del cheque */
select @w_ct_num_cheques = count(*)
from  cob_remesas..re_det_carta
where dc_banco_e   = @w_bco_e
and   dc_ciudad_e  = @w_par_e
and   dc_ciudad_p  = @w_par_p
and   dc_fecha_emi = @i_fecha
and   dc_moneda    = @i_mon
and   dc_carta     = @i_secuen
and   dc_status    in ('C', 'D','B')
and   dc_sub_estado is null

if @w_factor = 1
begin
   select @w_estadito = 'A'
   if @w_ct_num_cheques = @w_num_cheques
      select @w_estadito = 'C'
end
else
   select @w_estadito = 'A'

update cob_remesas..re_carta set
ct_fecha_efe = @w_fecha_car,
ct_estado    = @w_estadito
where ct_banco_e      = @w_bco_e
and   ct_oficina_e    = @w_ofi_e
and   ct_ciudad_e  = @w_par_e
and   ct_ciudad_p  = @w_par_p
and   ct_fecha_emi    = @i_fecha
and   ct_moneda       = @i_mon
and   ct_carta        = @i_secuen
and   ct_banco_c      = @w_bco_c
and   ct_oficina_c    = @w_ofi_c
and   ct_ciudad_c  = @w_par_c

/* Actualiza la cuenta depositada */
select @w_rpc = 'cob_remesas.sp_actualiza_cuenta'
if @w_tipo = 'L'
   select @w_rpc = 'cob_remesas..sp_actualiza_cuenta'
else
if @w_tipo = 'R'
   select @w_rpc = @w_server_local + '.' + @w_server_rem + '.' + @w_rpc

/*  Actualiza la cuentas */
if @s_org = 'U' and @w_cajeroint = 'N'
begin
   exec @w_return = @w_rpc
   @t_debug             = @t_debug,
   @t_from              = @w_sp_name,
   @t_file              = @t_file,
   @t_trn               = @t_trn,
   --@t_corr              = @t_corr,
   @t_ssn_corr          = @t_ssn_corr,
   --@s_date              = @s_date, 
   --@s_rol               = @s_rol,
   --@s_org               = @s_org,
   @s_ssn               = @s_ssn,
   --@s_ssn_branch        = @s_ssn,
   @s_user              = @s_user,
   @s_term              = @s_term,
   --@s_ofi               = @s_ofi,
   @i_cta               = @w_ctadep,
   @i_cuenta            = @w_cuenta,
   @i_fecha             = @s_date,
   @i_val               = @i_val,
   @i_prddep            = @w_prd_abrv,
   @i_mon               = @i_mon,
   @i_factor            = @w_factor,
   @i_ofi               = @s_ofi
   --@i_tipo_rem          = @i_tipo_rem,
   --@o_prod_banc         = @w_prod_banc out,
   --@o_categoria         = @w_categoria out
   if @w_return <> 0
       return @w_return
end

if @w_bco_c = @w_codbco
    select @w_causa = @w_codbco
else
    select @w_causa = 1

/* Registro de Transaccion de servicio */
if @i_hablt = 'C'
begin
   if @i_tipo_rem = 'N'
   begin
      insert into cob_cuentas..cc_tsrem_chequeconf
      (secuencial, tipo_tran,    oficina,
       usuario,    terminal,     correccion,
       ssn_corr,   reentry,      origen,
       nodo,       fecha,        cta_banco_dep,
       valor,      corresponsal, propietario, 
       nro_cheque, producto,     moneda, 
       carta,      oficina_cta,  causa_cont, 
       hora,       estado,       prod_banc,
       --categoria, 
       indicador, cta_banco)
      values 
      (@s_ssn,      @t_trn,            @s_ofi,
       @s_user,     @s_term,           @t_corr,
       @t_ssn_corr, @t_rty,            'L',
       @s_lsrv,     @s_date,           @w_ctadep,
       @i_val,      @i_corres,         @i_propie, 
       @i_chq,      @w_prddep,         @i_mon, 
       @i_secuen,   @w_oficina_cta,    @i_tipo_rem, 
       getdate(),   @w_estado_actual,  @w_prod_banc, 
       --@w_categoria,
       @w_causa,    @w_ctadep)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 353004
         return 1
      end
   end
   else
   begin
      insert into cob_cuentas..cc_tsrem_chequeconf
      (secuencial,      alterno,    tipo_tran,     oficina,
       usuario,         terminal,   correccion,    ssn_corr, 
       reentry,         origen,     nodo,          fecha, 
       cta_banco_dep,   valor,      corresponsal,  propietario, 
       nro_cheque, producto,   moneda,        carta,
       oficina_cta,     causa_cont, hora,          estado, 
       prod_banc,       indicador,  cta_banco--,     categoria
       )
      values 
      (@s_ssn, 20, 609,  @w_ofi_e,
       @s_user, @s_term, @t_corr,
       @t_ssn_corr, @t_rty, 'L',
       @s_lsrv, @s_date, @w_ctadep,
       @i_val, @i_corres, @i_propie, @i_chq, 
       @w_prddep, @i_mon, @i_secuen,@w_oficina_cta,
       @i_tipo_rem, getdate(),@w_estado_actual,@w_prod_banc, 
       @w_causa, @w_ctadep--, @w_categoria
       )
      if @@error <> 0
      begin
          exec cobis..sp_cerror
          @t_from         = @w_sp_name,
          @i_num          = 353004
          return 1
      end
   end
end
else
   if @i_hablt = 'A'
   begin
      insert into cob_ahorros..ah_tsrem_chequeconf
      (secuencial,   tipo_tran,    oficina,
       usuario,      terminal,     correccion,
       ssn_corr,     reentry,      origen,
       nodo,         fecha,        cta_banco_dep,
       valor,        corresponsal, propietario,      nro_cheque, 
       producto,     moneda,       carta,            oficina_cta,
       causa_contab, hora,         estado,           prod_banc, 
       categoria,    indicador)
      values 
      (@s_ssn,       @t_trn,       @s_ofi,
       @s_user,      @s_term,      @t_corr,
       @t_ssn_corr,  @t_rty,       'L',
       @s_lsrv,      @s_date,      @w_ctadep,
       @i_val,       @i_corres,    @i_propie,        @i_chq, 
       @w_prddep,    @i_mon,       @i_secuen,        @w_ofi_e,
      @i_tipo_rem,  getdate(),    @w_estado_actual,
       @w_prod_banc, @w_categoria, @w_causa)
      if @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_from         = @w_sp_name,
         @i_num          = 353005
         return 1
      end
   end

if @w_factor = -1
begin
   if @i_hablt = 'C'
   begin
      if @i_tipo_rem = 'N'
      begin
         --actualizar transaccion original
         update cob_cuentas..cc_tran_servicio
         set     ts_estado     = @w_estado_actual
         where   ts_secuencial = @t_ssn_corr
         and isnull(ts_cod_alterno, 0) = @w_alterno

         if @@rowcount <> 1 or @@error <> 0
         begin
            /* Error en actualizacion de registro */
            exec cobis..sp_cerror
            @t_from       = @w_sp_name,
            @i_num        = 205034
            return 1
         end
      end
      else
      begin
         --actualizar transaccion original
         update cob_cuentas..cc_tran_monet
         set   tm_estado     = @w_estado_actual
         where tm_secuencial = @t_ssn_corr
         and   isnull(tm_cod_alterno, 0) = @w_alterno

         if @@rowcount <> 1 or @@error <> 0
         begin
            /* Error en actualizacion de registro */
            exec cobis..sp_cerror
            @t_from       = @w_sp_name,
            @i_num        = 205034
            return 1
         end

         --actualizar transaccion original
         update cob_cuentas..cc_tran_servicio
         set     ts_estado     = @w_estado_actual
         where   ts_secuencial = @t_ssn_corr
         
         if @@rowcount <> 1 or @@error <> 0
         begin
            /* Error en actualizacion de registro */
            exec cobis..sp_cerror
            @t_from       = @w_sp_name,
            @i_num        = 205034
            return 1
         end
      end
   end
   else
      if @i_hablt = 'A'
      begin
         --actualizar transaccion original
         update cob_ahorros..ah_tran_servicio
         set     ts_estado     = @w_estado_actual
         where   ts_secuencial = @t_ssn_corr
         and isnull(ts_cod_alterno, 0) = 0
         if @@rowcount <> 1 or @@error <> 0
         begin
             /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_from       = @w_sp_name,
             @i_num        = 205034
             return 1
         end
      end
end /* Este es el fin de @i_factor = -1 */

/* Obtiene codigo de tabla para Tipos de Cheque Remesa */
select @w_codigo = codigo
from  cobis..cl_tabla
where tabla = 're_tcheque'

/* Devuelve Datos del Cheque Actualizado */
select @w_ref       = cr_cheque_rec,
       @w_estado    = substring(valor,1,15)
from cob_remesas..re_cheque_rec, --(1),
     cobis..cl_catalogo
where cr_cheque_rec = @i_chq
and   cr_status     = codigo
and   tabla         = @w_codigo

select @w_valorc  = ct_valor,
       @w_numchqs = ct_num_cheques
from cob_remesas..re_carta
where ct_carta = @i_secuen        

select @w_ref,
       @w_estado,
       @w_numchqs,
       @w_valorc     

commit tran
return 0
go

