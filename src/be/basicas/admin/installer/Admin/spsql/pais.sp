/************************************************************************/
/*  Archivo           : pais.sp                                         */
/*  Stored procedure  : sp_pais                                         */
/*  Base de datos     : cobis                                           */
/*  Producto          : Clientes                                        */
/*  Disenado por      : Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 08-Nov-1992                                     */
/************************************************************************/
/*                    IMPORTANTE                                        */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                    PROPOSITO                                         */
/*  Este programa procesa las transacciones del stored procedure        */
/*      Insercion de Pais                                               */
/*      Update de pais                                                  */
/*  Busqueda de pais                                                    */
/*                    MODIFICACIONES                                    */
/*  FECHA       AUTOR         RAZON                                     */
/*  08/Nov/92   M. Davila     Emision Inicial                           */
/*  12/Ene/93   L. Carvajal   Tabla de errores, variables de debug      */
/*  25/Feb/93   M. Davila     Eliminacion de la tabla del               */
/*  13/Dic/93   R. Minga      Verificacion, param @s_                   */ 
/*  04/Abr/94   C. Rodriguez  nacionalidad en las consultas             */
/*  26/Abr/94   F.Espinosa    Parametros tipo 'S' Transacciones servc.  */
/*  03/May/95   S. Vinces     Cambios para Admin Distribuido            */
/*  21-Feb-18   ALFNSI        Correcciones migracion                    */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_pais')
   drop proc sp_pais
go

create proc sp_pais (
       @s_ssn              int         = null,
       @s_user             login       = null,
       @s_sesn             int         = null,
       @s_term             varchar(32) = null,
       @s_date             datetime    = null,
       @s_srv              varchar(30) = null,
       @s_lsrv             varchar(30) = null, 
       @s_rol              smallint    = null,
       @s_ofi              smallint    = null,
       @s_org_err          char(1)     = null,
       @s_error            int         = null,
       @s_sev              tinyint     = null,
       @s_msg              descripcion = null,
       @s_org              char(1)     = null,
       @t_debug            char(1)     = 'N',
       @t_file             varchar(14) = null,
       @t_from             varchar(32) = null,
       @t_trn              smallint    = null,
       @i_operacion        varchar(2),
       @i_modo             tinyint     = null,
       @i_tipo             varchar(1)  = null,
       @i_pais             smallint    = null,
       @i_descripcion      descripcion = null,
       @i_abreviatura      varchar(3)  = null,
       @i_nacionalidad     descripcion = null,
       @i_continente       varchar(3)  = null, 
       @i_estado           estado      = null,
       @i_central_transmit varchar(1)  = null,
       @i_valor            varchar(64) = null,
       @i_pais_alf         varchar(64) = null 
)
as

declare @w_return           int,
        @w_sp_name          varchar(32),
        @w_abreviatura      char(3),
        @w_nacionalidad     descripcion,
        @w_descripcion      descripcion,
        @w_continente       char(3),
        @w_estado           estado,
        @v_abreviatura      char(3),
        @v_nacionalidad     descripcion,
        @v_descripcion      descripcion,
        @v_continente       char(3),
        @v_estado           estado,
        @o_pais             smallint,
        @w_cmdtransrv       varchar(60),
        @w_server_logico    varchar(10),
        @w_nt_nombre        varchar(30),
        @w_num_nodos        smallint,    
        @w_contador         smallint,
        @w_clave            int,
        @w_codigo_c         varchar(10),
        @w_tabcont          int

select @w_sp_name = 'sp_pais'

-- Valida codigo de transaccion
if  (@t_trn !=  1515  or @i_operacion != 'I')
and (@t_trn !=  1516  or @i_operacion != 'U')
and (@t_trn !=  1552  or @i_operacion != 'S')
and (@t_trn !=  1551  or @i_operacion != 'Q')
and (@t_trn !=  1553  or @i_operacion != 'H')
begin
   select @w_return  = 151051
   goto ERROR
end

select @w_tabcont = codigo
from   cobis..cl_tabla
where  tabla = 'cl_continente'


