/****************************************************************************/
/*  Archivo:            rem_parctocble.sp                                   */
/*  Stored procedure:   sp_mant_trn_contabilizar                                   */
/*  Base de datos:      cob_remesas                                         */
/*  Producto:           Personalizacion                                     */
/****************************************************************************/
/*                                 IMPORTANTE                               */
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
/*                               PROPOSITO                                  */
/*                                                                          */
/****************************************************************************/
/*                          MODIFICACIONES                                  */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_mant_trn_contabilizar')
  drop proc sp_mant_trn_contabilizar
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_mant_trn_contabilizar (
   @s_ssn          int,
   @s_srv          varchar(30),
   @s_lsrv         varchar(30),
   @s_user         varchar(30),
   @s_sesn         int=null,
   @s_term         varchar(10),
   @s_date         datetime,
   @s_ofi          smallint,       
   @s_rol          smallint,
   @s_org_err      char(1) = null,
   @s_error        int     = null,
   @s_sev          tinyint = null,
   @s_msg          mensaje = null,
   @s_org          char(1),
   @t_corr         char(1) = 'N',
   @t_ssn_corr     int = null,   
   @t_debug        char(1) = 'N',
   @t_file         varchar(14) = null,
   @t_from         varchar(32) = null,
   @t_rty          char(1) = 'N',
   @t_trn          smallint,
   @i_operacion    char(1),
   @i_tran         smallint    = null,
   @i_prod         tinyint     = null,
   @i_causa_org    varchar(5)  = null, 
   @i_causa_dst    varchar(5)  = null, 
   @i_indicador    tinyint     = null,
   @i_perfil       varchar(16) = null,
   @i_contabiliza  varchar(30) = null,
   @i_descripcion  varchar(64) = null,
   @i_sec          int         = null,
   @i_credeb       char(1)     = null,
   @i_estado       char(1)     = null,
   @i_prodban      tinyint     = null,
   @i_clase        char(1)     = null,
   @i_totaliza     char(1)     = null
)
as
declare 
   @w_return        int,
   @w_sp_name       varchar(30),
   @w_sec           int,
   @w_secuencial    int,
   @w_causa_dst     varchar(4), --VMA cambio a 4 caracteres
   @w_indice        int,
   @w_indicador     tinyint,
   @w_contabiliza   varchar(32),
   @w_tran          smallint,
   @w_clase         char(1),
   @w_prodban       tinyint,
   @w_prod          tinyint,
   @w_totaliza      char(1),
   @w_causa_org     varchar(4)
    
/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_mant_trn_contabilizar'

/* Valida Transaccion */
if @t_trn <> 493 and @t_trn <> 689
begin
   /* No existe transaccion */
   exec cobis..sp_cerror
   @t_debug        = @t_debug,
   @t_file         = @t_file,
   @t_from         = @w_sp_name,
   @i_num          = 351014
   return 351014
end

if @i_indicador is null
   select @i_indicador = 0

/* Ingreso de la Transaccion a Contabilizar */
if @i_operacion = 'I'
begin
   if exists (select 1 from cob_remesas..re_tran_contable
              where  tc_tipo_tran   = @i_tran
              and    tc_indicador   = @i_indicador
              and    tc_contabiliza = @i_contabiliza
              and    tc_causa_org   = @i_causa_org
              and    tc_clase       = @i_clase
              and    tc_prod_banc   = @i_prodban
              and    tc_producto    = @i_prod
              and    tc_totaliza    = @i_totaliza)
   begin
      exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 351047
      return 351047
   end    

   begin tran

   /* Obtiene el secuencial */
   exec @w_return = cobis..sp_cseqnos
   @i_tabla     = 're_tran_contable',
   @o_siguiente = @w_sec out
   if @w_return <> 0
      return @w_return          

   select @w_causa_dst = convert(varchar(4), max(tc_indice) + 1) --VMA cambio a 4 caracteres
   from   cob_remesas..re_tran_contable
   where  tc_tipo_tran = @i_tran

   if @w_causa_dst is null
      select @w_causa_dst = '1'

   select @w_indice = isnull(convert(int,@w_causa_dst), 1)

   if @i_tran = 2647
     select @i_causa_org = '4'

   if not exists(select 1 from cobis..cl_catalogo
                 where tabla = (select codigo from cobis..cl_tabla
                 where tabla = 'cc_campo_contable')
                 and   valor = @i_contabiliza)

   begin
      print 'El campo a contabilizar no existe'  
      rollback
      return 1
   end

   /* Inserta en la tabla de transacciones a contabilizar */
   
   insert into cob_remesas..re_tran_contable
          (tc_secuencial, tc_tipo_tran, tc_causa_dst,
           tc_indice, tc_credeb, tc_perfil, 
           tc_contabiliza, tc_indicador, tc_causa_org, 
           tc_descripcion, tc_fecha, tc_producto,
           tc_estado, tc_prod_banc, tc_clase,tc_totaliza)
   values (@w_sec, @i_tran, @w_causa_dst,
           @w_indice, @i_credeb, @i_perfil,
           @i_contabiliza, @i_indicador, @i_causa_org, 
           @i_descripcion, @s_date, @i_prod,
           @i_estado, @i_prodban, @i_clase,@i_totaliza)

   if @@error <> 0
   begin
      exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 353016
      return 353016
   end

   commit tran
   return 0
