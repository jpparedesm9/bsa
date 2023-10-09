/************************************************************************/
/*      Archivo:                nvaperah.sp                             */
/*      Stored procedure:       sp_nav_apertura_ah                      */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Mauricio Bayas/Sandra Ortiz             */
/*      Fecha de escritura:     29-Nov-1993                             */
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
/*      Este programa realiza la transaccion de apertura de cuenta      */
/*      de ahorros de navidad.                                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*  03/Jul/2003                      Emision inicial BDF                */
/*  02/May/2016      Juan Tagle      Migración a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_nav_apertura_ah')
   drop proc sp_nav_apertura_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_nav_apertura_ah(
    @s_ssn                int, 
    @s_ssn_branch         int = null,
    @s_srv                varchar(30),
    @s_lsrv               varchar(30),
    @s_user               varchar(30),
    @s_sesn               int,
    @s_term               varchar(10),
    @s_date               datetime,
    @s_ofi                smallint,    /* Localidad origen transaccion */
    @s_rol                smallint = 1,
    @s_org_err            char(1) = null, /* Origen de error:[A], [S] */
    @s_error              int = null,
    @s_org            char(1) = 'U',
    @s_sev                tinyint = null,
    @s_msg                mensaje = null,
    @t_ejec           char(1) = 'R',
    @t_debug              char(1) = 'N',
    @t_file               varchar(14) = null,
    @t_from               varchar(32) = null,
    @t_rty                char(1) = 'N',
    @t_trn                smallint,
    @t_show_version       bit = 0,
    @i_ofl                smallint = null,
    @i_cli                int = null,
    @i_nombre             descripcion = null,
    @i_nombre1            descripcion = null,
    @i_cedruc1            char(13)= null,
    @i_cedruc             varchar(20) = null,
    @i_cli_ec             int = null,
    @i_direc              tinyint = null,
    @i_tprom              char(1) = null,  
    @i_categ              char(1) = null,  
    @i_mon                tinyint = null,
    @i_tdef               char(1) = null,
    @i_def                int = null,
    @i_rolcli             char(1) = 'T', 
    @i_rolente        char(1) = '1',
    @i_dprod              int = null,
    @i_ciclo              char(1) = null,
    @i_capit          char(1) = null,
    @i_pers           char(1) = 'N',   -- No personalizada
    @i_tipodir            char(1) = 'R',   -- Retener en agencia 
    @i_casillero          varchar(10) = null,
    @i_agencia            smallint = null,
    @i_prodbanc           smallint = null,  -- Producto bancario
    @i_origen             varchar(3) = '4', -- Por servicios
    @i_numlib             int = null,
    @i_valor              money  = null, 
    @i_cli1           int = 0,
    @i_dep_ini            int = 0,
    @i_promotor           smallint = 0,
    @i_direc_dv           tinyint = null,
    @i_tipodir_dv         char(1)  = 'R',   -- Retener en agencia 
    @i_casillero_dv       varchar(10) = null,
    @i_agencia_dv         smallint  = 0,
    @i_cli_dv             int = null,
    @i_turno          smallint = null,
    @i_cuota          char(10),
    @i_idcaja         int = 0,
    @i_idcierre       int = 0,
    @i_sld_caja       money = 0,
    @o_funcio         int = null out,
    @o_cta                cuenta = null out
)
as
declare @w_return   int,
    @w_sp_name      varchar(30),
    @w_cuenta       int,
    @w_cta_banco    varchar(20),
    @w_cliente      int,
    @w_cliente_ec   int,
    @w_actual       int,
    @w_filial       tinyint,
    @w_producto     tinyint,
    @w_tipo         char(1),
    @w_moneda       tinyint,
    @w_autorizante  smallint,
    @w_det_producto int,
    @w_comentario   descripcion,
    @o_cta_banco    cuenta, /* No out por problema DB LIBRARY */
    @o_det_producto int,
    @w_fecha_hoy    datetime,
    @w_cli          int,
    @w_nombre1      varchar(64),
    @w_oficina_cta  int,
    @w_cedruc       char(15),
    @w_ofl          int,
    @w_cuota        money


/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_nav_apertura_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_fecha_hoy = @s_date

