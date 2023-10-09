/****************************************************************************/
/*     Archivo:     causal_ndc_oficina.sp                                   */
/*     Stored procedure: sp_causal_ndc_oficina                              */
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
           where  name = 'sp_causal_ndc_oficina')
  drop proc sp_causal_ndc_oficina
go
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_causal_ndc_oficina (
   @s_ssn        int         = NULL,
   @s_user       login       = NULL,
   @s_term       varchar(30) = NULL,
   @s_date       datetime    = NULL,
   @s_srv        varchar(30) = NULL,
   @s_lsrv       varchar(30) = NULL, 
   @s_rol        smallint    = NULL,
   @s_ofi        smallint    = NULL,
   @s_org_err    char(1)     = NULL,
   @s_error      int         = NULL,
   @s_sev        tinyint     = NULL,
   @s_msg        descripcion = NULL,
   @s_org        char(1)     = NULL,
   @t_debug      char(1)     = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(32) = null,
   @t_trn        smallint    = NULL,
   @i_operacion  varchar(2),
   @i_oficina    smallint    = 0,
   @i_tabla      varchar(30) = null,
   @i_cod_tabla  varchar(30) = null,
   @i_codigo     varchar(10) = '0',
   --@i_tabla_gen  varchar(30) = null,
   @i_modo       tinyint     = 0,
   @i_tipo       char(1)     = null
)
as

declare 
   @w_return   int,
   @w_sp_name  varchar(32),
   @w_error    int,
   @w_oficina  smallint

select @w_sp_name = 'sp_causal_ndc_oficina'


if @t_debug = 'S' print '@t_trn' + cast(@t_trn as varchar)
if @t_debug = 'S' print '@w_sp_name' + cast(@w_sp_name as varchar)
if @t_debug = 'S' print '@i_operacion ' + cast(@i_operacion  as varchar)


/* Error en codigo de transaccion */
if (@i_operacion in ('Q','S1','S2','S') and @t_trn not in (738)) or
   (@i_operacion = 'I' and @t_trn not in (739)) or
   (@i_operacion = 'D' and @t_trn not in (740)) 
begin
   select @w_error = 201048
   goto ERROR
end


