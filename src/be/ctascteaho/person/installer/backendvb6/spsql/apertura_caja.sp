/****************************************************************************/
/*     Archivo:     apertura_caja.sp                                        */
/*     Stored procedure: sp_valor_contratado                                */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_apertura_caja')
  drop proc sp_apertura_caja
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

CREATE proc sp_apertura_caja (
    @s_ssn          int,
    @s_ssn_branch   int,
    @s_lsrv         varchar(30),
    @s_srv          varchar(30) = null,
    @s_user         varchar(30) = null,
    @s_sesn         int = null,
    @s_term         varchar(10),
    @s_date         datetime,
    @s_ofi          smallint = 1,   /* Localidad origen transaccion */
    @s_rol          smallint = 1,
    @s_org_err      char(1) = null, /* Origen de error: A, S */
    @s_error        int = null,
    @s_sev          tinyint = null,
    @s_msg          mensaje = null,
    @s_org          char(1),
    @t_ejec         char(1) = null,
    @t_debug        char(1) = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(32) = null,
    @t_corr         char(1) = 'N', 
    @t_trn          smallint, 
    @t_user         varchar(30) = null,
    @t_term         varchar(30) = null,
    @t_srv          varchar(30) = null,
    @t_ofi          smallint     = null,
    @t_rol          smallint     = null,
    @p_lssn         int     = null,
    @i_val          money,
    @i_mon          tinyint,
    @i_sld_caja     money = null,
    @i_idcierre     int = null,
    @i_idcaja       int = null,
    @i_filial       tinyint= 1,
    @i_pit          char(1) = 'N',
    @o_ssn          int = null out
)
as
declare @w_sp_name      varchar(30),
        @w_return       int,
        @w_oficina      smallint,
        @w_producto     tinyint,
        @w_siguiente    smallint,
        @w_numdeci      tinyint,
        @w_usadeci      char(1),
        @w_mensaje      mensaje

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_apertura_caja'
select  @o_ssn = @s_ssn

/*  Modo de debug  */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file = @t_file
    select  '/**  Stored Procedure  **/ ' = @w_sp_name,
        t_from      = @t_from,
        t_file      = @t_file, 
        t_trn       = @t_trn,
        i_val       = @i_val,
        i_mon       = @i_mon    
    exec cobis..sp_end_debug
end

-- Determinar si la transaccion es ejecutada por el REENTRY del SAIP

if @t_user is not null
  begin

    select @s_user = @t_user,
           @s_term = @t_term,
           @s_srv  = @t_srv,
           @s_ofi  = @t_ofi,
           @s_rol  = @t_rol
  end

/*  Valida codigo de Transaccion  */
if @t_trn <> 15
begin
    /*  Error en codigo de transaccion  */
        
    select @w_mensaje = 'ERROR EN CODIgo DE TRANSACCION'
    exec cobis..sp_cerror1
         @t_debug= @t_debug,
         @t_file = @t_file,
         @t_from = @t_from,
         @i_msg  = @w_mensaje,
         @i_num  = 201048,
         @i_pit  = @i_pit
        
    return 201048 /* GEB: Interface PIT */
end

/* NO SE PERMITE REVERSO DE APERTURA DE CAJA */
if @t_corr <> 'N'
begin
        select @w_mensaje = 'TRANSACCION NO PERMITE REALIZAR REVERSO'
        exec cobis..sp_cerror1
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_msg    = @w_mensaje,
            @i_num    = 201194,
            @i_pit    = @i_pit
    return 201194
end

/*  Captura de parametros de la oficina  */
exec @w_return = cobis..sp_parametros
    @t_debug    = @t_debug,
    @t_file     = @t_file,
    @t_from     = @w_sp_name,
    @s_lsrv     = @s_lsrv,
    @i_nom_producto = 'CUENTA CORRIENTE',
    @o_oficina  = @w_oficina    out,
    @o_producto = @w_producto   out

if @w_return <> 0
   return @w_return

/*  Verificacion de producto habilitado */
exec @w_return      = cobis..sp_verificar_producto
    @s_ssn      = @s_ssn,
    @s_srv      = @s_srv,
    @s_term     = @s_term,
    @s_ofi      = @s_ofi,
    @s_date     = @s_date,
    @s_user     = @s_user,
    @s_rol      = @s_rol,
    @t_trn      = 15807,
    @i_operacion    = 'V'

