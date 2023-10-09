/************************************************************************/
/*  Archivo           : paramet.sp                                      */
/*  Stored procedure  : sp_parametro                                    */
/*  Base de datos     : cobis                                           */
/*  Producto          : Clientes                                        */
/*  Disenado por      : Mauricio Bayas/Sandra Ortiz                     */
/*  Fecha de escritura: 19/Ene/1994                                     */
/*  *********************************************************************/
/*                            IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes  exclusivos  para el  Ecuador  de la       */
/*  'NCR CORPORATION'.                                                  */
/*  Su  uso no autorizado  queda expresamente  prohibido asi como       */
/*  cualquier   alteracion  o  agregado  hecho por  alguno de sus       */
/*  usuarios   sin el debido  consentimiento  por  escrito  de la       */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                            PROPOSITO                                 */
/*  Este programa procesa las transacciones del stored procedure        */
/*  Insercion de cl_parametro                                           */
/*  Modificacion de cl_parametro                                        */
/*  Borrado de cl_parametro                                             */
/*  Busqueda de cl_parametro                                            */
/*                         MODIFICACIONES                               */
/*  FECHA            AUTOR                RAZON                         */
/*  19/ENE/1994      R. Minga V.          Emision Inicial               */
/*  22/Abr/94        F.Espinosa           Parametros tipo 'S' trn       */
/*  23/Mar/15        J. Cartagena         @i_modo=4 para CRE            */
/*  03/Jul/15        J. Guamani           @i_operacion='Q'  form. fecha */
/*  21-Feb-18        ALFNSI               Correcciones migracion        */
/************************************************************************/
use cobis
go
if exists (select * from sysobjects where name = 'sp_parametro')
   drop proc sp_parametro
go

create proc sp_parametro (
       @s_ssn               int           = null,
       @s_user              login         = null,
       @s_sesn              int           = null,
       @s_term              varchar(32)   = null,
       @s_date              datetime      = null,
       @s_srv               varchar(30)   = null,
       @s_lsrv              varchar(30)   = null, 
       @s_rol               smallint      = null,     
       @s_ofi               smallint      = null,
       @s_org_err           char(1)       = null,
       @s_error             int           = null,
       @s_sev               tinyint       = null,
       @s_msg               descripcion   = null,
       @s_org               char(1)       = null,
       @t_debug             char(1)       = 'N',
       @t_file              varchar(14)   = null,
       @t_from              varchar(32)   = null, 
       @t_trn               smallint      = null,
       @t_show_version      bit           = 0, -- Mostrar la versi¢n del programa
       @i_operacion         char(2),
       @i_modo              tinyint       = null,
       @i_parametro         descripcion   = null,
       @i_nemonico          catalogo      = null,
       @i_tipo              char(1)       = null,
       @i_char              varchar(30)   = null,
       @i_tinyint           tinyint       = null,
       @i_smallint          smallint      = null,
       @i_int               int           = null,
       @i_money             money         = null,  
       @i_datetime          datetime      = null,
       @i_float             float         = null,
       @i_producto          char(3)       = null,
       @i_formato_fecha     int           = 101,
       @i_valor             varchar(30)   = null,
       @i_criterio          tinyint       = 0,
       @i_rowcount          smallint      = 20
    
)
as

declare @w_return           int,
        @w_sp_name          varchar(32),
        @w_parametro        descripcion,
        @w_nemonico         catalogo,
        @w_tipo             char(1),
        @w_char             char(1),
        @w_tinyint          tinyint,
        @w_smallint         smallint,
        @w_int              int,
        @w_money            money,
        @w_datetime         datetime,
        @w_float            float,
        @w_producto         char(3),
        @v_parametro        descripcion,
        @v_nemonico         catalogo,
        @v_tipo             char(1),
        @v_char             char(1),
        @v_tinyint          tinyint,
        @v_smallint         smallint,
        @v_int              int,
        @v_money            money,
        @v_datetime         datetime, 
        @v_float            float,
        @v_producto         char(3),
        @w_tldc             tinyint,
        @w_valor_parametro  varchar(30),
        @o_nombre_parametro varchar(64), 
        @o_tipo_parametro   varchar(1), 
        @o_valor_parametro  varchar(10)
        