/* ** Insert ** */
if @i_operacion = 'I'
begin

   /* Verificar que exista el codigo en la tabla de catalogo */
   if not exists (select 1 from cobis..cl_tabla t, cobis..cl_catalogo c  
                  where t.codigo = c.tabla 
                  and t.tabla = @i_tabla 
                  and c.codigo = @i_codigo) 
   begin
      /*  No existe codigo en la tabla de catalogo */
      exec cobis..sp_cerror 
           @t_debug= @t_debug,
           @t_file = @t_file,
           @t_from = @w_sp_name,
           @i_num  = 101000
   
      return 101000
   end   
   
   /* PARA OFICINA ESPECIFICA */
   if @i_tipo = 'O'
   begin    
      
      if not exists (select 1
                     from cobis..cl_oficina
                     where of_subtipo = @i_tipo
                     and   of_bloqueada = 'N'
                     and   of_oficina = @i_oficina)
      begin
         /*  No existe oficina */
         exec cobis..sp_cerror 
              @t_debug= @t_debug,
              @t_file = @t_file,
              @t_from = @w_sp_name,
              @i_num  = 101016
      
         return 101016
      end
      
      /* Verificar que el codigo no este asociado a la oficina */
      if exists (select 1 
                 from cob_remesas..re_catalogo_ofi
                 where co_oficina = @i_oficina
                 and   co_tipo    = @i_tipo
                 and   co_cod_tabla  = @i_cod_tabla
                 and   co_codigo  = @i_codigo)
      begin
         /* El codigo ya esta asociado a la oficina */
         exec cobis..sp_cerror 
              @t_debug= @t_debug,
              @t_file = @t_file,
              @t_from = @w_sp_name,
              @i_num  = 351073
      
         return 351073
      end
      
       begin tran

       /* Insertar los datos de entrada */
       insert into cob_remesas..re_catalogo_ofi
              (co_tipo, co_oficina, co_tabla, co_cod_tabla, co_codigo)
       values (@i_tipo, @i_oficina, @i_tabla, @i_cod_tabla, @i_codigo)
       
       if @@error <> 0
       begin
          /* Error en insercion RE_CATALOGO_OFI */
          exec cobis..sp_cerror
               @t_debug    = @t_debug,
               @t_file     = @t_file,
               @t_from     = @w_sp_name,
               @i_num      = 353027
       
          return 353027
       end

      /* Transaccion servicio */
      
      insert into cob_cuentas..cc_tran_servicio ( 
             ts_secuencial, ts_tipo_transaccion, ts_clase,
             ts_tsfecha,  ts_usuario, ts_terminal, ts_nodo, 
             ts_oficina,  ts_origen,  ts_tipo,
             ts_ofi_aut,  ts_agente,  ts_cod_banco)
      values (@s_ssn,     @t_trn,     'N',
              @s_date,    @s_user,    @s_term,   @s_srv, 
              @s_ofi,     'U',        @i_tipo,
              @i_oficina, @i_tabla,   @i_codigo)
      
      if @@error <> 0
      begin
         /* Error en creacion de transaccion de servicio */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 203005
      
         return 203005
      end

      commit tran
   end

   /* PARA TODAS LAS OFICINAS */                
   if @i_tipo = 'T'
   begin
      
      if exists (select 1 from cob_remesas..re_catalogo_ofi
                 where co_cod_tabla  = @i_cod_tabla
                 and   co_codigo = @i_codigo
                 and   co_tipo   = @i_tipo)

      begin
         /* El codigo ya esta asociado a la oficina */
         exec cobis..sp_cerror 
              @t_debug= @t_debug,
              @t_file = @t_file,
              @t_from = @w_sp_name,
              @i_num  = 351073
      
         return 351073
      end

      begin tran

       /* Insertar los datos de entrada */
            insert into cob_remesas..re_catalogo_ofi
                   (co_tipo, co_tabla, co_cod_tabla, co_codigo)
            values (@i_tipo, @i_tabla, @i_cod_tabla, @i_codigo)
            
            if @@error <> 0
            begin
               /* Error en insercion RE_CATALOGO_OFI */
               exec cobis..sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 353027
            
               return 353027
            end

      -- Transaccion servicio 
      
      insert into cob_cuentas..cc_tran_servicio ( 
             ts_secuencial, ts_tipo_transaccion, ts_clase,
             ts_tsfecha,  ts_usuario, ts_terminal, ts_nodo, 
             ts_oficina,  ts_origen,  ts_tipo,
             ts_ofi_aut,  ts_agente,  ts_cod_banco)
      values (@s_ssn,     @t_trn,     'N',
              @s_date,    @s_user,    @s_term,   @s_srv, 
              @s_ofi,     'U',        @i_tipo,
              0,          @i_tabla,   @i_codigo)
      
      if @@error <> 0
      begin
         /* Error en creacion de transaccion de servicio */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 203005
      
         return 203005
      end
      
      commit tran             
   end   
      
   return 0
end   