if @w_return <> 0
      return @w_return

/*  Verificacion de registro unico de operador por moneda  */

if exists (select  1 from  cob_remesas..re_caja
           where cj_filial  = @i_filial
           and  cj_oficina     = @s_ofi
           and  cj_rol         = @s_rol
           and  cj_operador    = @s_user
           and  cj_moneda      = @i_mon
           and  cj_transaccion = 15
           and  cj_id_caja     = @i_idcaja
           and  cj_fecha       = @s_date)
begin
    /*  Registro de caja ya ha sido abierto  */
    if @i_pit = 'N'
    begin
        select @w_mensaje = 'REGISTRO DE CAJA YA HA SIDO ABIERTO'
        exec cobis..sp_cerror1
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_msg    = @w_mensaje,
             @i_num    = 201020,
             @i_pit    = @i_pit
         
     return 201020 /* GEB: Interface PIT */
    end
end


/*  Creacion del registro de cajero y asignacion del  */
/*  efectivo inicial.                     */

begin tran

      /*Creacion de Registro de Cierre*/
      exec @w_return = cob_remesas..sp_cierre 
       @s_user          = @s_user,
       @s_date          = @s_date,
       @s_ofi           = @s_ofi,
       @t_trn           = 496,
       @i_mon           = @i_mon,
       @i_tipo          = 'T', 
       @i_idcaja        = @i_idcaja,
       @i_pit           = @i_pit,
       @i_sldini        = @i_sld_caja,
       @i_idcierre      = @i_idcierre,
       @i_filial        = @i_filial
      if @w_return <> 0
    return @w_return

      /* Actualizacion de Totales de cajero */
      exec @w_return = cob_remesas..sp_upd_totales
           @i_ofi            = @s_ofi,
           @i_rol            = @s_rol,
           @i_user           = @s_user,
           @i_mon            = @i_mon,
           @i_trn            = @t_trn,
           @i_nodo           = @s_srv,
           @i_tipo           = 'L',
           @i_corr           = @t_corr,
           @i_efectivo       = @i_val,
           @i_ssn            = @s_ssn,
           @i_idcaja         = @i_idcaja,
           @i_idcierre       = @i_idcierre,
           @i_filial         = @i_filial,
           @i_saldo_caja     = @i_sld_caja
      if @w_return <> 0
            return @w_return


      /* Encuentra parametro de decimales */
      select @w_usadeci = mo_decimales
        from cobis..cl_moneda
       where mo_moneda = @i_mon

      if @w_usadeci = 'S'
      begin
         select @w_numdeci = pa_tinyint
           from cobis..cl_parametro
          where pa_producto = 'CTE'
            and pa_nemonico = 'DCI'
         if @@rowcount <> 1
         begin
           
              exec cobis..sp_cerror1
                 @t_debug     = @t_debug,
                 @t_file      = @t_file,
                 @t_from      = @w_sp_name,
                 @i_num       = 201196,
                 @i_pit    = @i_pit
            
            return 201196 /* GEB: Interface PIT */
         end
      end
      else
         select @w_numdeci = 0

      select @i_val = round( @i_val, @w_numdeci)

    /*  Insercion de la transaccion servicio  */
    insert into cob_cuentas..cc_tsefectivo_caja (
            secuencial, ssn_branch, oficina, usuario,
            terminal, moneda, fecha, efectivo,
            nodo, tipo, tipo_tran, remoto_ssn,
            prod_banc, categoria)
        values (@s_ssn, @s_ssn_branch, @s_ofi, @s_user,
            @s_term, @i_mon, @s_date, @i_val,
            @s_srv, 'L', 15, @p_lssn,
            0, '0')
    if @@error <> 0
    begin
          
        exec cobis..sp_cerror1
            @t_debug= @t_debug,
            @t_file = @t_file,
            @t_from = @w_sp_name,
            @i_num  = 203000,
                        @i_pit    = @i_pit
             
        return 203000 /* GEB: Interface PIT */
    end

commit tran


/* Devolucion para branch */
if @t_ejec = "R"
   select "results_submit_rpc",
       r_ssn_host = @s_ssn,
       r_sldcaja  = @i_sld_caja,
       r_idcierre = @i_idcierre 
--select 'rssn' = @s_ssn

return 0


go


