/********************************************************************/
/*  Archivo:                ahcrenav.sp                             */
/*  Stored procedure:       sp_crea_cuenta_navidad                  */
/*  Base de datos:          cob_ahorros                             */
/*  Producto: Cuentas de Ahorros                                    */
/*  Disenado para:  Global Bank - Panama                            */
/*  Fecha de escritura: 23-Mar-2005                                 */
/********************************************************************/
/*                         IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*  de COBISCorp.                                                   */
/*  Su uso no autorizado queda expresamente prohibido asi como      */
/*  cualquier alteracion o agregado hecho por alguno  de sus        */
/*  usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*  Este programa esta protegido por la ley de derechos de autor    */
/*  y por las convenciones  internacionales de propiedad inte-      */
/*  lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*  penalmente a los autores de cualquier infraccion.               */
/********************************************************************/
/*                          PROPOSITO                               */
/*  Procedimiento para crear nuevas cuentas de Navidad, verifica    */
/*  las fechas de apertura que estTn dentro del periodo definido    */
/********************************************************************/
/*                        MODIFICACIONES                            */
/*  FECHA           AUTOR              RAZON                        */
/*  23/Mar/2005     A. Villarreal      Emision inicial              */
/*  23/Enero/2007   P. Coello          Anadir opciones 'S' y        */
/*                                     'U' por nueva opcion         */
/*                                     actualizacion de ctas        */
/*  10/Feb/2007     P. Coello          Grabar cod_alterno           */
/*                                     por que en el paso a         */
/*                                     historico se cae por dupl.   */
/*  03/May/2016     J. Salazar         Migracion COBIS CLOUD MEXICO */
/********************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_crea_cuenta_navidad')
   drop proc sp_crea_cuenta_navidad
go

/****** Object:  StoredProcedure [dbo].[sp_crea_cuenta_navidad]    Script Date: 03/05/2016 9:52:01 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

create proc sp_crea_cuenta_navidad
(
        @s_ssn                  int,
        @s_srv                  varchar(30),
        @s_lsrv                 varchar(30),
        @s_user                 varchar(30),
        @s_sesn                 int = null,
        @s_term                 varchar(10),
        @s_ofi                  smallint,
        @s_rol                  smallint,
        @s_date                 datetime    = null,
        @t_show_version         bit         = 0,
        @t_debug                char(1)     = 'N',
        @t_file                 varchar(14) = null,
        @t_from                 varchar(30) = null,
        @t_trn                  int,
        @i_codigo               smallint    = null,
        @i_oper                 char(1),
        @i_ofl                  smallint    = null,
        @i_nombre               descripcion = null,
        @i_cli                  int         = null,
        @i_cedruc               varchar(20) = null,
        @i_tprom                char(1)     = null,
        @i_ciclo                char(1)     = null,
        @i_capit                char(1)     = null,
        @i_mon                  tinyint     = null,
        @i_prodbanc             smallint    = null,
        @i_manejo               varchar(20) = null,
        @i_cuota                catalogo    = null,
        @i_relacion             smallint    = null,
        @i_codmanejo            char(1)     = null,
        @i_cons_titulares       char(1)     = 'N',     --INDICAR SI SE DESEA CONSULTAR O NO LOS TITULARES DE LA CUENTA
        @i_cta_banco            cuenta      = null,    --NUMERO DE CUENTA PARA CONSULTA DE CUENTA ESPECIFICA
        @o_funcio               tinyint     = null out,
        @o_cta                  cuenta      = null out
)
as
declare @w_return               int,
        @w_sp_name              varchar(30),
        @w_msg                  char(60),
        @w_oficina              smallint,
        @w_cuenta               int,
        @w_cuota                catalogo,
        @w_oficial              int,
        @w_relacion             int

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_crea_cuenta_navidad'

-- Versionamiento del Programa --
if @t_show_version = 1
begin
   print 'Stored Procedure=' + @w_sp_name +  ' Version=' + '4.0.0.0'
   return 0
end

if @i_oper = 'P'
  begin
     select pa_char
       from cobis..cl_parametro
      where pa_producto = 'AHO'
        and pa_nemonico = 'PBNA'
     if @@rowcount = 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 253070,
               @i_msg          = 'PARAMETRO DE PRODUCTOS BANCARIOS DE NAVIDAD, NO EXISTE'
          return 253070
       end

     select convert(char(10), pa_datetime, 101)
       from cobis..cl_parametro
      where pa_producto = 'AHO'
        and pa_nemonico = 'FEIACN'
     if @@rowcount = 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 253070,
               @i_msg          = 'PARAMETRO DE INICIO DE APERTURA DE CTA DE NAVIDAD, NO EXISTE'
          return 253070
       end

     select convert(char(10), pa_datetime, 101)
       from cobis..cl_parametro
      where pa_producto = 'AHO'
        and pa_nemonico = 'FEFACN'
     if @@rowcount = 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 253070,
               @i_msg          = 'PARAMETRO DE FINALIZACION DE APERTURA DE CTA DE NAVIDAD, NO EXISTE'
          return 253070
       end

  end

if @i_oper = 'R'
  begin
     set rowcount 50

     select rn_codigo, rn_nombre
       from cob_ahorros..ah_relacion_navidad
      where rn_nombre > @i_nombre
      order by rn_nombre
  end

if @i_oper = 'Q'
  begin
     select rn_nombre
       from cob_ahorros..ah_relacion_navidad
      where rn_codigo = @i_codigo

     if @@rowcount = 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 252071
          return 252071
       end
  end

if @i_oper = 'C'
  begin
     select @w_msg = 'CUENTA NAVIDAD ' + @i_manejo

     begin tran

     exec @w_return = cob_ahorros..sp_apertura_ah
          @s_ssn                = @s_ssn,
          @s_srv                = @s_srv,
          @s_lsrv               = @s_lsrv,
          @s_user               = @s_user,
          @s_sesn               = @s_sesn,
          @s_term               = @s_term,
          @s_date               = @s_date,
          @s_ofi                = @s_ofi,
          @t_trn                = 201,
          @i_ofl                = @i_ofl,
          @i_cli                = @i_cli,
          @i_nombre             = @i_nombre,
          @i_cedruc             = @i_cedruc,
          @i_tprom              = @i_tprom,
          @i_ciclo              = @i_ciclo,
          @i_capit              = @i_capit,
          @i_mon                = @i_mon,
          @i_prodbanc           = @i_prodbanc,
          @i_categ              = 'N',
          @i_tdef               = 'D',
          @i_def                = 0,
          @i_rolcli             = 'T',
          @i_rolente            = '1',
          @i_cli1               = 0,
          @i_tipodir            = 'S',
          @i_casillero          = 'NAVIDAD',
          @i_origen             = '2',
          @i_numlib             = 0,
          @i_nombre1            = @w_msg,
          @i_cedruc1            = 'NAVIDAD',
          @i_direc_dv           = 0,
          @i_tipodir_dv         = 'S',
          @i_casillero_dv       = 'S',
          @i_agencia_dv         = 0,
          @i_cli_dv             = 0,
          @i_estado_cuenta      = 'N',
          @i_tipocta_super      = '8',
          @i_numsol             = 0,
          @i_patente            = ' ',
          @o_funcio             = @o_funcio out,
          @o_cta                = @o_cta    out

     if @w_return <> 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 253071
          return 253071
       end

     select @w_cuenta = ah_cuenta
       from cob_ahorros..ah_cuenta
      where ah_cta_banco = @o_cta

     insert into cob_ahorros..ah_cuenta_navidad
            (cn_cuenta, cn_cuota, cn_relacion, 
             cn_manejo, cn_fecha_apertura, cn_usuario_crea, cn_fecha_pago)
     values (@w_cuenta, @i_cuota, @i_relacion, 
             @i_codmanejo, @s_date, @s_user, dateadd(dd, -1, @s_date))
     if @@error <> 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 253071
          return 253071
       end

     select @w_msg = 'CUOTA: $ ' + @i_cuota + ' - ' + @i_nombre

     insert into cob_ahorros..ah_tran_servicio
            (ts_secuencial, ts_tipo_transaccion, ts_tsfecha,    ts_hora,
             ts_usuario,    ts_terminal,         ts_cta_banco,  ts_filial,
             ts_oficina,    ts_oficial,          ts_fecha_aper, ts_cliente,
             ts_ced_ruc,    ts_oficina_cta,      ts_estado,     ts_moneda,
             ts_categoria,  ts_observacion,      ts_producto,   ts_valor,
             ts_tipocta,    ts_prod_banc,        ts_ctacte,     ts_tipocta_super)
     values (@s_ssn,        @t_trn,              @s_date,       getdate(),
             @s_user,       @s_term,             @o_cta,        1,
             @s_ofi,        @i_ofl,              @s_date,       @i_cli,
             @i_cedruc,     @s_ofi,              'A',           @i_mon,
             'N',           @w_msg,              4,             convert(money, @i_cuota),
             'P',           @i_prodbanc,         @w_cuenta,     '8')

     if @@error <> 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 253071
          return 253071
       end

     exec @w_return = cob_ahorros..sp_bloqueo_mov_ah
          @s_ssn                = @s_ssn,
          @s_ssn_branch         = 1,
          @s_srv                = @s_srv,
          @s_user               = @s_user,
          @s_sesn               = @s_sesn,
          @s_term               = @s_term,
          @s_date               = @s_date,
          @s_org                = 'U',
          @s_ofi                = @s_ofi,
          @s_rol                = @s_rol,
          @t_trn                = 211,
          @i_cta                = @o_cta,
          @i_mon                = @i_mon,
          @i_tbloq              = '2',
          @i_aut                = @s_user,
          @i_causa              = '16',
          @i_solicit            = 'APERTURA CUENTA DE NAVIDAD',
          @i_observacion        = @w_msg,
          @o_oficina_cta        = @w_oficina out
     if @w_return <> 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 253071
          return 253071
       end

     commit tran
  end

if @i_oper = 'S'  --CONSULTAR LOS DATOS DE UNA CUENTA ESPECIFICA
  begin
     if @i_cons_titulares = 'S'
     begin
         select 'CODIGO'         = cl_cliente, 
                'IDENTIFICACION' = en_ced_ruc, 
                'TIPO PERSONA'   = en_subtipo, 
                'NOMBRE'         = en_nomlar, 
                'TIT.'           = cl_rol, 
                'DESCRIPCION'    = (select valor
                                      from cobis..cl_catalogo
                                     where codigo = a.cl_rol
                                       and tabla in (select codigo from cobis..cl_tabla where tabla = 'cl_rol'))
           from cobis..cl_det_producto, cobis..cl_cliente a, cobis..cl_ente
          where dp_cuenta = @i_cta_banco
            and cl_det_producto = dp_det_producto
            and en_ente = cl_cliente

         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 252076
            return 252076
         end
     end

     select ah_nombre, ah_prod_banc, cn_cuota, cn_manejo, cn_relacion, ah_oficial
       from ah_cuenta, ah_cuenta_navidad
      where ah_cuenta = cn_cuenta
        and ah_cta_banco   = @i_cta_banco
        and ah_estado      = 'A'
        and cn_fecha_cuota is null

     if @@rowcount = 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 252075
          return 252075
       end


  end

if @i_oper = 'U'
  begin
     /*****SELECCIONO LOS DATOS PREVIOS ******/
     SELECT @w_oficial  = ah_oficial,
            @w_cuota    = convert(varchar(10), cn_cuota),
            @w_relacion = cn_relacion,
            @w_cuenta   = ah_cuenta,
            @i_nombre   = ah_nombre, 
            @i_cli      = ah_cliente,
            @i_cedruc   = ah_ced_ruc,
            @i_mon      = ah_moneda
       from ah_cuenta, ah_cuenta_navidad
      where ah_cuenta = cn_cuenta
        and ah_cta_banco   = @i_cta_banco

     begin tran

     update ah_cuenta
        set ah_cuota   = convert(money, @i_cuota),
            ah_oficial = @i_ofl
       where ah_cta_banco = @i_cta_banco

     if @@error <> 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 257073
          return 257073
       end

     update ah_cuenta_navidad
        set cn_cuota    = @i_cuota,
            cn_relacion = @i_relacion
      where cn_cuenta   = @w_cuenta

     if @@error <> 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 257074
          return 257074
       end

     select @w_msg = 'CUOTA: $ ' + @w_cuota + ' - ' + @i_nombre

     insert into cob_ahorros..ah_tran_servicio
            (ts_secuencial, ts_tipo_transaccion, ts_tsfecha,    ts_hora,
             ts_usuario,    ts_terminal,         ts_cta_banco,  ts_filial,
             ts_oficina,    ts_oficial,          ts_fecha_aper, ts_cliente,
             ts_ced_ruc,    ts_oficina_cta,      ts_estado,     ts_moneda,
             ts_categoria,  ts_observacion,      ts_producto,   ts_valor,
             ts_tipocta,    ts_prod_banc,        ts_ctacte,     ts_tipocta_super,
             ts_clase,      ts_carta, ts_cod_alterno)
     values (@s_ssn,        @t_trn,              @s_date,       getdate(),
             @s_user,       @s_term,             @i_cta_banco,  1,
             @s_ofi,        @w_oficial,          @s_date,       @i_cli,
             @i_cedruc,     @s_ofi,              'A',           @i_mon,
             'N',           @w_msg,              4,             convert(money, @w_cuota),
             'P',           @i_prodbanc,         @w_cuenta,     '8',
             'P',           @w_relacion, 0)

     if @@error <> 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 203005
          return 203005
       end

     select @w_msg = 'CUOTA: $ ' + @i_cuota + ' - ' + @i_nombre

     insert into cob_ahorros..ah_tran_servicio
            (ts_secuencial, ts_tipo_transaccion, ts_tsfecha,    ts_hora,
             ts_usuario,    ts_terminal,         ts_cta_banco,  ts_filial,
             ts_oficina,    ts_oficial,          ts_fecha_aper, ts_cliente,
             ts_ced_ruc,    ts_oficina_cta,      ts_estado,     ts_moneda,
             ts_categoria,  ts_observacion,      ts_producto,   ts_valor,
             ts_tipocta,    ts_prod_banc,        ts_ctacte,     ts_tipocta_super,
             ts_clase,      ts_carta, ts_cod_alterno)
     values (@s_ssn,        @t_trn,              @s_date,       getdate(),
             @s_user,       @s_term,             @i_cta_banco,  1,
             @s_ofi,        @i_ofl,              @s_date,       @i_cli,
             @i_cedruc,     @s_ofi,              'A',           @i_mon,
             'N',           @w_msg,              4,             convert(money, @i_cuota),
             'P',           @i_prodbanc,         @w_cuenta,     '8',
             'A',           @i_relacion, 10)

     if @@error <> 0
       begin
          exec cobis..sp_cerror
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_num          = 203005
          return 203005
       end

     commit tran
  end

return 0

go

