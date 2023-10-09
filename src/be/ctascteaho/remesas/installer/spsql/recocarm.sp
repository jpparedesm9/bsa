/************************************************************************/
/*	Archivo: 		recocarm.sp                             */
/*	Stored procedure: 	sp_rem_confcarman            		*/
/*	Base de datos:  	cob_remesas				*/
/*	Producto: 		Remesas 				*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 15-Abr-1993					*/
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
/*      Confirmacion de Cartas de remesas Manualmente.                  */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	15/Abr/1993	J Navarrete	Emision inicial			*/
/*      18/Mar/1996     D Villafuerte   Cajero Interno                  */
/*      24/Ene/2001     E.Pulido        Aumentar los campos de ban.9 dig*/ 
/*      21/Ene/2003     J. Loyo         Aumentar el campo deOficna 4 dig*/ 
/*      26/Ago/2003     G. Rueda        Retornar codigos de error       */
/*      15/Jul/2004     O. Ligua        Correccion insercion vista AHO 	*/
/*      21/Jul/2004     O. Ligua        Cambio consulta causa contabilz	*/
/*      27/Jul/2004     O. Ligua        Correccion ins. trn. servicio	*/
/*      20/Sep/2004     O. Ligua        Aumento columnas en select dev.	*/
/*      09/Nov/2004     O. Ligua        Tran. Servicio para Cuentas de	*/
/*					Orden - Remesas al Cobro	*/
/*      14/Ene/2005     Julissa Colorado Reclasificacion de remesas 15  */
/************************************************************************/
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_rem_confcarman')
	drop proc sp_rem_confcarman

go
create proc sp_rem_confcarman (
    @s_ssn            int,
    @s_srv            varchar(30),
    @s_lsrv           varchar(30),
    @s_user         varchar(30),
    @s_sesn         int=null,
    @s_term        varchar(10),
    @s_date         datetime,
    @s_ofi             smallint,   /* Localidad origen transaccion */
    @s_rol             smallint,
    @s_org_err  char(1) = null, /* Origen de error: [A], [S] */
    @s_error        int = null,
    @s_sev           tinyint = null,
    @s_msg          mensaje = null,
    @s_org            char(1),
    @t_corr           char(1) = 'N',
    @t_ssn_corr int = null, /* Trans a ser reversada */
    @t_debug      char(1) = 'N',
    @t_file            varchar(14) = null,
    @t_from         varchar(32) = null,
    @t_rty             char(1) = 'N',
    @t_trn             smallint,
    @p_lssn          int = null,
    @p_rssn         int = null,
    @p_rssn_corr    int = null,
    @p_envio      char(1) = 'N',
    @p_rpta         char(1) = 'N',
    @i_corres       char(12),
    @i_propie      char(12),
    @i_fecha        smalldatetime,
    @i_secuen     int,
    @i_hablt         char(1),
    @i_mon          tinyint
)
as
declare @w_return   int,
    @w_sp_name      varchar(30),
    @w_mensaje      varchar(120),
    @w_cta          cuenta,
    @w_key          int,
    @w_alt          int,
    @w_filial       tinyint,
    @w_fecha_term   datetime,
    @w_fecha_hoy    datetime,
    @w_fecha        smalldatetime,
    @w_oficina      smallint,
    @w_ofi_bco      smallint,
    @w_banco        smallint,
    @w_parroquia    int,
    @w_producto     tinyint,
    @w_nom_producto descripcion,
    @w_interes      money,
    @w_rssn_corr    int,
    @w_server_rem   descripcion,
    @w_server_local descripcion,
    @w_rpc          descripcion,
    @w_tipo         char(1),
    @w_dias_rete    tinyint,
    @w_num_cheques  tinyint,
    @w_carta        int,
    @w_valor        money,
    @w_bco_p        smallint,
    @w_ofi_p        smallint,
    @w_par_p        int,
    @w_bco_c        smallint,
    @w_ofi_c        smallint,
    @w_par_c        int,
    @w_ofi_e        smallint,
    @w_filial_p     tinyint,
    @w_oficina_p    smallint,
    @w_tipo_promedio char(1),
    @w_oficial      smallint,
    @w_cheque_rec   int,
    @w_cheque       int,
    @w_endoso       int,
    @w_val          money,
    @w_contador     smallint,
    @w_cta_dep      int,
    @w_prddep       tinyint,
    @w_prd_abrv     char(3),
    @w_factor       int,
    @w_oficina_cta  smallint,
    @w_cajeroint    char(1),
    @w_cta_girada   varchar(15),
    @w_causa_cont   varchar(4),
    @w_num_cheque   int,
    @w_numchq       int,
    @w_codigo       smallint,
    @w_prod_banc    smallint,
    @w_categoria    catalogo,
    @w_tipo_rem     char(1),
    @w_causa        tinyint,
    @w_codbco       tinyint,
    @w_cliente      int,
    @w_clase_clte   char(1) 
    