/* ** Insert ** */
if @i_operacion = 'I'
begin

   /* si no existe error */
   if not exists (select 1 
                  from   cobis..cl_catalogo
                  where  tabla  = @w_tabcont
                  and    codigo = @i_continente)
   begin
      select @w_return  = 101000
      goto ERROR
   end

   /* Verificar que el pais no se repita */
   if exists ( select pa_pais from cl_pais
               where  pa_pais = @i_pais )
   begin
      select @w_return  = 101152
      goto ERROR
   end

   begin tran

      /* Insertar los datos de entrada */
      insert into cl_pais 
             (pa_pais,         pa_descripcion, pa_abreviatura,
              pa_nacionalidad, pa_estado,      pa_continente)
      values (@i_pais,         @i_descripcion, @i_abreviatura,
              @i_nacionalidad, 'V',            @i_continente)
      
      /* Si no se puede insertar error */
      if @@error != 0
      begin
         select @w_return  = 103018
      goto ERROR
      end
      
      /* transaccion servicio - pais */
      insert into ts_pais 
             (secuencia, tipo_transaccion, clase,          fecha,
              oficina_s, usuario,          terminal_s,     srv,            lsrv,
              pais,      descripcion,      abreviatura,    nacionalidad,   estado,
              continente)                                                  
      values (@s_ssn,    1515,             'N',            @s_date,        
              @s_ofi,    @s_user,          @s_term,        @s_srv,         @s_lsrv,
              @i_pais,   @i_descripcion,   @i_abreviatura, @i_nacionalidad,'V',
              @i_continente)
      
      /* Si no se puede insertar , error */
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
   commit tran

   /* Actualizacion de la los datos en el catalogo */
   select @w_codigo_c = convert(varchar(10), @i_pais)
   exec @w_return = sp_catalogo
        @s_ssn           = @s_ssn,
        @s_user          = @s_user,
        @s_sesn          = @s_sesn,
        @s_term          = @s_term, 
        @s_date          = @s_date, 
        @s_srv           = @s_srv,  
        @s_lsrv          = @s_lsrv, 
        @s_rol           = @s_rol,
        @s_ofi           = @s_ofi,
        @s_org_err       = @s_org_err,
        @s_error         = @s_error,
        @s_sev           = @s_sev,
        @s_msg           = @s_msg,
        @s_org           = @s_org,
        @t_debug         = @t_debug,  
        @t_file          = @t_file,
        @t_from          = @w_sp_name,
        @t_trn           = 584,
        @i_operacion     = 'I',
        @i_tabla         = 'cl_pais',
        @i_codigo        = @w_codigo_c,
        @i_descripcion   = @i_descripcion,
        @i_estado        = 'V'  
        
   if @w_return != 0
     return @w_return
end



/* ** Update ** */
if @i_operacion = 'U'
begin

   /* Seleccionar los nuevos datos */
   select @w_descripcion  = pa_descripcion,
          @w_abreviatura  = pa_abreviatura,
          @w_nacionalidad = pa_nacionalidad,
          @w_continente   = pa_continente,
          @w_estado       = pa_estado
   from   cl_pais
   where  pa_pais = @i_pais
   
   if @@rowcount = 0
   begin
      select @w_return  = 101018
      goto ERROR
   end
   
   select @v_descripcion  = @w_descripcion,
          @v_abreviatura  = @w_abreviatura,
          @v_nacionalidad = @w_nacionalidad,
          @v_estado       = @w_estado,
          @v_continente   = @w_continente
   
   if @w_descripcion = @i_descripcion
      select @w_descripcion = null, @v_descripcion = null
   else
      select @w_descripcion = @i_descripcion

   if @w_abreviatura = @i_abreviatura
      select @w_abreviatura = null, @v_abreviatura = null
   else
      select @w_abreviatura= @i_abreviatura

   if @w_nacionalidad = @i_nacionalidad
      select @w_nacionalidad = null, @v_nacionalidad = null
   else
      select @w_nacionalidad = @i_nacionalidad

   if @w_continente = @i_continente
      select @w_continente = null, @v_continente = null
   else
   begin
      select @w_continente = @i_continente
      
      /* Verificar que exista el continente */
      if not exists (select 1 
                     from   cobis..cl_catalogo
                     where  tabla  = @w_tabcont
                     and    codigo = @i_continente)
      begin
         select @w_return  = 101000
         goto ERROR
      end
   end

   if @w_estado = @i_estado
      select @w_estado = null, @v_estado = null
   else
   begin
      if @i_estado = 'C'
      begin
         if exists (select 1
                    from  cl_provincia
                    where pv_pais = @i_pais)
         begin
            select @w_return  = 101017
            goto ERROR
         end 
      end
      select @w_estado = @i_estado
   end

   begin tran
      /* Update pais */
      update cl_pais
      set    pa_descripcion  = @i_descripcion,
             pa_abreviatura  = @i_abreviatura,
             pa_nacionalidad = @i_nacionalidad,
             pa_continente   = @i_continente,
             pa_estado       = @i_estado
      where  pa_pais = @i_pais
      if @@error != 0
      begin
         select @w_return  = 105018
         goto ERROR
      end
      
      /* transaccion servicios - pais */
      insert into ts_pais 
             (secuencia,  tipo_transaccion, clase,          fecha,           
              oficina_s,  usuario,          terminal_s,     srv,             lsrv,
              pais,       descripcion,      abreviatura,    nacionalidad,    estado,
              continente)                                                    
       values (@s_ssn,    1516,             'P',            @s_date,         
               @s_ofi,    @s_user,          @s_term,        @s_srv,          @s_lsrv,
               @i_pais,   @v_descripcion,   @v_abreviatura, @v_nacionalidad, @v_estado,
               @v_continente)
               
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
      
      insert into ts_pais 
             (secuencia,  tipo_transaccion, clase,          fecha,
              oficina_s,  usuario,          terminal_s,     srv,             lsrv,
              pais,       descripcion,      abreviatura,    nacionalidad,    estado,
              continente)                                                    
       values (@s_ssn,    1516,             'A',            @s_date,         
               @s_ofi,    @s_user,          @s_term,        @s_srv,          @s_lsrv,
               @i_pais,   @w_descripcion,   @w_abreviatura, @w_nacionalidad, @w_estado, 
               @w_continente)
               
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
   commit tran

   /* Actualizacion de la los datos en el catalogo */
   select @w_codigo_c = convert(varchar(10), @i_pais)
   exec @w_return = sp_catalogo
        @s_ssn         = @s_ssn,
        @s_user        = @s_user,
        @s_sesn        = @s_sesn,
        @s_term        = @s_term, 
        @s_date        = @s_date, 
        @s_srv         = @s_srv,  
        @s_lsrv        = @s_lsrv, 
        @s_rol         = @s_rol,
        @s_ofi         = @s_ofi,
        @s_org_err     = @s_org_err,
        @s_error       = @s_error,
        @s_sev         = @s_sev,
        @s_msg         = @s_msg,
        @s_org         = @s_org,
        @t_debug       = @t_debug,  
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @t_trn         = 585,
        @i_operacion   = 'U',
        @i_tabla       = 'cl_pais',
        @i_codigo      = @w_codigo_c,
        @i_descripcion = @i_descripcion,
        @i_estado      = @i_estado
        
   if @w_return != 0
     return @w_return