select @w_sp_name  = 'sp_parametro',
       @i_rowcount = isnull(@i_rowcount,20)

if @t_show_version = 1
begin
   print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.1'
   return 0
end

-- Valida codigo de transaccion
if  (@t_trn !=  576   or @i_operacion     != 'I')
and (@t_trn !=  577   or @i_operacion     != 'U')
and (@t_trn !=  1580  or @i_operacion not in ('S','SC'))
and (@t_trn !=  1579  or @i_operacion not in ('Q', 'QS'))
begin
   select @w_return  = 151051
   goto ERROR
end

/*** Tamanio de longitud para descripcion de catalogos ****/
select @w_tldc=pa_tinyint
from   cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'TLDC'

if @@rowcount=0
   select @w_tldc = 60

/* ** Insert ** */
if @i_operacion = 'I'
begin

   /* comprobar que no exista parametros duplicados */
   if exists ( select *     
             from cl_parametro    
            where    pa_nemonico = @i_nemonico and pa_producto = @i_producto)
   begin
      select @w_return  = 151046
      goto ERROR
   end

   begin tran

      /* Insertar los datos de entrada */
      insert into cl_parametro 
             (pa_parametro, pa_nemonico, pa_tipo,     pa_char,  pa_tinyint, pa_smallint,
              pa_int,       pa_money,    pa_datetime, pa_float, pa_producto)
      values (@i_parametro, @i_nemonico, @i_tipo,     @i_char,  @i_tinyint, @i_smallint,
              @i_int,       @i_money,    @i_datetime, @i_float, @i_producto)
      
      if @@error != 0
      begin
         select @w_return  = 103054
         goto ERROR
      end
      
      /* transaccion servicio - nuevo */
      insert into ts_parametro 
             (secuencia,   tipo_transaccion, clase,       fecha,       oficina_s,   
              usuario,     terminal_s,       srv,         lsrv,        parametro,   
              nemonico,    tipo,             pa_char,     pa_tinyint,  pa_smallint, 
              pa_int,      pa_money,         pa_datetime, pa_float,    producto)                                   
      values (@s_ssn,      576,              'N',         @s_date,     @s_ofi, 
              @s_user,     @s_term,          @s_srv,      @s_lsrv,     @i_parametro, 
              @i_nemonico, @i_tipo,          @i_char,     @i_tinyint,  @i_smallint,
              @i_int,      @i_money,         @i_datetime, @i_float,    @i_producto)
      
      /* Si no se puede insertar , error */
      if @@error != 0
      begin
            select @w_return  = 103005
       goto ERROR
      end
   commit tran
end

