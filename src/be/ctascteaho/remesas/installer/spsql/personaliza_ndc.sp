/****************************************************************************/
/*     Archivo:     personaliza_ndc.sp                                      */
/*     Stored procedure: sp_personaliza_ndc                                 */
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
           where  name = 'sp_personaliza_ndc')
  drop proc sp_personaliza_ndc
go

SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
create proc sp_personaliza_ndc (
    @s_ssn            int,
    @s_srv            varchar(30),
    @s_lsrv           varchar(30),
    @s_user           varchar(30),
    @s_sesn           int,
    @s_term           varchar(10),
    @s_date           datetime,
    @s_ofi            smallint,
    @s_rol            smallint = 1,
    @s_org_err        char(1)  = null,
    @s_error          int      = null,
    @s_sev            tinyint  = null,
    @s_msg            mensaje  = null,
    @s_org            char(1),
    @t_debug          char(1) = 'N',
    @t_file           varchar(14) = null,
    @t_from           varchar(32) = null,
    @t_rty            char(1) = 'N',
    @t_trn            smallint,
    @i_operacion      char(1),
    @i_producto       tinyint,
    @i_signo          char(1),
    @i_causa          varchar(10) = null, 
    @i_imprime        char(1) = 'N',
    @i_act_fecha      char(1) = 'S',
    @i_tabla          varchar(25) = null,
    @i_camara         char(1) = 'N',
    @i_cau_aju        varchar(10) = null
)
as
declare
@w_return         int,
@w_sp_name        varchar(30)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_personaliza_ndc'

if @t_trn = 707
begin
   if @i_operacion = 'I' /* Insercion */
   begin
      begin tran
         /* Valida Duplicados */
         if exists (select 1
                    from  cob_remesas..re_propiedad_ndc
                    where pr_producto = @i_producto
                    and   pr_causa    = @i_causa
                    and   pr_signo    = @i_signo)
         begin 
            exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num  = 351047
            return 1
         end
         --print 'Inserta ' + @i_cau_aju
         /* Registro en la Tabla */ 
         insert into cob_remesas..re_propiedad_ndc
                 (pr_producto, pr_causa, pr_signo, pr_impresion, pr_act_fecha, pr_camara, pr_cau_aju)
         values  (@i_producto, @i_causa, @i_signo, @i_imprime,   @i_act_fecha, @i_camara, @i_cau_aju) 

         if @@error != 0
         begin
            exec cobis..sp_cerror
            @t_debug  = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 353037
            return 1
         end

      commit tran
   end

   if @i_operacion = 'S' /* Consulta */
   begin
      set rowcount 20

      select  
      'PRODUCTO'      = pr_producto,
      'SIGNO'         = pr_signo,
      'CAUSA'         = pr_causa,               
      'DESC. CAUSA'   = substring(valor,1,45),
      'IMPR. NOTA'    = pr_impresion,
      'AFECTA FECHA'  = pr_act_fecha,
      'CAMARA'        = pr_camara,
      'CAUSA AJUSTE'  = pr_cau_aju
      from  cob_remesas..re_propiedad_ndc,
            cobis..cl_tabla x, 
            cobis..cl_catalogo y
      where pr_producto = @i_producto 
      and   pr_signo = @i_signo
      and   x.tabla  = @i_tabla 
      and   x.codigo = y.tabla 
      and   y.codigo = pr_causa
      and   pr_causa > @i_causa
      order by pr_producto, pr_signo, pr_causa

      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug  = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 351048
         return 1
      end
      set rowcount 0
   end

   if @i_operacion = 'D' /* Eliminacion del Registro */
   begin
      if not exists(select 1
                    from  cob_remesas..re_propiedad_ndc
                    where pr_producto = @i_producto
                    and   pr_signo    = @i_signo
                    and   pr_causa    = @i_causa)
      begin           
         /* No Existe el Registro a Eliminar */
         exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 357026
         return 1
      end

      begin tran

      delete cob_remesas..re_propiedad_ndc
      where  pr_producto = @i_producto
      and    pr_signo    = @i_signo
      and    pr_causa    = @i_causa

      if @@rowcount != 1
      begin
         /* Error en eliminacion Notas de Debito/Credito a Imprimir */
         exec cobis..sp_cerror
         @t_debug    = @t_debug,
         @t_file = @t_file,
         @t_from = @w_sp_name,
         @i_num      = 357006
         return 1
      end
      commit tran
   end


   if @i_operacion = 'U'
   begin
      if not exists(select 1
                    from  cob_remesas..re_propiedad_ndc
                    where pr_producto = @i_producto
                    and   pr_signo = @i_signo
                    and   pr_causa = @i_causa)
       begin           
          /* No Existe el Registro a Eliminar */
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 351049
          return 1
       end
       --print 'Actualiza ' + @i_cau_aju

       begin tran

       update cob_remesas..re_propiedad_ndc
          set pr_impresion = @i_imprime,
              pr_act_fecha = @i_act_fecha,
              pr_camara    = @i_camara,
              pr_cau_aju   = @i_cau_aju
        where pr_producto  = @i_producto
        and   pr_signo     = @i_signo
        and   pr_causa     = @i_causa

       if @@rowcount != 1
       begin
          /* Error en actualizar accion nota de debito/credito */
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 355041
          return 1
       end
       commit tran
    end
  end /* @t_trn = 707 */
  else
  begin
     /* Error en numero de transaccion */
     exec cobis..sp_cerror
     @t_debug        = @t_debug,
     @t_file         = @t_file,
     @t_from         = @w_sp_name,
     @i_num          = 351014
     return 351014
   end
   return 0

go



