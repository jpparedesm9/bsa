/************************************************************************/
/*  Archivo:                query_nom_ctahorro.sp                       */
/*  Stored procedure:       sp_query_nom_ctahorro                       */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Mauricio Bayas/Sandra Ortiz                 */
/*  Fecha de escritura:     24-Nov-1993                                 */
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
/*  Este programa realiza la transaccion de consulta del nombre         */
/*  de la cuenta de ahorros.                                            */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA           AUTOR           RAZON                               */
/*  24/Nov/1993     P. Mena         Emision inicial                     */
/*  30/Ago/1995     E. Guerrero     Envio numero de lib.(anulacion)     */
/*  15/Jun/2006     P Coello        Añadir parametro para validacion    */
/*                                  de inactividad                      */
/*  26/Jun/2006     P Coello        Devolver el codigo de la patente    */
/*  09/Mar/2007     C. Vargas       Validar las cuentas cerradas        */
/*  12/Mar/2007     P.Coello        Correcc - Validar las cuentas       */
/*                                  cerradas (Mod. Anterior)            */
/*  28/Dic/2009     C. Munoz        Req FRC-AHO-003 BPT                 */
/*  03/May/2011     S. Molano       Manejo para Cuentas Especiales      */
/*  21/Nov/2013     C. Avendaño     Agregar var @i_corresponsal Req 381 */
/*  29/OCT/2014     LIANA COTO      REQ465 - REACTIVACIÓN DE CUENTAS    */
/*                                  CON BIOMETRÍA                       */
/*  02/Mayo/2016    Juan Tagle      Migración a CEN                     */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_query_nom_ctahorro')
   drop proc sp_query_nom_ctahorro
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_query_nom_ctahorro (
@t_debug          char(1)       = 'N',
@t_file           varchar(14)   = null,
@t_from           varchar(32)   = null,
@t_show_version   bit           = 0,
@i_cta            cuenta,
@i_mon            tinyint,
@i_cerrada        char(1)       = 'A',
@i_libreta        char(1)       = null,
@i_cedruc         char(1)       = null,
@i_cliente        char(1)       = 'N',
@i_val_inac       char(1)       = 'S',  --PCOELLO PARA VALIDAR O NO LA INACTIVIDAD
/***************  FRC-AHO-003 ********************/
@i_operacion      char(1)       = 'Q',
@i_codcliente     int           = null,
@i_estado         char(1)       = 'A',
@i_ctaint         int           = 0,
/***************  FRC-AHO-003 ********************/
/***************  FRC-AHO-004********************/
@i_trn            varchar(10)   = null,
@s_ofi            smallint      = null,
/***************  REQ-381    ********************/
@i_corresponsal   char(1)       = 'N',
/***************  FRC-AHO-004********************/
@o_fecha_aper     smalldatetime = null out,
@o_titularidad    varchar(30)   = null out,
@o_nombre_cta     varchar(64)   = null out,
@o_patente_cta    varchar(40)   = null out,  --PCOELLO RECIBIR NUMERO DE LA PATENTE
@o_oficina        smallint      = null out,
@o_estado         char(1)       = null out

/* Ve Vss 19 NR208 */
)
as
declare
@w_return       int,
@w_sp_name      varchar(30),
@w_est          char(1),
@w_cuenta       int,
@w_nombre       descripcion,
@w_num_libreta  int,
@w_ced_ruc      numero,
@w_cliente      int,
@w_oficina      smallint,
/************** FRC-AHO-004********************/
@w_trn_ofior    char(1),
@w_codigo       int,
/************** FRC-AHO-004********************/
@w_error        int,
@w_traslado_dtn varchar(40),
@w_msg          varchar(40),
@w_occaho       smallint,
@w_des_alianza  varchar(255),
@w_alianza      int,
@w_prod_banc    int,
@w_tipo_per     char(1) --REQ465

/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_query_nom_ctahorro'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @w_prod_banc = C.codigo
from cobis..cl_tabla T, cobis..cl_catalogo C
where T.tabla = 're_pro_banc_cb'
and   T.codigo = C.tabla
and   C.estado = 'V'

/* Modo de debug */
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
    select '/** Store Procedure **/ ' = @w_sp_name,
    t_debug       = @t_debug,
    t_file        = @t_file,
    t_from        = @t_from,
    i_cta         = @i_cta,
    i_mon         = @i_mon,
    i_libreta     = @i_libreta,
    i_cedruc      = @i_cedruc,
    o_fecha_aper  = @o_fecha_aper,
    o_titularidad = @o_titularidad
    exec cobis..sp_end_debug