/* ** Update ** */
if @i_operacion = 'U'
begin

   /* Guardar los datos anteriores */
   select @w_parametro = pa_parametro,
          @w_tipo      = pa_tipo,
          @w_char      = pa_char,
          @w_tinyint   = pa_tinyint,
          @w_smallint  = pa_smallint, 
          @w_int       = pa_int, 
          @w_money     = pa_money, 
          @w_datetime  = pa_datetime, 
          @w_float     = pa_float,
          @w_producto  = pa_producto 
   from   cl_parametro 
   where  pa_nemonico = @i_nemonico
          

  if @@rowcount = 0 
  begin
        select @w_return  = 101077
      goto ERROR
   end

   /* Guardar en transacciones de servicio solo los datos que han cambiado */
   select @v_parametro = @w_parametro,
          @v_tipo      = @w_tipo,
          @v_char      = @w_char,
          @v_tinyint   = @w_tinyint,
          @v_smallint  = @w_smallint, 
          @v_int       = @w_int, 
          @v_money     = @w_money, 
          @v_datetime  = @w_datetime, 
          @v_float     = @w_float, 
          @v_producto  = @w_producto 
   
   if @w_parametro = @i_parametro
      select @w_parametro = null, @v_parametro = null
   else
      select @w_parametro = @i_parametro

   if @w_tipo = @i_tipo
      select @w_tipo = null, @v_tipo = null
   else
      select @w_tipo = @i_tipo
   
   if @w_char = @i_char
      select @w_char = null, @v_char = null
   else
      select @w_char = @i_char
   
   if @w_tinyint = @i_tinyint
      select @w_tinyint = null, @v_tinyint = null
   else
      select @w_tinyint = @i_tinyint
   
   if @w_smallint = @i_smallint
     
   select @w_smallint = null, @v_smallint = null
   else
      select @w_smallint = @i_smallint
   
   if @w_int = @i_int
      select @w_int = null, @v_int = null
   else
      select @w_int = @i_int
   
   if @w_money = @i_money
      select @w_money = null,  @v_money = null
   else
      select @w_money = @i_money
   
   if @w_datetime = @i_datetime
      select @w_datetime = null, @v_datetime = null
   else
      select @w_datetime = @i_datetime
   
   if @w_float = @i_float
      select @w_float = null, @v_float = null
   else
      select @w_float = @i_float
   
   if @w_producto = @i_producto
      select @w_producto = null, @v_producto = null
   else
      select @w_producto = @i_producto
      
   begin tran
      update cl_parametro 
      set    pa_parametro = @i_parametro,
             pa_tipo      = @i_tipo,
             pa_char      = @i_char,
             pa_tinyint   = @i_tinyint,
             pa_smallint  = @i_smallint, 
             pa_int       = @i_int, 
             pa_money     = @i_money, 
             pa_datetime  = @i_datetime, 
             pa_float     = @i_float
      where  pa_nemonico = @i_nemonico
      and    pa_producto = @i_producto /* ORM: Junio/03/2003 */

      if @@error != 0
      begin
         select @w_return  = 155024
         goto ERROR
      end

      /* transaccion servicios - previo */
      insert into ts_parametro 
             (secuencia, tipo_transaccion, clase,        fecha,
              oficina_s, usuario,          terminal_s,   srv, 
              lsrv,      parametro,        nemonico,     tipo,
              pa_char,   pa_tinyint,       pa_smallint,  pa_int, 
              pa_money,  pa_datetime,      pa_float,     producto)
      values (@s_ssn,    577 ,             'P',          @s_date,
              @s_ofi,    @s_user,          @s_term,      @s_srv, 
              @s_lsrv,   @v_parametro,     @i_nemonico,  @v_tipo,
              @v_char,   @v_tinyint,       @v_smallint,  @v_int, 
              @v_money,  @v_datetime,      @v_float,     @v_producto)

      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end

      /* transaccion servicios - anterior */
      insert into ts_parametro 
             (secuencia, tipo_transaccion, clase,       fecha,
              oficina_s, usuario,          terminal_s,  srv, 
              lsrv,      parametro,        nemonico,    tipo,
              pa_char,   pa_tinyint,       pa_smallint, pa_int, 
              pa_money,  pa_datetime,      pa_float,    producto)
      values (@s_ssn,    577 ,             'A',         @s_date,      
              @s_ofi,    @s_user,          @s_term,     @s_srv, 
              @s_lsrv,   @w_parametro,     @i_nemonico, @w_tipo,
              @w_char,   @w_tinyint,       @w_smallint, @w_int, 
              @w_money,  @w_datetime,      @w_float,    @w_producto)
      
      if @@error != 0     
      begin
         select @w_return  = 103005
         goto ERROR
      end
  commit tran
end


