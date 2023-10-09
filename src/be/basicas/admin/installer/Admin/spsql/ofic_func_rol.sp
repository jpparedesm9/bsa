/*************************************************************************/
/*  Archivo            : ofic_func_rol.sp                                */
/*  Stored procedure   : sp_ofic_func_rol                                */
/*  Base de datos      : cobis                                           */
/*  Producto           : ADMIN                                           */
/*  Disenado por       : Jose Guamani                                    */
/*  Fecha de escritura : 18-08-2015                                      */
/*************************************************************************/
/*                  IMPORTANTE                                           */
/*  Este programa es parte de los paquetes bancarios propiedad de        */
/*  COBISCORP SA,representantes exclusivos para el Ecuador de la         */
/*  AT&T                                                                 */
/*  Su uso no autorizado queda expresamente prohibido asi como           */
/*  cualquier autorizacion o agregado hecho por alguno de sus            */
/*  usuario sin el debido consentimiento por escrito de la               */
/*  Presidencia Ejecutiva de COBISCORP SA o su representante             */
/*************************************************************************/
/*              PROPOSITO                                                */
/*  Procedimiento que inserta, elimina y busca roles de un supervisor    */
/*  de una oficina                                                       */
/*************************************************************************/
/*              MODIFICACIONES                                           */
/*  FECHA       AUTOR                    RAZON                           */
/*  18/Ago/2015 Jose Guamani              Emision Inicial                */
/*  11-04-2016  BBO                Migracion Sybase-Sqlserver FAL        */
/*************************************************************************/
use cobis
go

SET ANSI_NULLS OFF
go

if exists (select * from sysobjects where name = 'sp_ofic_func_rol')
   drop proc sp_ofic_func_rol
go

create proc sp_ofic_func_rol (
   @s_ssn                 int         = NULL,
   @s_user                login       = NULL,
   @s_sesn                int         = NULL,
   @s_term                varchar(32) = NULL,
   @s_date                datetime    = NULL,
   @s_srv                 varchar(30) = NULL,
   @s_lsrv                varchar(30) = NULL, 
   @s_rol                 smallint    = NULL,
   @s_ofi                 smallint    = NULL,
   @s_org_err             char(1)     = NULL,
   @s_error               int         = NULL,
   @s_sev                 tinyint     = NULL,
   @s_msg                 descripcion = NULL,
   @s_org                 char(1)     = NULL,
   @t_show_version        bit = 0,
   @t_debug               char(1)      = 'N',
   @t_file                varchar(14)  = null,
   @t_from                varchar(32)  = null,
   @t_trn                 smallint     = null,
   @i_operacion           varchar(1),
   @i_rol                 catalogo     = null,
   @i_oficfunc            int          = null,
   @i_codigo              int          = null
 )
as
 declare
    @w_sp_name            varchar(32),
    @w_today              datetime,
    @w_var                int,
    @w_aux                tinyint,   
    @w_codigo             int,
    @w_return             int,
    @w_errmsj             int,
    @w_rol                catalogo,
    @w_oficfunc           int,
	@w_tSup_agencia       int,
    @w_tCargo             int,
	@w_tRrol_superv_ctrctas int

   select @w_sp_name = 'sp_ofic_func_rol'
   
   --VERSIONAMIENTO
   if @t_show_version = 1
   begin
      print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.0'
      return 0
   end
   
   -- VALIDACION DE TRANSACCIONES
   if @t_trn not in(15414,15415,15416,15418)
   begin
      exec sp_cerror
       @t_debug  = @t_debug,
       @t_file   = @t_file,
       @t_from   = @w_sp_name,
       @i_num    = 151051                  
       --NO CORRESPONDE CODIGO DE TRANSACCION
      RETURN 151051
   END

   --VALIDACION MENSAJE ERROR
   if @i_codigo > 0
      select @w_errmsj = 141036
   else
      select @w_errmsj = 157962
   
   
-- INSERT
if @i_operacion = 'I' and @t_trn = 15414
   begin                  
   --VALIDACION: RELACION OFICINA SUPERVISOR - ROL NO EXISTA
      if exists(select 1 
                  from cl_ofic_func_rol
                 where or_oficfunc   = @i_oficfunc 
                   and or_rol        = @i_rol)
       begin
          exec sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 157961                        
             --EL SUPERVISOR YA TIENE ESE ROL
          return 157961
       end
    
    --VALIDA SI EL ROL EXISTE
      if not exists(select 1 
                  from cl_tabla a,cl_catalogo b
                 where a.tabla  = "cl_rol_sup_agencia"
                   and a.codigo = b.tabla
                   and b.codigo = @i_rol)
        
      begin
         exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101056                        
            --EL SUPERVISOR YA TIENE ESE ROL
         return 101056
      end
        
       begin tran
          insert into cl_ofic_func_rol (or_oficfunc, or_rol)
                            values (@i_oficfunc, @i_rol)
          if @@error != 0
          begin
             exec sp_cerror
              @t_debug  = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 153104                     
              --ERROR EN CREACION DE RELACION OFICINA - SUPERVISOR
              return 153104
          end
            
          --TRANSACCION OFICINA -SUPERVISOR 
          insert into ts_oficfunc_rol (secuencia,  tipo_transaccion,   clase,       fecha, 
                                       oficina_s,  usuario,            terminal_s,     srv,
                                       lsrv,       hora,               oficfunc,       rol)
                            values    (@s_ssn,     @t_trn,              'N',         @s_date,
                                       @s_ofi,     @s_user,            @s_term,     @s_srv, 
                                       @s_lsrv,    getdate(),          @i_oficfunc,   @i_rol)
                   
          if @@error != 0
             begin
                exec sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 103005 
                 --'ERROR EN CREACION DE TRANSACCION
                 return 103005 
              end      
                  
       commit tran            
              
       return 0
   end
      