if @i_operacion = 'D'
begin

   if @i_tipo = 'O'
   begin
      if exists (select 1 
                 from cob_remesas..re_catalogo_ofi
                where co_oficina = @i_oficina
                and   co_tipo    = @i_tipo
                and   co_cod_tabla   = @i_cod_tabla
                and   co_codigo  = @i_codigo)
      begin
         begin tran
      
         /* Delete asociacion de catalogo a oficina */
         delete cob_remesas..re_catalogo_ofi
          where co_oficina = @i_oficina
          and   co_tipo    = @i_tipo
          and   co_cod_tabla  = @i_cod_tabla
          and   co_codigo  = @i_codigo
      
         if @@error <> 0
         begin
            /* Error al eliminar asociacion de codigo de catalogo a la oficina */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 353028
      
            return 353028
         end
      
      
         -- Transaccion servicio 
      
         insert into cob_cuentas..cc_tran_servicio ( 
             ts_secuencial, ts_tipo_transaccion, ts_clase,
             ts_tsfecha,  ts_usuario, ts_terminal, ts_nodo, 
             ts_oficina,  ts_origen,  ts_tipo,
             ts_ofi_aut,  ts_agente,  ts_cod_banco)
         values 
             (@s_ssn,     @t_trn,     'B',
              @s_date,    @s_user,    @s_term,   @s_srv, 
              @s_ofi,     'U',        @i_tipo,
              @i_oficina, @i_tabla,   @i_codigo)
      
         if @@error <> 0
         begin
            /* Error en creacion de transaccion de servicio */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 203005
      
            return 203005
         end
      
         commit tran
      end
      else
      begin
         /* El codigo no esta asociado a la oficina */
         exec cobis..sp_cerror 
              @t_debug= @t_debug,
              @t_file = @t_file,
              @t_from = @w_sp_name,
              @i_num  = 351074
      
         return 351074
      end      
            
   end --FIN TIPO O

   if @i_tipo = 'T'
   begin
      if exists (select 1 
                 from cob_remesas..re_catalogo_ofi
                where co_cod_tabla   = @i_cod_tabla
                and   co_codigo  = @i_codigo
                and   co_tipo    = @i_tipo)
      begin
         begin tran
      
         /* Delete asociacion de catalogo a oficina */
         delete cob_remesas..re_catalogo_ofi
          where  co_cod_tabla  = @i_cod_tabla
          and   co_tipo    = @i_tipo
          and   co_codigo  = @i_codigo
      
         if @@error <> 0
         begin
            /* Error al eliminar asociacion de codigo de catalogo a la oficina */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 353028
      
            return 353028
         end
      
      
         -- Transaccion servicio 
      
         insert into cob_cuentas..cc_tran_servicio ( 
             ts_secuencial, ts_tipo_transaccion, ts_clase,
             ts_tsfecha,  ts_usuario, ts_terminal, ts_nodo, 
             ts_oficina,  ts_origen,  ts_tipo,
             ts_ofi_aut,  ts_agente,  ts_cod_banco)
         values 
             (@s_ssn,     @t_trn,     'D',
              @s_date,    @s_user,    @s_term,   @s_srv, 
              @s_ofi,     'U',        @i_tipo,
              @i_oficina, @i_tabla,   @i_codigo)
      
         if @@error <> 0
         begin
            /* Error en creacion de transaccion de servicio */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 203005
      
            return 203005
         end
      
         commit tran
      end
      else
      begin
         /* El codigo no esta asociado a la oficina */
         exec cobis..sp_cerror 
              @t_debug= @t_debug,
              @t_file = @t_file,
              @t_from = @w_sp_name,
              @i_num  = 351074
      
         return 351074
      end
            
   end --FIN TIPO T

   return 0
end  -- FIN DELETE



/* Search */
if @i_operacion = 'S' 
begin

   set rowcount 20
   
   /* Busqueda de causales para todas las oficinas */  
   if @i_modo = 0 begin              
      select   
      'COD. CAUSAL'  = CO.co_codigo, 
      'DESC. CAUSAL' = (select valor  from cobis..cl_tabla a, cobis..cl_catalogo b 
                        where a.tabla = @i_tabla 
                        and b.tabla = a.codigo 
                        and b.codigo = CO.co_codigo 
                        and b.estado = 'V')
      from    cob_remesas..re_catalogo_ofi CO
      where   co_cod_tabla  = @i_cod_tabla
      and     CO.co_codigo  > @i_codigo
      and     CO.co_tipo = 'T'
      order by CO.co_oficina asc, CO.co_codigo asc 
      if @@rowcount = 0
      begin
         print 'No existen registros para la consulta'
         return 0
      end    
   end

   /* Busqueda de una causal para todas las oficina */
   if @i_modo = 1 begin              
      select   
      'COD. CAUSAL'  = CO.co_codigo, 
      'DESC. CAUSAL' = (select valor  from cobis..cl_tabla a, cobis..cl_catalogo b 
                        where a.tabla = @i_tabla 
                        and b.tabla = a.codigo 
                        and b.codigo = CO.co_codigo 
                        and b.estado = 'V')
      from    cob_remesas..re_catalogo_ofi CO
      where   co_cod_tabla  = @i_cod_tabla
      and     CO.co_codigo  = @i_codigo
      and     CO.co_tipo = 'T'
      order by CO.co_oficina asc, CO.co_codigo asc 
      if @@rowcount = 0
      begin
         print 'No existen registros para la consulta'
         return 0
      end    
   end   
   
   /* Busqueda de causales para una oficina */
   if @i_modo = 2 begin
   select  
      'OFICINA'      = CO.co_oficina,  
      'COD. CAUSAL'  = CO.co_codigo, 
      'DESC. CAUSAL' = (select valor  from cobis..cl_tabla a, cobis..cl_catalogo b 
                        where a.tabla = @i_tabla 
                        and b.tabla = a.codigo 
                        and b.codigo = CO.co_codigo 
                        and b.estado = 'V')
      from    cob_remesas..re_catalogo_ofi CO
      where   co_cod_tabla  = @i_cod_tabla
      and     CO.co_codigo  > @i_codigo
      and     CO.co_oficina = @i_oficina
      and     CO.co_tipo = 'O'
      order by CO.co_oficina asc, CO.co_codigo asc
      if @@rowcount = 0
      begin
         print 'No existen registros para la consulta'
         return 0
      end
   end
   
   /* Busqueda por causal y oficina */
   if @i_modo = 3 begin
      select  
      'OFICINA'      = CO.co_oficina,  
      'COD. CAUSAL'  = CO.co_codigo, 
      'DESC. CAUSAL' = (select valor  from cobis..cl_tabla a, cobis..cl_catalogo b 
                        where a.tabla = @i_tabla 
                        and b.tabla = a.codigo 
                        and b.codigo = CO.co_codigo 
                        and b.estado = 'V')
      from    cob_remesas..re_catalogo_ofi CO
      where   co_cod_tabla  = @i_cod_tabla
      and     CO.co_codigo  = @i_codigo
      and     co_oficina = @i_oficina
      and     CO.co_tipo = 'O'
      order by CO.co_oficina asc, CO.co_codigo asc     
      if @@rowcount = 0
      begin
         print 'No existen registros para la consulta'
         return 0
      end
   end        
         
   set rowcount 0