/* ** Search** */
if @i_operacion = 'S' 
begin

   /***** BUSQUEDA POR MNEMONICO *******/
   if @i_criterio=0  
   begin
      set rowcount 20
      select 'Nemonico'       = pa_nemonico ,
             'Producto'       = pa_producto,
             'Parametro'      = substring(pa_parametro, 1, @w_tldc),
             'Valor Char'     = pa_char,
             'Valor Tinyint'  = pa_tinyint,
             'Valor Smallint' = pa_smallint,
             'Valor Int'      = pa_int,  
             'Valor Money'    = pa_money, 
             'Valor Float'    = pa_float,
             'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
      from   cl_parametro 
      where  pa_nemonico  like @i_valor+'%'
      and    ((((pa_producto > @i_producto) or (pa_producto = @i_producto and pa_nemonico > @i_nemonico)) and @i_modo = 1) or @i_modo = 0)
      order by pa_producto, pa_nemonico
      
      if @@rowcount=0 
      begin
         select @w_return  = 151121
         goto ERROR            
      end
      set rowcount 0
      return 0
   end
   
   /********* BUSQUEDA POR NOMBRE *********/
   if @i_criterio=1
   begin
      set rowcount 20

      select 'Nemonico'       = pa_nemonico ,
             'Producto'       = pa_producto,
             'Parametro'      = substring(pa_parametro, 1, @w_tldc),
             'Valor Char'     = pa_char,
             'Valor Tinyint'  = pa_tinyint,
             'Valor Smallint' = pa_smallint,
             'Valor Int'      = pa_int,
             'Valor Money'    = pa_money, 
             'Valor Float'    = pa_float,
             'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
      from   cl_parametro
      where  pa_parametro like @i_valor+'%' 
      and    ((((pa_producto   > @i_producto) or (pa_producto = @i_producto and pa_nemonico > @i_nemonico)) and @i_modo = 1 ) or @i_modo = 0)
      order  by pa_producto, pa_nemonico

      if @@rowcount=0 
      begin  
         select @w_return  = 151121
         goto ERROR          
      end
      set rowcount 0
      return 0
   end
   
   /********* BUSQUEDA POR PRODUCTO *********/
   if @i_criterio=2
   begin
      set rowcount @i_rowcount
      /******** BUSCAR *******/
      select 'Nemonico'       = pa_nemonico ,
             'Producto'       = pa_producto,
             'Parametro'      = substring(pa_parametro, 1, @w_tldc), 
             'Valor Char'     = pa_char,
             'Valor Tinyint'  = pa_tinyint,
             'Valor Smallint' = pa_smallint,
             'Valor Int'      = pa_int,
             'Valor Money'    = pa_money, 
             'Valor Float'    = pa_float,        
             'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
      from   cl_parametro 
      where  pa_producto like @i_valor+'%'
      and    ((((pa_producto > @i_producto) or (pa_producto = @i_producto and pa_nemonico>@i_nemonico)) and @i_modo = 1) or @i_modo = 0)
      order by pa_producto, pa_nemonico
       
      if @@rowcount=0 
      begin   
         select @w_return  = 151121
         goto ERROR 
         set rowcount 0
      end
      set rowcount 0
      return 0
   end     
end

if @i_operacion = 'SC' 
begin

   set rowcount 20
   select 'Nemonico'       = pa_nemonico ,
          'Producto'       = pa_producto,      
          'Parametro'      = substring(pa_parametro, 1, @w_tldc),
          'Valor Char'     = pa_char,
          'Valor Tinyint'  = pa_tinyint,
          'Valor Smallint' = pa_smallint,
          'Valor Int'      = pa_int,
          'Valor Money'    = pa_money,     
          'Valor Float'    = pa_float,
          'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
   from   cl_parametro 
   where  pa_producto   = @i_producto  
   and    ((pa_nemonico > @i_nemonico and @i_modo = 1) or @i_modo = 0)
   order  by pa_nemonico
   set rowcount 0
end