/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_rem_confcarman'

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


/* Separa codigo de banco del corresponsal en sus componentes */
select @w_bco_c = convert(smallint, substring(@i_corres,1,4))

/* Valida si la Carta es Interna o Via Bancos*/
if @w_bco_c = @w_codbco
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 351094
   return 1
end

select @w_fecha = @i_fecha
select @w_fecha_hoy = @s_date

/* Valida datos */
if @i_secuen = 0
begin
     exec cobis..sp_cerror
     @t_from         = @w_sp_name,
     @i_num          = 351002
     return 1
end

begin tran

/* Datos de la Carta */
select 
@w_banco   = ct_banco_e,
@w_ofi_bco = ct_oficina_e,
@w_parroquia  = ct_ciudad_e,
@w_bco_p   = ct_banco_p,
@w_ofi_p   = ct_oficina_p,
@w_par_p   = ct_ciudad_p,
@w_fecha   = ct_fecha_emi,
@w_bco_c   = ct_banco_c,
@w_ofi_c   = ct_oficina_c,
@w_par_c   = ct_ciudad_c,
@w_valor   = ct_valor,
@w_num_cheques = ct_num_cheques
from  cob_remesas..re_carta --(2)
where ct_carta     = @i_secuen      
and   ct_fecha_emi = @i_fecha
and   ct_moneda    = @i_mon
and   ct_estado    = 'A'

if @@rowcount = 0
begin
   exec cobis..sp_cerror
   @t_from         = @w_sp_name,
   @i_num          = 351003
   return 1
end 

select @w_contador = 1,
       @w_alt = 0

if @w_num_cheques < 10
   select @w_numchq = @w_num_cheques
else
   select @w_numchq = 10 