end

if @i_operacion = 'Q'
begin
   /* Variables de Trabajo */
   --REQ 381 - Si no es corresponsal no debe presentar las cuentas de corresponsales
   if @i_corresponsal = 'N'
   begin
      select
      @w_cuenta      = ah_cuenta,
      @w_est         = ah_estado,
      @w_nombre      = isnull((select of_nombre from  cobis..cl_oficina,
                               cob_remesas..re_mantenimiento_cb
                               where mc_cod_cb    = of_oficina
                               and   mc_cta_banco = ah_cta_banco),ah_nombre),
      @w_num_libreta = ah_numlib,
      @w_ced_ruc     = ah_ced_ruc,
      @w_cliente     = ah_cliente,
      @w_oficina     = ah_oficina,
      @o_nombre_cta  = isnull((select of_nombre from  cobis..cl_oficina,
                               cob_remesas..re_mantenimiento_cb
                               where mc_cod_cb    = of_oficina
                               and   mc_cta_banco = ah_cta_banco),ah_nombre),
      @o_fecha_aper  = ah_fecha_aper,
      @o_titularidad = (select Y.valor
                        from cobis..cl_tabla X,cobis..cl_catalogo Y
                        where X.tabla = 're_titularidad'
                        and   X.codigo = Y.tabla
                        and   Y.codigo = A.ah_ctitularidad),
      @o_patente_cta = ah_patente,  --pcoello ENVIAR NUMERO DE PATENTE
      @o_oficina     = ah_oficina,
      @o_estado      = ah_estado
      from  cob_ahorros..ah_cuenta A
      where ah_cta_banco = @i_cta
      and   ah_moneda    = @i_mon
      and   ah_prod_banc <> @w_prod_banc

      if @@rowcount = 0
      begin
         /* No existe cuenta_banco */
         exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num       = 251001,
         @i_sev       = 0,
         @i_msg       = 'No existe cuenta de ahorros'
         return 251001
      end
   end
   else
   begin
      select
      @w_cuenta      = ah_cuenta,
      @w_est         = ah_estado,
      @w_nombre      = isnull((select of_nombre from  cobis..cl_oficina,
                               cob_remesas..re_mantenimiento_cb
                               where mc_cod_cb    = of_oficina
                               and   mc_cta_banco = ah_cta_banco),ah_nombre),
      @w_num_libreta = ah_numlib,
      @w_ced_ruc     = ah_ced_ruc,
      @w_cliente     = ah_cliente,
      @w_oficina     = ah_oficina,
      @o_nombre_cta  = isnull((select of_nombre from  cobis..cl_oficina,
                               cob_remesas..re_mantenimiento_cb
                               where mc_cod_cb    = of_oficina
                               and   mc_cta_banco = ah_cta_banco),ah_nombre),
      @o_fecha_aper  = ah_fecha_aper,
      @o_titularidad = (select Y.valor
                        from cobis..cl_tabla X,cobis..cl_catalogo Y
                        where X.tabla = 're_titularidad'
                        and   X.codigo = Y.tabla
                        and   Y.codigo = A.ah_ctitularidad),
      @o_patente_cta = ah_patente,  --pcoello ENVIAR NUMERO DE PATENTE
      @o_oficina     = ah_oficina,
      @o_estado      = ah_estado
      from  cob_ahorros..ah_cuenta A
      where ah_cta_banco = @i_cta
      and   ah_moneda    = @i_mon
      and   ah_prod_banc = @w_prod_banc

      if @@rowcount = 0
      begin
         /* No existe cuenta_banco */
         exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file      = @t_file,
         @t_from      = @w_sp_name,
         @i_num       = 2609858,
         @i_sev       = 0,
         @i_msg       = 'CUENTA DE AHORROS NO EXISTE O NO PERTENECE AL PRODUCTO CORRESPONSALES BANCARIOS REDES POSICIONADAS'
         return 2609858
      end
   end

   /*Validaciones */
   /******PCOELLO CORRRECCION DE LA VALIDACION DEL TEMA ARRIBA COMENTADO *******/
   if @i_cerrada <> 'C'
   begin
      if @w_est <> 'A' and @w_est <> 'G'
         if  @w_est <>'C' and  @w_est <> 'P'
         begin
            if @i_val_inac = 'S'
            begin
               /* Cuenta Inmovil */
               exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 201134
               return 201134
             end
         end
         else
         begin
            /* Cuenta no activa o cancelada */
            exec cobis..sp_cerror
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_num       = 251002
            return 251002
         end
   end

   /* Mensaje para cuando la Cuenta se encuentre trasladada a la DTN */
   Select @w_traslado_dtn  = case when tn_estado = 'P' then 'CUENTA TRASLADADA A LA DTN' else '' end
     from cob_remesas..re_tesoro_nacional
    where tn_cuenta = @i_cta

   select  @w_alianza = al_alianza,
           @w_des_alianza = isnull((al_nemonico + ' - ' + al_nom_alianza), '  ')
   from cobis..cl_alianza_cliente with (nolock),
        cobis..cl_alianza         with (nolock)
   where ac_ente    = @i_codcliente
     and ac_alianza = al_alianza
     and al_estado  = 'V'
     and ac_estado  = 'V'

   novalida:
   /* Envio del nombre de la cuenta al Front End via select */
   select @w_nombre,
          @w_oficina,
          @w_traslado_dtn,
          @o_titularidad,
          @o_oficina,
          @o_estado,
          @w_alianza,
          @w_des_alianza

   /*  Envio en numero de libreta  para la forma de anulacion FTRAN280  EGA*/
   if @i_libreta = '1'
      select @w_num_libreta
   /*  Envio en numero de libreta  para la forma de anulacion FTRAN280  ADRY*/
   if @i_cedruc = '1'
      select @w_ced_ruc
   if @i_cliente = 'S'
      select @w_cliente