/* ** Query de parametro dado el registro ** */
if @i_operacion in ('Q', 'QS')
begin

   if @i_tipo = 'F'  
      select pa_int
      from   cl_parametro
      where  pa_nemonico  = @i_nemonico
   else
   begin
      if @i_modo = 3
      begin
         select 'Nemonico'       = pa_nemonico ,
                'Parametro'      = pa_parametro,
                'Tipo'           = pa_tipo,
                'Valor Char'     = isnull(pa_char,' '),
                'ValorTinyint'   = isnull(pa_tinyint,0),
                'Valor Smallint' = isnull(pa_smallint,0),
                'Valor Int'      = isnull(pa_int,0),
                'Valor Money'    = isnull(pa_money,0.0), 
                'Valor Float'    = isnull(pa_float,0.0),
                'Valor Datetime' = pa_datetime,
                'Cod.Prod.'      = pd_producto,
                'Des.Prod.'      = pd_descripcion,
                'Producto'       = pa_producto
         from   cl_parametro, 
                cl_producto
         where  pa_nemonico = @i_nemonico 
         and    pa_producto = @i_producto
         and    pa_producto = pd_abreviatura
         return 0
      end
      
   if @i_modo = 5
   begin
      select c.codigo,    -- Atributo  (A- Canton, B- Barrio, D- Departamento, P- Provincia)
             c.valor      -- Si aplica o no a la estructura del pais
      from   cobis..cl_tabla t,
             cobis..cl_catalogo c
      where  t.tabla  = 'cl_estructura_pais'
      and    t.codigo = c.tabla
      order by c.codigo
   end
   
   if @i_modo = 4
   begin
      select @w_parametro = pa_parametro,
             @w_tipo      = pa_tipo
      from   cl_parametro , cl_producto
      where  pa_nemonico = @i_nemonico 
      and    pa_producto = @i_producto
      and    pa_producto = pd_abreviatura
   
       select @w_valor_parametro = case @w_tipo
                                   when 'C' then  pa_char
                                   when 'T' then  convert(varchar,pa_tinyint )
                                   when 'S' then  convert(varchar,pa_smallint)
                                   when 'D' then  convert(varchar(10),pa_datetime,@i_formato_fecha)     
                                   when 'F' then  convert(varchar,pa_float) 
                                   when 'M' then  convert(varchar,pa_money)
                                   when 'I' then  convert(varchar,pa_int)
                                   else '1' end
      from   cobis..cl_parametro 
      where  pa_tipo         = @w_tipo
      and    pa_nemonico     = @i_nemonico
      and    pa_producto     = @i_producto 
      
      select  @w_parametro , @w_tipo, @w_valor_parametro
      return 0
   end    
   else
      begin            
         select  'Nemonico'        = pa_nemonico ,
                 'Parametro'       = pa_parametro,
                 'Tipo'            = pa_tipo,
                 'Valor Char'      = isnull(pa_char,' '),
                 'ValorTinyint'    = isnull(pa_tinyint,0),
                 'Valor Smallint'  = isnull(pa_smallint,0),
                 'Valor Int'       = isnull(pa_int,0),
                 'Valor Money'     = isnull(pa_money,0.0), 
                 'Valor Float'     = isnull(pa_float,0.0),
                 'Valor Datetime'  = convert(char(10),pa_datetime,@i_formato_fecha),
                 'Cod.Prod.'       = pd_producto,
                 'Des.Prod.'       = pd_descripcion,
                 'Producto'        = pa_producto
         from    cl_parametro,
                 cl_producto
         where   pa_nemonico = @i_nemonico 
         and     pa_producto = @i_producto
         and     pa_producto = pd_abreviatura
         return 0
      end        
   end
end

-- OUS Agregada Operacion de Busqueda para ser usada por el Servicio
if @i_operacion = 'SS' 
begin
   set rowcount 20
   if @i_modo in (0,1)
   begin
      select 'Nemonico'       = pa_nemonico ,
             'Producto'       = pa_producto,
             'Parametro'      = convert(varchar,pa_parametro),
             'Valor Char'     = pa_char,
             'Valor Tinyint'  = pa_tinyint,
             'Valor Smallint' = pa_smallint,
             'Valor Int'      = pa_int,
             'Valor Money'    = pa_money, 
             'Valor Float'    = pa_float,
             'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha),
             'Tipo Dato'      = pa_tipo
      from   cl_parametro 
      where  pa_producto   = @i_producto
      and    ((pa_nemonico > @i_nemonico  and  @i_modo = 1) or @i_modo = 0)
      order by pa_nemonico
          
      if @@rowcount = 0
      begin
         select @w_return  = 601157
         goto ERROR
      end
   end
       
   if @i_modo = 2
   begin
      set rowcount 0 

      select 'Nemonico'       = pa_nemonico ,
             'Producto'       = pa_producto,
             'Parametro'      = pa_parametro,
             'Valor Char'     = pa_char,
             'Valor Tinyint'  = pa_tinyint,
             'Valor Smallint' = pa_smallint,
             'Valor Int'      = pa_int,  
             'Valor Money'    = pa_money, 
             'Valor Float'    = pa_float,
             'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha),
             'Tipo Dato'      = pa_tipo
      from   cl_parametro
      where  pa_producto    = @i_producto
      and    pa_nemonico like @i_nemonico 
      order by pa_nemonico
   end    
   set rowcount 0
   return 0
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