while @w_contador <= @w_numchq 
begin
   set rowcount  1
   select @w_cheque     = dc_cheque,
          @w_tipo_rem   = dc_tipo_rem,
          @w_ofi_e      = dc_oficina_e,
          @w_cta_dep    = cr_cta_depositada,
          @w_prddep     = cr_producto,
          @w_val        = cr_valor,
          @w_endoso     = cr_endoso,
          @w_cta_girada = cr_cta_girada,
          @w_num_cheque = cr_num_cheque
   from  cob_remesas..re_det_carta, cob_remesas..re_cheque_rec
   where dc_banco_e   = @w_banco
   and ((dc_oficina_e = @w_ofi_bco and @w_bco_c = @w_codbco)
     or (dc_oficina_e > 0  and @w_bco_c <> @w_codbco))
   and   dc_ciudad_e  = @w_parroquia
   and   dc_fecha_emi = @w_fecha
   and   dc_moneda    = @i_mon
   and   dc_carta     = @i_secuen
   and   dc_cheque    = cr_cheque_rec
   and   dc_status    = cr_estado
   and   cr_estado    = 'P'
   if @@rowcount <> 1
   begin
     set rowcount 0
     break
   end
   
   set rowcount  0
   select @w_prd_abrv = pd_abreviatura 
   from  cobis..cl_producto
   where pd_producto = @w_prddep   
   
   /* Valida Transaccion de Cajero Interno y la existencia del Cheque */
   if @w_cta_dep = -1 and @w_prd_abrv = 'CTE'
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
             @i_hablt        = 'C',
             @w_cta          = '9999999999',
             @w_nom_producto = 'CUENTA CORRIENTE' 
   end
   else
      select @w_cajeroint    = 'N'
   
   /* Seleccion de la cuenta y la oficina */
   if @w_cajeroint = 'N'
   begin
      if @w_prd_abrv = 'CTE'
      begin
         select @i_hablt = 'C',
                @w_nom_producto = 'CUENTA CORRIENTE' 
         select @w_cta         = cc_cta_banco,
                @w_oficina_cta = cc_oficina,
                @w_cliente     = cc_cliente,
                @w_clase_clte  = cc_clase_clte
         from cob_cuentas..cc_ctacte
         where cc_ctacte = @w_cta_dep
      end
      else
      if @w_prd_abrv = 'AHO'
      begin
         select @i_hablt = 'A',
                @w_nom_producto = 'CUENTA DE AHORROS'
         select @w_cta         = ah_cta_banco,
                @w_oficina_cta = ah_oficina,
                @w_cliente     = ah_cliente,   
                @w_clase_clte  = ah_clase_clte
         from cob_ahorros..ah_cuenta
         where ah_cuenta = @w_cta_dep
      end                            
   end
   
   update cob_remesas..re_cheque_rec
   set   cr_status       = 'C',  -- cr_estado
         cr_fecha_efe    = @w_fecha_hoy
   where cr_cheque_rec = @w_cheque
   
   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 355000
      return 1
   end
   
   update cob_remesas..re_det_carta
   set dc_status       = 'C',
       dc_fecha_efe    = @w_fecha_hoy
   where dc_carta  = @i_secuen   
   and   dc_cheque = @w_cheque
   
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
      set   cd_estado      = 'P',
            cd_fecha_ope   = @w_fecha_hoy
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
   
   /*  Captura de parametros de la oficina  */
   exec @w_return = cobis..sp_parametros
   @t_debug        = @t_debug,
   @t_file         = @t_file,
   @t_from         = @w_sp_name,
   @s_lsrv         = @s_lsrv,
   @i_nom_producto = @w_nom_producto,
   @o_oficina      = @w_oficina out
   --@o_server_local = @w_server_local
   
   if @w_return <> 0
      return @w_return                     
   
   /*  Determinacion de condicion de local o remoto  */
   if @w_cajeroint = 'N'
   begin
   
                if @w_prddep = 3
                   select @w_rpc = 'cob_cuentas..sp_cta_origen' 
                else
                   if @w_prddep = 4
                      select @w_rpc = 'cob_ahorros..sp_cta_origen'
                                                                                              
                   --exec @w_return = cob_cuentas..sp_cta_origen
                  exec @w_return = @w_rpc   
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_cta          = @w_cta, 
      @i_producto     = @w_prddep,
      @i_mon          = @i_mon, 
      @i_oficina      = @w_oficina,
      @o_tipo         = @w_tipo out, 
      @o_srv_local    = @w_server_local out,
      @o_srv_rem      = @w_server_rem out
      if @w_return <> 0
         return @w_return
   end
   else
      select @w_tipo         = 'L',
             @w_server_local = @s_lsrv,
             @w_server_rem   = null
   
   select @w_server_local = @s_lsrv
       
   /*  Modo de correccion  */
   if   @t_corr = 'N'
        select @w_factor = 1
   else select @w_factor = -1
   
   if @w_factor = -1
   begin
      if @i_hablt = 'C'
      begin
         select @t_ssn_corr = ts_secuencial
         from  cob_cuentas..cc_tran_servicio
         where ts_tipo_transaccion = @t_trn
         and   ts_estado          is null
         and   ts_carta            = @i_secuen
         and   ts_cheque           = @w_cheque
         and   ts_cta_banco_dep    = @w_cta
         and   ts_moneda           = @i_mon
         and   ts_saldo            = @w_val
         and   ts_correccion       = 'N'
         and   ts_usuario          = @s_user
         and   ts_terminal         = @s_term
   
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
      if @i_hablt = 'A'
      begin
         select @t_ssn_corr = ts_secuencial
         from cob_ahorros..ah_tran_servicio
         where ts_tipo_transaccion = @t_trn
         and   ts_estado       is null
         and   ts_carta         = @i_secuen
         and   ts_cheque        = @w_cheque
         and   ts_cta_banco_dep = @w_cta
         and   ts_moneda        = @i_mon
         and   ts_saldo         = @w_val
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
   end

   /* Actualizo la cuenta depositada */
   select @w_rpc = 'cob_remesas.sp_actualiza_cuenta'
   if @w_tipo = 'L'
      select @w_rpc = 'cob_remesas..sp_actualiza_cuenta'
   else
   if @w_tipo = 'R'
      select @w_rpc = @w_server_local + '.' + @w_server_rem + '.' + @w_rpc
   
   /*  Actualiza la cuentas */
   if @s_org = 'U' and @w_cajeroint = 'N'
   begin
      select @w_alt = @w_alt + 1
      exec @w_return = @w_rpc
      @s_srv               = @s_srv,
      @s_ssn               = @s_ssn,
      @s_ssn_branch        = @s_ssn,
      @s_user              = @s_user,
      @s_term              = @s_term,
      @t_debug             = @t_debug,
      @t_from              = @w_sp_name,
      @t_file              = @t_file,
      @t_trn               = @t_trn,
      @t_corr              = @t_corr,
      @t_ssn_corr          = @t_ssn_corr,
      @i_cuenta            = @w_cta_dep,
      @i_fecha             = @s_date,
      @i_val               = @w_val,
      @i_prddep            = @w_prd_abrv,
      @i_factor            = @w_factor,
      @i_ofi               = @s_ofi,
      @i_alt               = @w_alt,
      @i_mon               = @i_mon,
      @i_tipo_rem          = @w_tipo_rem,
      @o_prod_banc         = @w_prod_banc out,
      @o_categoria         = @w_categoria out
      if @w_return <> 0
          return @w_return
   end
   
   select @w_alt = @w_alt + 1

   if @w_bco_c = @w_codbco
      select @w_causa = @w_codbco
   else
      select @w_causa = 1

   /* Actualiza transaccion de servicio */
   if @i_hablt = 'C' 
   begin
      if @w_tipo_rem = 'N'
      begin
         insert into cob_cuentas..cc_tsrem_chequeconf
                     (secuencial, alterno, tipo_tran, oficina,
                      usuario, terminal, correccion,
                      ssn_corr, reentry, origen,
                      nodo, fecha, cta_banco_dep,
                      valor, corresponsal, propietario, nro_cheque, 
                      producto, moneda, carta, endoso,oficina_cta,
                      causa_cont, hora, prod_banc, --categoria,
                      indicador, cta_banco)
             values (@s_ssn,@w_alt, @t_trn,  @s_ofi,
                     @s_user, @s_term, @t_corr,
                     @t_ssn_corr, @t_rty, 'L',
                     @s_lsrv, @s_date, @w_cta,
                     @w_val, @i_corres, @i_propie, @w_cheque, 
                     @w_prddep, @i_mon, @i_secuen, @w_endoso,@w_oficina_cta,
                     @w_tipo_rem, getdate(), @w_prod_banc, --@w_categoria,
                     @w_causa, @w_cta)

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
         select @w_alt = @w_alt + 1
         insert into cob_cuentas..cc_tsrem_chequeconf (
         secuencial,    alterno,     tipo_tran,    oficina,
         usuario,       terminal,    correccion,   ssn_corr, 
         reentry,       origen,      nodo,         fecha, 
         cta_banco_dep, valor,       corresponsal, propietario, 
         nro_cheque,    producto,    moneda,       carta, 
         endoso,        oficina_cta, causa_cont,   hora, 
         prod_banc,     indicador,   cta_banco)
         values (
         @s_ssn,        @w_alt,         609,         @w_ofi_bco,
         @s_user,       @s_term,        @t_corr,     @t_ssn_corr, 
         @t_rty,        'L',            @s_lsrv,     @s_date, 
         @w_cta,        @w_val,         @i_corres,   @i_propie, 
         @w_cheque,     @w_prddep,      @i_mon,      @i_secuen, 
         @w_endoso,     @w_oficina_cta, @w_tipo_rem, getdate(), 
         @w_prod_banc,  @w_causa,       @w_cta)

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
      insert into cob_ahorros..ah_tsrem_chequeconf(
      secuencial,    alterno,     tipo_tran,    oficina,
      usuario,       terminal,    correccion,   ssn_corr, 
      reentry,       origen,      nodo,         fecha, 
      cta_banco_dep, valor,       corresponsal, propietario, 
      nro_cheque,    producto,    moneda,       carta, 
      endoso,        oficina_cta, causa_contab, hora,
      prod_banc,     categoria,   cliente,      clase_clte )
      values (
      @s_ssn,       @w_alt,       @t_trn,        @s_ofi,
      @s_user,      @s_term,      @t_corr,       @t_ssn_corr, 
      @t_rty,       'L',          @s_lsrv,       @s_date, 
      @w_cta,       @w_val,       @i_corres,     @i_propie, 
      @w_cheque,    @w_prddep,    @i_mon,        @i_secuen, 
      @w_endoso,    @w_ofi_e,     @w_causa_cont, getdate(),
      @w_prod_banc, @w_categoria, @w_cliente,    @w_clase_clte )
      if @@error <> 0
      begin
          exec cobis..sp_cerror
          @t_from         = @w_sp_name,
          @i_num          = 353005
          return 1
      end
   end
   select @w_contador = @w_contador + 1
   continue