end --operacion Q

if @i_operacion = 'S'
begin
   if @i_codcliente is null and @i_cta is null
   begin
      print 'No se envio el cliente o la cuenta'
      return 1
   end
   if @i_cta is not null
   begin
        if @i_corresponsal = 'N'
        begin
           if not exists( select 1 from cob_ahorros..ah_cuenta
                         where ah_cta_banco = @i_cta
                         and   ah_prod_banc <> @w_prod_banc)
           begin
               /* No existe cuenta_banco */
               exec cobis..sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 251001,
               @i_sev       = 0,
               @i_msg       = 'No existe cuenta de ahorros'
               return 251001
           end
        end
        else
        begin
           if not exists( select 1 from cob_ahorros..ah_cuenta
                         where ah_cta_banco = @i_cta
                         and   ah_prod_banc = @w_prod_banc)
           begin
               /* No existe cuenta_banco */
               exec cobis..sp_cerror
                    @t_debug     = @t_debug,
                    @t_file      = @t_file,
                    @t_from      = @w_sp_name,
                    @i_num       = 2609858,
                    @i_sev       = 0,
                    @i_msg       = 'CUENTA DE AHORROS NO EXISTE O NO PERTENECE AL PRODUCTO CORRESPONSALES BANCARIOS REDES POSICIONADAS'
                    return 2609858
            end
        end
   end

  /*************** FRC-AHO-004********************/
  --REQ465 OCTUBRE/2014
  select @w_tipo_per = ah_tipocta from cob_ahorros..ah_cuenta where (ah_cta_banco = @i_cta or ah_cliente = @i_codcliente)

   if @w_tipo_per = 'P'
   begin
      select @w_trn_ofior = 'N'
   end
   else
   begin
       select @w_codigo = codigo from cobis..cl_tabla
       where  tabla = 're_trn_ofiorig'

       select @w_occaho = pa_smallint
       from   cobis..cl_parametro
       where  pa_nemonico = 'OCCAH'
       and    pa_producto = 'AHO'

       if @w_occaho is null
          select @w_occaho = 1

       if exists(select 1 from cobis..cl_catalogo
                where tabla = @w_codigo
                and codigo  = @i_trn) or @s_ofi = @w_occaho
       begin
          select  @w_trn_ofior='S'
       end
       else
          select @w_trn_ofior = 'N'
   end

   /*************** FRC-AHO-004********************/
   -- set rowcount 20
   /*** Inicio: Crear la tala temporal ****/
   select
            NoCuenta    = ah_cta_banco,
            Producto    = ah_prod_banc,
            NomProducto = (select substring(pb_descripcion,1,30) from cob_remesas..pe_pro_bancario where pb_pro_bancario = a.ah_prod_banc),
            Oficina     = ah_oficina,
            NomOficina  = (select substring(of_nombre,1,20) from cobis..cl_oficina where of_oficina  = a.ah_oficina),
            Cliente     = en_ente, --ah_cliente,
            TipoDoc     = en_tipo_ced,
            NoDoc       = en_ced_ruc,
            Nombre      = en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
            Rol         = cl_rol,
            EstadoCta   = ah_estado,
            CuentaInt   = ah_cuenta,
            Oficinaori  = ah_oficina,
            Tipo        = ah_estado,
            Categoria   = ah_categoria,
            Tipo_Ente   = ah_tipocta
   into  #tmp_cuentas
   from   cobis..cl_det_producto,
          cobis..cl_cliente,
          cobis..cl_ente,
          cob_ahorros..ah_cuenta a
   where  1 = 2
   /*** Fin: Crear la tala temporal ****/
   if @i_codcliente is not null   and  @i_cta is not null
   begin /** Busqueda por cliente y cuenta ***/
      --REQ 381 - Si no es corresponsal no debe presentar las cuentas de corresponsales
      if @i_corresponsal = 'N'
      begin
         insert into #tmp_cuentas
                 (NoCuenta,     Producto,       NomProducto,
                  Oficina,      NomOficina,
                  Cliente,      TipoDoc,        NoDoc,        Nombre,
                  Rol,          EstadoCta,      CuentaInt,    Oficinaori, Tipo,
                  Categoria,    Tipo_Ente )
         select  top(20)
                 ah_cta_banco,  ah_prod_banc,   (select substring(pb_descripcion,1,30) from cob_remesas..pe_pro_bancario where pb_pro_bancario = a.ah_prod_banc),
                 ah_oficina,    (select substring(of_nombre,1,20) from cobis..cl_oficina where of_oficina  = a.ah_oficina),
                 en_ente,       en_tipo_ced,    en_ced_ruc,   en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
                 cl_rol,        ah_estado,      ah_cuenta,    ah_oficina,   ah_estado,
                 ah_categoria,  ah_tipocta
          from  cobis..cl_det_producto,
                cobis..cl_cliente,
                cobis..cl_ente,
                cob_ahorros..ah_cuenta a
          where cl_det_producto = dp_det_producto
          and   dp_cuenta       = ah_cta_banco
          and   cl_cliente      = en_ente
          and   ah_prod_banc    <> @w_prod_banc
          and   dp_producto     = 4 -- AHORROS
          and   cl_cliente      = @i_codcliente
          and   dp_cuenta       = @i_cta
          and   (ah_estado      = @i_estado or (ah_estado in ('C','G') and @i_estado <> 'I'))
          and   ah_cuenta       > @i_ctaint
          order by ah_cuenta
      end
      else
      begin
         insert into #tmp_cuentas
                 (NoCuenta,     Producto,       NomProducto,
                  Oficina,      NomOficina,
                  Cliente,      TipoDoc,        NoDoc,        Nombre,
                  Rol,          EstadoCta,      CuentaInt,    Oficinaori, Tipo,
                  Categoria,    Tipo_Ente )
         select  top(20)
                 ah_cta_banco,  ah_prod_banc,   (select substring(pb_descripcion,1,30) from cob_remesas..pe_pro_bancario where pb_pro_bancario = a.ah_prod_banc),
                 ah_oficina,    (select substring(of_nombre,1,20) from cobis..cl_oficina where of_oficina  = a.ah_oficina),
                 en_ente,       en_tipo_ced,    en_ced_ruc,   en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
                 cl_rol,        ah_estado,      ah_cuenta,    ah_oficina,   ah_estado,
                 ah_categoria,  ah_tipocta
          from  cobis..cl_det_producto,
                cobis..cl_cliente,
                cobis..cl_ente,
                cob_ahorros..ah_cuenta a
          where cl_det_producto = dp_det_producto
          and   dp_cuenta       = ah_cta_banco
          and   cl_cliente      = en_ente
          and   ah_prod_banc    = @w_prod_banc
          and   dp_producto     = 4 -- AHORROS
          and   cl_cliente      = @i_codcliente
          and   dp_cuenta       = @i_cta
          and   (ah_estado      = @i_estado or (ah_estado in ('C','G') and @i_estado <> 'I'))
          and   ah_cuenta       > @i_ctaint
          order by ah_cuenta
      end
   end /*** Fin del if valores para cliente y cuenta ***/
   else
   begin
       if @i_codcliente is not null
       begin     /*** Solo viene el codigo del cliente ***/
          --REQ 381 - Si no es corresponsal no debe presentar las cuentas de corresponsales
         if @i_corresponsal = 'N'
         begin
              insert into #tmp_cuentas
                      (NoCuenta,     Producto,       NomProducto,
                       Oficina,      NomOficina,
                       Cliente,      TipoDoc,        NoDoc,        Nombre,
                       Rol,          EstadoCta,      CuentaInt,    Oficinaori, Tipo,
                       Categoria,    Tipo_Ente)
               select  top(20)
                       ah_cta_banco,  ah_prod_banc,   (select substring(pb_descripcion,1,30) from cob_remesas..pe_pro_bancario where pb_pro_bancario = a.ah_prod_banc),
                       ah_oficina,    (select substring(of_nombre,1,20) from cobis..cl_oficina where of_oficina  = a.ah_oficina),
                       en_ente,       en_tipo_ced,    en_ced_ruc,   en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
                       cl_rol,        ah_estado,      ah_cuenta,    ah_oficina,   ah_estado ,
                       ah_categoria,  ah_tipocta
              from   cobis..cl_det_producto,
                     cobis..cl_cliente,
                     cobis..cl_ente,
                     cob_ahorros..ah_cuenta a
              where  cl_det_producto = dp_det_producto
              and    dp_cuenta       = ah_cta_banco
              and    cl_cliente      = en_ente
              and    ah_prod_banc    <> @w_prod_banc
              and    dp_producto     = 4 -- AHORROS
              and    cl_cliente      = @i_codcliente
              and    (ah_estado      = @i_estado or (ah_estado in ('C','G') and @i_estado <> 'I'))
              and    ah_cuenta       > @i_ctaint
              order by ah_cuenta
         end
         else
         begin
            insert into #tmp_cuentas
                      (NoCuenta,     Producto,       NomProducto,
                       Oficina,      NomOficina,
                       Cliente,      TipoDoc,        NoDoc,        Nombre,
                       Rol,          EstadoCta,      CuentaInt,    Oficinaori, Tipo,
                       Categoria,    Tipo_Ente)
               select  top(20)
                       ah_cta_banco,  ah_prod_banc,   (select substring(pb_descripcion,1,30) from cob_remesas..pe_pro_bancario where pb_pro_bancario = a.ah_prod_banc),
                       ah_oficina,    (select substring(of_nombre,1,20) from cobis..cl_oficina where of_oficina  = a.ah_oficina),
                       en_ente,       en_tipo_ced,    en_ced_ruc,   en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
                       cl_rol,        ah_estado,      ah_cuenta,    ah_oficina,   ah_estado ,
                       ah_categoria,  ah_tipocta
              from   cobis..cl_det_producto,
                     cobis..cl_cliente,
                     cobis..cl_ente,
                     cob_ahorros..ah_cuenta a
              where  cl_det_producto = dp_det_producto
              and    dp_cuenta       = ah_cta_banco
              and    cl_cliente      = en_ente
              and   ah_prod_banc     = @w_prod_banc
              and    dp_producto     = 4 -- AHORROS
              and    cl_cliente      = @i_codcliente
              and    (ah_estado      = @i_estado or (ah_estado in ('C','G') and @i_estado <> 'I'))
              and    ah_cuenta       > @i_ctaint
              order by ah_cuenta
         end
       end /*** Fin del if Solo valor del cliente ***/
       else
       begin
          if @i_cta is not null
          begin /** Solo viene el codigo de  la cuenta ***/
             --REQ 381 - Si no es corresponsal no debe presentar las cuentas de corresponsales
             if @i_corresponsal = 'N'
             begin
                insert into #tmp_cuentas
                        (NoCuenta,     Producto,       NomProducto,
                         Oficina,      NomOficina,
                         Cliente,      TipoDoc,        NoDoc,        Nombre,
                         Rol,          EstadoCta,      CuentaInt,    Oficinaori, Tipo,
                         Categoria,    Tipo_Ente )
                select  top(20)
                        ah_cta_banco,  ah_prod_banc,   (select substring(pb_descripcion,1,30) from cob_remesas..pe_pro_bancario where pb_pro_bancario = a.ah_prod_banc),
                        ah_oficina,    (select substring(of_nombre,1,20) from cobis..cl_oficina where of_oficina  = a.ah_oficina),
                        en_ente,       en_tipo_ced,    en_ced_ruc,   en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
                        cl_rol,        ah_estado,      ah_cuenta,    ah_oficina,   ah_estado,
                        ah_categoria,  ah_tipocta
                from  cobis..cl_det_producto,
                      cobis..cl_cliente,
                      cobis..cl_ente,
                      cob_ahorros..ah_cuenta a
                where cl_det_producto = dp_det_producto
                and   dp_cuenta       = ah_cta_banco
                and   cl_cliente      = en_ente
                and   ah_prod_banc    <> @w_prod_banc
                and   dp_producto     = 4 -- AHORROS
                and   dp_cuenta       = @i_cta
                and    (ah_estado     = @i_estado or (ah_estado in ('C','G') and @i_estado <> 'I'))
                and    ah_cuenta      > @i_ctaint
                order by ah_cuenta
             end
             else
             begin
                insert into #tmp_cuentas
                        (NoCuenta,     Producto,       NomProducto,
                         Oficina,      NomOficina,
                         Cliente,      TipoDoc,        NoDoc,        Nombre,
                         Rol,          EstadoCta,      CuentaInt,    Oficinaori, Tipo,
                         Categoria,    Tipo_Ente )
                select  top(20)
                        ah_cta_banco,  ah_prod_banc,   (select substring(pb_descripcion,1,30) from cob_remesas..pe_pro_bancario where pb_pro_bancario = a.ah_prod_banc),
                        ah_oficina,    (select substring(of_nombre,1,20) from cobis..cl_oficina where of_oficina  = a.ah_oficina),
                        en_ente,       en_tipo_ced,    en_ced_ruc,   en_nombre + ' ' + p_p_apellido + ' ' + p_s_apellido,
                        cl_rol,        ah_estado,      ah_cuenta,    ah_oficina,   ah_estado,
                        ah_categoria,  ah_tipocta
                from  cobis..cl_det_producto,
                      cobis..cl_cliente,
                      cobis..cl_ente,
                      cob_ahorros..ah_cuenta a
                where cl_det_producto = dp_det_producto
                and   dp_cuenta       = ah_cta_banco
                and   cl_cliente      = en_ente
                and   ah_prod_banc    = @w_prod_banc
                and   dp_producto     = 4 -- AHORROS
                and   dp_cuenta       = @i_cta
                and    (ah_estado     = @i_estado or (ah_estado in ('C','G') and @i_estado <> 'I'))
                and    ah_cuenta      > @i_ctaint
                order by ah_cuenta
             end
          end /*** Fin del If Solo valor de cuenta ***/
       end
   end

   if @@rowcount = 0
   begin
      select @w_error = 251094 -- 208158 --NO EXISTEN REGISTROS

      if @i_estado = 'N' and @i_cta is not null
         select @w_error = 251102

      if @i_estado <> 'I' and @i_cta is not null
      begin
         select @w_error = 251058 -- 101128 --Cuenta no esta vigente

         select @i_estado = ah_estado
         from cob_ahorros..ah_cuenta
         where ah_cta_banco = @i_cta

         if @i_estado = 'N'
            select @w_error = 251102

         if @i_estado = 'A'
            select @w_error = 251103
       end

      /* No existen Registros */
      exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = @w_error,
      @i_sev       = 0
      return @w_error
   end

   select *
   from   #tmp_cuentas
   where  (Oficina     = @s_ofi AND @w_trn_ofior = 'S') or @w_trn_ofior = 'N'


   if @@rowcount = 0
   begin
      if @i_codcliente is null
         select @w_msg = 'CUENTA NO ES DE ESTA OFICINA'
      else
         select @w_msg = 'CLIENTE NO TIENE CUENTA EN ESTA OFICINA'

      /* No existen Registros */
      exec cobis..sp_cerror
      @t_debug     = @t_debug,
      @t_file      = @t_file,
      @t_from      = @w_sp_name,
      @i_num       = 208158,
      @i_msg       = @w_msg,
      @i_sev       = 0
      return 208158
   end
   set rowcount 0
   drop table #tmp_cuentas
end
return 0

go

