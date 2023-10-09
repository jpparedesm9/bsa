/****************************************************************************/
/*      Archivo           :  cmcattban.sp                                   */
/*      Stored procedure  :  sp_cat_bancos                                  */
/*      Base de datos     :  cob_remesas                                    */
/*      Producto          :  Cuentas de Ahorro                              */
/****************************************************************************/
/*                              IMPORTANTE                                  */
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
/*                              PROPOSITO                                   */
/****************************************************************************/
/*                            MODIFICACIONES                                */
/*      FECHA           AUTOR           RAZON                               */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cat_bancos')
  drop proc sp_cat_bancos
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_cat_bancos (
    @s_ssn            int, 
    @s_srv            varchar(30),
    @s_lsrv           varchar(30),
    @s_user           varchar(30),
    @s_sesn           int,
    @s_term           varchar(10),
    @s_date           datetime,
    @s_ofi            smallint,    /* Localidad origen transaccion */
    @s_rol            smallint,
    @s_org_err        char(1) = null, /* Origen de error:[A], [S] */
    @s_error          int = null,
    @s_sev            tinyint = null,
    @s_msg            varchar(240) = null,
    @t_debug          char(1) = 'N',
    @t_file           varchar(14) = null,
    @t_from           varchar(32) = null,
    @t_rty            char(1) = 'N',
    @t_trn            smallint,
    @i_operacion      char(1),
    @i_modo           tinyint = NULL,
    @i_tipo           char(1) = NULL,
    @i_codigo         int = NULL,
    @i_usuario        login = NULL,
    @i_moneda         tinyint = NULL,
    @i_tipo_compensa  char(1) = 'C',
    @i_descripcion    varchar(64) = NULL
)
as
declare @w_return      int,
       @w_sp_name      varchar(32),
       @w_estado       char(1),
       @w_fecha        datetime,
       @w_toting       int,
       @w_cheques      int,
       @w_descripcion  varchar(64)

select @w_sp_name = 'sp_cat_bancos'


if @t_trn <> 452
begin
    /* Error en codigo de transaccion */
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = 201048
    return 201048
end


/* ** Help ** */
if @i_operacion = 'H'
begin
   /* Help para consulta de los bancos */ 
    if @i_tipo = 'A'
    begin
       set rowcount 20
       if @i_modo = 0
       begin
          select  'Cod.'       = ba_banco,
                  'Descripcion' = ba_descripcion
          from  re_banco
          order by ba_banco
          if @@rowcount = 0
          begin
               exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 351027
               /* 'No existen bancos'*/ 
          end
       end
       if @i_modo = 1
       begin
          select 'Cod.' = ba_banco,
                 'Descripcion' = ba_descripcion
          from   re_banco
          where  ba_banco > @i_codigo
          order by ba_banco
       end
       set rowcount 0
    end
    if @i_tipo = 'V'
    begin
       select  @w_descripcion = ba_descripcion
       from    re_banco
       where   ba_banco = @i_codigo
       order   by ba_banco
       if @@rowcount = 0
       begin
          if @i_codigo = 99
             select @w_descripcion = 'T O D O S'
          else
          begin
             exec cobis..sp_cerror
             @t_debug    = @t_debug,
             @t_file     = @t_file,
             @t_from     = @w_sp_name,
             @i_num      = 351028
             /*  'No existe el banco'*/ 
             return 351028
          end
       end
       select  @w_descripcion 
    end
    if @i_tipo = 'B'
    begin
       select 'Cod.' = ba_banco,
              'Descripcion' = ba_descripcion
     from re_banco
        where ba_descripcion like @i_descripcion
    end
end
/* ** Chequeo del ingreso de un banco ** */
if @i_operacion = 'C'
begin
    select @w_fecha = @s_date

    select @w_estado = in_estado
    from  cm_ingreso
    where in_banco          = @i_codigo
    and   in_fecha          = @w_fecha   
    and   in_moneda         = @i_moneda
    and   in_usuario        = @i_usuario
    and   in_tipo_compensa  = @i_tipo_compensa

    if @@rowcount > 0
    begin
       select @w_toting    = sum(cq_valor),
              @w_cheques   = count(*)
       from   cob_remesas..cm_cheques
       where  cq_banco           = @i_codigo
       and    cq_fecha           = @w_fecha  
       and    cq_moneda          = @i_moneda
       and    cq_usuario         = @i_usuario
       and    cq_tipo_compensa   = @i_tipo_compensa

       update cm_ingreso
       set    in_cheques         = @w_cheques,
              in_total_ingresado = @w_toting
       where  in_banco           = @i_codigo
       and    in_fecha           = @w_fecha 
       and    in_moneda          = @i_moneda
       and    in_usuario         = @i_usuario
       and    in_tipo_compensa   = @i_tipo_compensa

       if @@error <> 0
       begin
           /* Error en la actualizacion de la cabecera */
           exec cobis..sp_cerror1
                   @t_debug        = @t_debug,
                   @t_file         = @t_file,
                   @t_from         = @w_sp_name,
                   @i_num          = 355014                       
           return 355014
       end

       exec cobis..sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_num     = 351032
            /* 'Ya se ingresaron cheques de ese banco'*/
    end
    else
    begin
       delete cm_cheques 
       where  cq_banco         = @i_codigo
       and    cq_fecha         = @w_fecha   
       and    cq_moneda        = @i_moneda
       and    cq_usuario       = @i_usuario
       and    cq_tipo_compensa = @i_tipo_compensa    
    end
        
end
return 0



GO