/* Modo de debug */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select '/** Store Procedure **/ ' = @w_sp_name,
        s_ssn           = @s_ssn,
        s_srv           = @s_srv,
        s_lsrv          = @s_lsrv,
        s_user          = @s_user,
        s_sesn          = @s_sesn,
        s_term          = @s_term,
        s_date          = @s_date,
        s_ofi           = @s_ofi,
        s_rol           = @s_rol,
        s_org_err       = @s_org_err,
        s_error         = @s_error,
        s_sev           = @s_sev,
        s_msg           = @s_msg,
        t_debug         = @t_debug,
        t_file          = @t_file,
        t_from          = @t_from,
        t_rty           = @t_rty,
        t_trn           = @t_trn,
        i_ofl           = @i_ofl,
        i_cli           = @i_cli,
        i_nombre        = @i_nombre,
        i_cli1      = @i_cli1,
                i_nombre1       = @i_nombre1,
                i_cedruc1       = @i_cedruc1, 
        i_cedruc        = @i_cedruc,
        i_direc         = @i_direc,
        i_tprom         = @i_tprom,
        i_categ         = @i_categ,
        i_mon           = @i_mon,
        i_tdef          = @i_tdef,
        i_def           = @i_def,
        i_rolcli        = @i_rolcli,
        i_rolente   = @i_rolente,
        i_dprod         = @i_dprod,
        i_ciclo         = @i_ciclo,
        i_capit     = @i_capit,
                i_tipodir       = @i_tipodir,
                i_agencia       = @i_agencia,
                i_casillero     = @i_casillero

    exec cobis..sp_end_debug
end

/* Validacion del tipo de transaccion */

if @t_trn not in (338)
begin
  /* Error en codigo de transaccion */
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 201048
   return 201048
end

select @w_comentario = 'CUENTA DE NAVIDAD NO PUEDE EFECTUAR RETIROS',
       @w_cuota = convert(money,@i_cuota)

select @i_cli = pa_int
from cobis..cl_parametro
where pa_nemonico = 'CLINAV'
  and pa_producto = 'AHO'

if @@rowcount = 0
begin
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 201196
   return 201196
end

select @i_prodbanc = pa_smallint
from cobis..cl_parametro
where pa_nemonico  = 'PRDNAV'
  and pa_producto  = 'AHO'

if @@rowcount = 0
begin
   exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file      = @t_file,
       @t_from      = @w_sp_name,
       @i_num       = 351015
   return 351015
end

select @i_tprom = a.codigo
from cobis..cl_default a,
     cobis..cl_tabla   b
where a.tabla   = b.codigo
  and b.tabla   = 'ah_tpromedio' 
  and a.oficina = @s_ofi

if @@rowcount = 0
   select @i_tprom = 'M' --Mensual

select @i_ciclo = cp_ciclo
from cob_remesas..pe_ciclo_profinal,
     cob_remesas..pe_pro_final,
     cob_remesas..pe_mercado,
     cobis..cl_tabla a, 
     cobis..cl_catalogo b
where cp_profinal = pf_pro_final
  and pf_mercado = me_mercado
  and me_pro_bancario = @i_prodbanc
  and a.tabla = 'cc_ciclo'
  and a.codigo = b.tabla
  and b.codigo = cp_ciclo

if @@rowcount = 0
   select @i_ciclo = '3' -- 30 de cada mes

select @i_capit = cp_tipo_capitalizacion
from cob_remesas..pe_capitaliza_profinal,
     cob_remesas..pe_pro_final,
     cob_remesas..pe_mercado,
     cobis..cl_tabla a, 
     cobis..cl_catalogo b
where cp_profinal = pf_pro_final
  and pf_mercado = me_mercado
  and me_pro_bancario = @i_prodbanc
  and a.tabla = 'ah_capitalizacion'
  and a.codigo = b.tabla
  and b.codigo = cp_tipo_capitalizacion

if @@rowcount = 0
   select @i_capit = 'M' -- Mensual

select @i_categ = cp_categoria
from cob_remesas..pe_categoria_profinal,
     cob_remesas..pe_pro_final,
     cob_remesas..pe_mercado,
     cobis..cl_tabla a, 
     cobis..cl_catalogo b
where cp_profinal = pf_pro_final
  and pf_mercado = me_mercado
  and me_pro_bancario = @i_prodbanc
  and a.tabla = 'pe_categoria'
  and a.codigo = b.tabla
  and b.codigo = cp_categoria

if @@rowcount = 0
   select @i_categ = 'N' -- Normal

set rowcount 1
select @w_ofl = oc_oficial
from cobis..cc_oficial,
     cobis..cl_funcionario
where oc_funcionario = fu_funcionario
  and oc_oficial >= 1 
  and fu_oficina = @s_ofi