end

/* Search */
if @i_operacion = 'S' 
begin

   set rowcount 20
   select 'PAIS'         = pa_pais,
          'DESCRIPCION'  = convert(char(30),pa_descripcion),
          'ABREVIATURA'  = pa_abreviatura,
          'NACIONALIDAD' = convert(char(30),pa_nacionalidad),
          'COD. CONT.'   = pa_continente,
          'CONTINENTE'   = convert(char(30),valor),
          'ESTADO'       = pa_estado
   from   cl_pais, 
          cl_catalogo
   where  pa_continente     = cl_catalogo.codigo
   and    cl_catalogo.tabla = @w_tabcont
   and    ((pa_pais         > @i_pais and @i_modo = 1) or @i_modo = 0)
   order  by pa_pais 
  
   if @@rowcount = 0
   begin
      select @w_return  = 101000
      goto ERROR
   end
   set rowcount 0
end

/* ** Query ** */
if @i_operacion = 'Q'
begin

   set rowcount 20
   select 'PAIS'         = pa_pais,
          'DESCRIPCION'  = convert(char(30),pa_descripcion),
          'ABREVIATURA'  = pa_abreviatura,
          'NACIONALIDAD' = pa_nacionalidad,
          'COD. CONT.'   = pa_continente,
          'CONTINENTE'   = convert(char(30),valor)
   from   cl_pais, 
          cl_catalogo
   where  pa_estado         = 'V'
   and    pa_continente     = cl_catalogo.codigo
   and    cl_catalogo.tabla = @w_tabcont
   and    ((@i_modo         = 0                  or pa_pais > @i_pais and @i_modo = 1) or  (pa_pais = @i_pais and @i_modo = 2))
   order  by pa_pais 
   
   set rowcount 0
end
/* ** Help ** */
if @i_operacion = 'H'
begin
   if @i_tipo = 'A'
   begin
      set rowcount 20
      if @i_modo in (0,1)    /* los primeros 20 */
         select 'COD.'         = pa_pais,
                'NOMBRE'       = convert(char(30),pa_descripcion),
                'NACIONALIDAD' = convert(char(30),pa_nacionalidad)
         from   cl_pais
         where  pa_estado = 'V'
         and    ((pa_pais > @i_pais and @i_modo = 1) or @i_modo = 0)
         order  by pa_pais      
      else
      begin
         if @i_modo = 2    /* todos */
         begin
            set rowcount 0
            select 'COD.'         = pa_pais,
                   'NOMBRE'       = convert(char(30),pa_descripcion),
                   'NACIONALIDAD' = convert(char(30),pa_nacionalidad)
            from   cl_pais
            where  pa_estado = 'V'
            order  by pa_descripcion     
         end
      end
      set rowcount 0
      return 0
   end
   
   if @i_tipo = 'V'
   begin
      select convert(char(30),pa_descripcion),
             convert(char(30),pa_nacionalidad)
      from   cl_pais
      where  pa_pais   = @i_pais
      and    pa_estado = 'V'
      
      if @@rowcount = 0
      begin
         select @w_return  = 101018
         goto ERROR
      end
      return 0
   end
   
   if @i_tipo = 'B'
   begin
      set rowcount 20
      select 'COD.'         = pa_pais,
             'NOMBRE'       = convert(char(30),pa_descripcion),
             'NACIONALIDAD' = convert(char(30),pa_nacionalidad)
      from   cl_pais
      where  pa_estado            = 'V'
      and    pa_descripcion    like @i_valor
      and    ((pa_descripcion > @i_pais_alf and @i_modo = 1) or @i_modo = 0)
      order  by pa_descripcion
      set rowcount 0       
   end                           
   
end
return 0

ERROR:
   exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return
   /*  'No corresponde codigo de transaccion' */
   return @w_return
go