end

select @w_contador = @w_contador - 1
if @w_contador = @w_num_cheques
begin
   /* Actualiza estado de la carta */
   update cob_remesas..re_carta
   set ct_fecha_efe = @w_fecha_hoy,
       ct_estado = 'C'
   where ct_carta     = @i_secuen      
   and   ct_fecha_emi = @i_fecha
   and   ct_moneda    = @i_mon
   and   ct_estado    = 'A'
   
   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror
      @t_from         = @w_sp_name,
      @i_num          = 357000
      return 1
   end
end

/* Obtiene codigo de tabla para Tipos de Cheque Remesa */
select @w_codigo = codigo
from cobis..cl_tabla
where tabla = 're_tcheque'

/* Envio de Datos Actualizados */
select 'CTA GIRADA' = substring(dc_cta_girada,1,13),
       'CTA DEPOS'  = substring(dc_cta_depositada,1,13),
       'PRODUCTO'   = dc_producto,
       'CHEQUE'     = dc_num_cheque,
       'VALOR'      = dc_valor,
       'ESTADO'     = substring(valor,1,15),
       'No.REM'     = dc_cheque
from  cob_remesas..re_det_carta,
      cobis..cl_catalogo
where dc_carta  = @i_secuen
and   dc_moneda = @i_mon
and   dc_status = codigo  
and   tabla     = @w_codigo       

/* Envio de Datos de la carta */
select ct_num_cheques,ct_valor
from   cob_remesas..re_carta
where  ct_fecha_emi = @i_fecha
and    ct_carta     = @i_secuen
and    ct_moneda    = @i_mon

/* Control para confirmar toda la carta */
if @w_numchq < @w_num_cheques
   select -1
else
   select 0

commit tran
return 0
go