end

/* Actualizacion de la Transaccion a Contabilizar */
if @i_operacion = 'U'
begin
   select @w_indice = convert(int, @i_causa_dst)

   if exists (select 1 from cob_remesas..re_tran_contable
              where tc_tipo_tran   = @i_tran
              and   tc_indicador   = @i_indicador
              and   tc_contabiliza = @i_contabiliza
              and   tc_causa_org   = @i_causa_org
              and   tc_secuencial <> @i_sec
              and   tc_clase       = @i_clase
              and   tc_prod_banc   = @i_prodban
              and   tc_producto    = @i_prod
              and   tc_totaliza    = @i_totaliza)
   begin
      exec cobis..sp_cerror
      @t_debug        = @t_debug,
      @t_file         = @t_file,
      @t_from         = @w_sp_name,
      @i_num          = 351047
      return 351047
   end    

   begin tran
      if not exists(select 1 from cobis..cl_catalogo
                    where tabla = (select codigo from cobis..cl_tabla where tabla = 'cc_campo_contable')
                    and valor = @i_contabiliza)

      begin
         print 'El campo a contabilizar no existe'  
         rollback
         return 1
      end

      /* Actualiza en la tabla de transacciones a contabilizar */
      update cob_remesas..re_tran_contable set
      tc_tipo_tran         = @i_tran,
      tc_causa_org         = @i_causa_org,
      tc_indicador         = @i_indicador,
      tc_perfil            = @i_perfil,
      tc_causa_dst         = @i_causa_dst,
      tc_credeb            = @i_credeb, 
      tc_indice            = @w_indice,
      tc_contabiliza       = @i_contabiliza, 
      tc_descripcion       = @i_descripcion,
      tc_estado            = @i_estado,
      tc_fecha             = @s_date,
      tc_prod_banc         = @i_prodban,
      tc_clase             = @i_clase,
      tc_totaliza          = @i_totaliza
      where tc_secuencial  = @i_sec

      if @@rowcount <> 1 or @@error <> 0
      begin
         exec cobis..sp_cerror
         @t_debug        = @t_debug,
         @t_file         = @t_file,
         @t_from         = @w_sp_name,
         @i_num          = 355014
         return 355014
      end 
   commit tran
   return 0
end

/* Eliminacion de la Transaccion a Contabilizar */
if @i_operacion = 'D'
begin
   select 
   @w_tran        = tc_tipo_tran,
   @w_indicador   = tc_indicador, 
   @w_contabiliza = tc_contabiliza,
   @w_causa_org   = tc_causa_org,
   @w_clase       = tc_clase,
   @w_prodban     = tc_prod_banc,
   @w_prod        = tc_producto,
   @w_totaliza    = tc_totaliza
   from  cob_remesas..re_tran_contable
   where tc_secuencial  = @i_sec          

   if @@error <> 0
   begin
      /* Error en consulta de transaccion a contabilizar */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 351049
      return 351049
   end    

   begin tran
      /* Elimina en la tabla de transacciones a contabilizar */
      delete cob_remesas..re_tran_contable
      where tc_secuencial  = @i_sec

      if @@rowcount <> 1 or @@error <> 0
      begin
         exec cobis..sp_cerror
            @t_debug        = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 352072
         return 352072
      end 
   commit tran
end
return 0


GO