--DELETE
if @i_operacion = 'D' and @t_trn = 15416        
begin
   begin tran
      --ELIMINANDO SUPERVISOR DE OFICINA
      delete from cl_ofic_func_rol
                 where or_oficfunc   = @i_oficfunc
                   and or_rol        = @i_rol
         
      if @@error != 0
         begin
            exec sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 157227               
            --ERROR AL ELIMINAR RELACION OFICINA SUPERVISOR - ROL
            return 157227
         end
      
      --TRANSACCION OFICINA - SUPERVISOR
      insert into ts_oficfunc_rol (secuencia, tipo_transaccion, clase,       fecha,
                                   oficina_s, usuario,          terminal_s,  srv, 
                                   lsrv,      hora,             oficfunc,    rol)
                        values    (@s_ssn,    @t_trn,            'B',         @s_date,
                                   @s_ofi,    @s_user,          @s_term,     @s_srv, 
                                   @s_lsrv,   getdate(),        @i_oficfunc, @i_rol)
            
      if @@error != 0
         begin
            exec sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 103005 
            --ERROR EN CREACION DE TRANSACCION DE SERVICIO
            return 103005 
         end
      
   commit tran
   
   return 0
end

--BUSQUEDA DE ROLES ASOCIADOS A UN FUNC-OFICI
if @i_operacion = 'S' and @t_trn = 15415
   begin
      set rowcount 20
      select 'CODIGO'     = g.of_funcionar,   
             'NOMBRE'     = f.fu_nombre,
             'SUP'        = o.or_rol,
             'DESCRIPCION DEL ROL'= b.valor,
             'OFIFUNROL'  = o.or_oficfunc
        from cl_ofic_func_rol o, cl_funcionario f,cl_ofic_func g,cl_tabla a,cl_catalogo b
       where o.or_oficfunc   = @i_oficfunc
         and g.of_secuencial = o.or_oficfunc
         and g.of_funcionar  = f.fu_funcionario
         and a.tabla  = "cl_rol_sup_agencia"
         and a.codigo = b.tabla
         and b.codigo = o.or_rol
         and (@i_codigo is null or o.or_oficfunc > @i_codigo)
         order by o.or_rol
   
      if @@rowcount=0
         begin
            exec sp_cerror
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = @w_errmsj
            set rowcount 0
            return 1
            --NO HAY REGISTROS
         end
       set rowcount 0
    return 0  
    end     
   
--BUSQUEDA DE FUNCIONARIOS CON ROLES 'Jefe de Agencia' y 'Supervisor Administrativo Operativo'
if @i_operacion = 'Q' and @t_trn = 15418
   begin

   --print '@s_ofi:' + convert(varchar, @s_ofi)
   
      select @w_tSup_agencia = codigo from cobis..cl_tabla where tabla = 'cl_rol_sup_agencia'
	  select @w_tCargo = codigo from cobis..cl_tabla where tabla = 'cl_cargo'
	  select @w_tRrol_superv_ctrctas = codigo from cobis..cl_tabla where tabla = 're_rol_superv_ctrctas'

      select '508574'  = '0',
	         'CODIGO'     = f.fu_funcionario,   
             'NOMBRE'     = f.fu_nombre,
             '502474' = r.or_rol,
             '508575' = (select valor from cobis..cl_catalogo where tabla = @w_tSup_agencia and codigo = r.or_rol),
			 '508576' = (select valor from cobis..cl_catalogo where tabla = @w_tCargo and codigo = convert(varchar(10),f.fu_cargo))
        from cl_ofic_func o,cl_funcionario f, cl_ofic_func_rol r
       where o.of_funcionar = f.fu_funcionario
         and o.of_secuencial = r.or_oficfunc
         and o.of_oficina   = @s_ofi
		 and o.of_filial  = 1  
         and r.or_rol in (select codigo from cobis..cl_catalogo where tabla = @w_tRrol_superv_ctrctas)--Roles permitidos para aprobar impresion de contratos
   
      if @@rowcount=0
         begin
            exec sp_cerror
             @t_debug  = @t_debug,
             @t_file   = @t_file,
             @t_from   = @w_sp_name,
             @i_num    = 157963
            set rowcount 0
            return 1
            --NO HAY REGISTROS
         end
       set rowcount 0
    return 0  
    end  

go