end


/* Query */
if @i_operacion = 'Q' 
begin
   set rowcount 0   
   /* Busqueda de causal asociada a la oficina */
      
       select  (select valor  from cobis..cl_tabla a, cobis..cl_catalogo b 
                where a.tabla = @i_tabla 
                and b.tabla = a.codigo 
                and b.codigo = CO.co_codigo 
                and b.estado = 'V')
         from   cob_remesas..re_catalogo_ofi CO
         where  CO.co_oficina  = @i_oficina
         and    CO.co_tabla    = @i_tabla
         and    CO.co_codigo   = @i_codigo
      
         if @@rowcount = 0 begin
            select @w_error = 2902943
            goto ERROR
      
         end
      
      return 0
end

if @t_debug = 'S' print '@i_tipo' + cast(@i_tipo as varchar)
if @t_debug = 'S' print '@i_oficina' + cast(@i_oficina as varchar)
if @t_debug = 'S' print '@i_tabla ' + cast(@i_tabla  as varchar)
if @t_debug = 'S' print '@i_codigo' + cast(@i_codigo as varchar)


/* Search */
if @i_operacion = 'S1'
begin
   
   set rowcount 0
  
   /* Busqueda de codigos de catalogos asociados a la oficina */
   select  
   'CODIGO.CAUSA ' = CO.co_codigo, 
   'DESCRIPCION CAUSA ' = (select valor  from cobis..cl_tabla a, cobis..cl_catalogo b 
                           where a.tabla = @i_tabla 
                           and b.tabla   = a.codigo 
                           and b.codigo  = CO.co_codigo)
   from    cob_remesas..re_catalogo_ofi CO
   where   co_oficina = @s_ofi --??
   and     co_tabla   = @i_tabla
   order by co_codigo asc

   return 0
end

/* Search */
if @i_operacion = 'S2'
begin
   
   set rowcount 40
   /* Busqueda de los codigos de catalogos asociados a una oficina */
   select a.tabla,
          co_codigo,
          b.valor
     from cob_remesas..re_catalogo_ofi,
          cobis..cl_tabla a, cobis..cl_catalogo b
    where co_oficina = @i_oficina
      and co_codigo = b.codigo
      and ((co_tabla > @i_tabla)
           or (co_tabla = @i_tabla and b.codigo > @i_codigo))
      and co_tabla = a.tabla
      and b.tabla = a.codigo
    order by a.tabla, co_codigo
      
   set rowcount 0
   return 0
end

return 0

ERROR:
         exec cobis..sp_cerror
         @t_debug  = null,
         @t_file   = null,
         @t_from   = @w_sp_name,
         @i_num    = @w_error,
         @i_sev    = 0

return @w_error


GO