if @@rowcount = 0
begin
      set rowcount 0
      /* No existe oficial */
      exec cobis..sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 101036
      return 101036
end
set rowcount 0

select @w_nombre1 = en_nomlar,
       @w_cedruc  = en_ced_ruc
from cobis..cl_ente
where en_ente = @i_cli

begin tran

--Ejecuta el sp de apertura

exec @w_return = sp_apertura_ah 
     @s_ssn                = @s_ssn, 
     @s_ssn_branch         = @s_ssn_branch,
     @s_srv                = @s_srv,
     @s_lsrv               = @s_lsrv,
     @s_user               = @s_user,
     @s_sesn               = @s_sesn,
     @s_term               = @s_term,
     @s_date               = @s_date,
     @s_ofi                = @s_ofi, 
     @s_rol                = @s_rol,
     @t_trn                = 201,
     @i_ofl                = @w_ofl,     --Oficial de la cuenta
     @i_cli                = @i_cli,
     @i_nombre             = @i_nombre,  --Nombre del cliente que apertura la cta.
     @i_nombre1            = @w_nombre1, --Nombre del cliente generico para cta. nav.
     @i_cedruc1            = '',
     @i_cedruc             = @w_cedruc,
     @i_cli_ec             = null,
     @i_direc              = null,
     @i_tprom              = @i_tprom, -- Promedio
     @i_categ              = @i_categ, -- Categoria
     @i_mon                = @i_mon,
     @i_tdef               = 'D',
     @i_def                = 0,
     @i_rolcli             = @i_rolcli,  --'T',  -- Titular
     @i_rolente            = '1',
     @i_dprod              = null,
     @i_ciclo              = @i_ciclo,   -- Ciclo 
     @i_capit              = @i_capit,   -- Capitalizacion 
     @i_pers           = @i_pers,    --'N',  -- No Personalizada
     @i_tipodir            = @i_tipodir, --'R'   -- Retiene en el banco
     @i_casillero          = null,
     @i_agencia            = 1,
     @i_prodbanc           = @i_prodbanc, -- Producto bancario cta aho nav.
     @i_origen             = @i_origen,   --'4' -- Por servicios
     @i_numlib             = 0,
     @i_valor              = null, 
     @i_cli1           = @i_cli1,
     @i_dep_ini            = 0,
     @i_promotor           = 0,
     @i_direc_dv           = 0,
     @i_tipodir_dv         = @i_tipodir_dv, --'R' Retiene en el banco
     @i_casillero_dv       = null,
     @i_agencia_dv     = @s_ofi,
     @i_cli_dv             = null,
     @i_turno              = null,
     @i_cuota          = @w_cuota,
     @o_funcio             = @o_funcio out,
     @o_cta                = @o_cta out


if @w_return <> 0
begin
     rollback tran
     return @w_return
end

--Bloquea la cta contra deb.


exec @w_return = sp_bloqueo_mov_ah 
     @s_ssn                = @s_ssn,
     @s_ssn_branch         = @s_ssn_branch,
     @s_srv                = @s_srv,
     @s_user               = @s_user,
     @s_sesn               = @s_sesn,
     @s_term               = @s_term,
     @s_date               = @s_date,
     @s_ofi                = @s_ofi,
     @s_rol                = @s_rol,
     @s_org_err            = @s_org_err,
     @s_org        = @s_org,
     @s_error              = @s_error,
     @s_sev                = @s_sev,
     @s_msg                = @s_msg,
     @t_debug              = @t_debug,
     @t_file               = @t_file,
     @t_from               = @t_from,
     @t_trn        = 211,
     @i_cta        = @o_cta,
     @i_mon        = @i_mon,
     @i_tbloq              = '2',     --Bloqueo contra debitos
     @i_aut        = @s_user,
     @i_causa              = '7',     --Orden de BDF
     @i_solicit            = 'BDF',
     @o_oficina_cta    = @w_oficina_cta out,
     @i_observacion    = @w_comentario,
     @i_turno              = @i_turno

if @w_return <> 0
begin
     rollback tran
     return @w_return
end

if @t_ejec = 'R'
begin
     select 'results_submit_rpc', 
            r_cta = @o_cta

     exec cob_remesas..sp_resultados_branch_caja
      @i_sldcaja  = @i_sld_caja,
      @i_idcierre = @i_idcierre,
      @i_ssn_host = @s_ssn

end

commit tran

go

