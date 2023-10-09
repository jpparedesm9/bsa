/************************************************************************/
/*      Archivo:                cu_depen.sp                             */
/*      Stored procedure:       sp_dependencias                         */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Garantias                               */
/*      Disenado por:           Silvia Portilla S.                      */
/*      Fecha de escritura:     15/03/2006                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes  exclusivos  para el  Ecuador  de la   */
/*      "NCR CORPORATION".                                              */
/*      Su  uso no autorizado  queda expresamente  prohibido asi como   */
/*      cualquier   alteracion  o  agregado  hecho por  alguno de sus   */
/*      usuarios   sin el debido  consentimiento  por  escrito  de la   */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa permite el mantenimiento de parametrizacion de    */
/*      las dependencias de custodia de documentos                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*         FECHA              AUTOR                  RAZON              */
/*      14/Marzo/2006    Silvia Portilla S.      Emision Inicial        */
/************************************************************************/
use cob_custodia 
go

if exists (select 1 from sysobjects where name = 'sp_dependencias')
   drop proc sp_dependencias
go


create proc sp_dependencias
(
   @s_ssn                   int = null,
   @s_user                  login = null,
   @s_sesn                  int = null,
   @s_term                  varchar(30) = null,
   @s_date                  datetime = null,
   @s_srv                   varchar(30) = null,
   @s_lsrv                  varchar(30) = null,
   @s_rol                   smallint = NULL,
   @s_ofi                   smallint = NULL,
   @s_org_err     char(1) = NULL,
   @s_error       int = NULL,
   @s_sev         tinyint = NULL,
   @s_msg         descripcion = NULL,
   @s_org         char(1) = NULL,
   @t_rty         char(1)  = null,
   @t_trn         smallint = null,
   @t_debug       char(1)  = 'N',
   @t_file        varchar(14) = null,
   @t_from        varchar(30) = null,
   @i_operacion   char(1) = null,


   @i_codigo       catalogo = null,
   @i_descripcion  varchar(30)  = null,
   @i_estado       catalogo = null,
   @i_ambito       char(1)  = null,
   @i_opcion       char(1)  = 'A'   


)
as
declare
   @w_sp_name      varchar(254),
   @w_today        datetime,
   @w_codigo       catalogo,
   @w_descripcion  varchar(30),
   @w_estado       catalogo,
   @w_ambito       char(1) 



select @w_sp_name = 'sp_dependencias',
       @w_today   = getdate()

if @i_operacion = 'I'
begin
   insert into cu_dependencias
   (de_codigo, de_descripcion, de_estado, de_ambito)
   values(@i_codigo, @i_descripcion, @i_estado, @i_ambito)

   if @@error <> 0 
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903001
      return 1 
   end

   insert into ts_dependencias
   ( secuencial,   tipo_transaccion,   clase,    fecha,    usuario, 
     terminal,     oficina,            tabla,   lsrv,     srv,
     codigo,       descripcion,        estado,  ambito
   ) 
   values(
     @s_ssn,       @t_trn,             'N',     @w_today,    @s_user,
     @s_term,      @s_ofi,             'cu_dependencias',    @s_lsrv,   @s_srv,  
     @i_codigo,    @i_descripcion,     @i_estado,            @i_ambito
   )

   if @@error <> 0 
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903003
      return 1 
   end


end  --@i_operacion = 'I'


if @i_operacion = 'U'
begin


    select @w_codigo      = de_codigo, 
           @w_descripcion = de_descripcion, 
           @w_estado      = de_estado,
           @w_ambito      = de_ambito
    from cu_dependencias D
    where de_codigo = @i_codigo

   insert into ts_dependencias
   ( secuencial,   tipo_transaccion,   clase,    fecha,    usuario, 
     terminal,     oficina,            tabla,   lsrv,     srv,
     codigo,       descripcion,        estado,  ambito
   ) 
   values(
     @s_ssn,       @t_trn,             'P',     @w_today,    @s_user,
     @s_term,      @s_ofi,             'cu_dependencias',    @s_lsrv,   @s_srv,  
     @i_codigo,    @w_descripcion,     @w_estado,            @w_ambito
   )

   if @@error <> 0 
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903003
      return 1 
   end


   update cu_dependencias
   set de_descripcion = @i_descripcion,
       de_estado      = @i_estado, 
       de_ambito      = @i_ambito
   where de_codigo = @i_codigo

   if @@error <> 0 
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1905001
      return 1 
   end

   insert into ts_dependencias
   ( secuencial,   tipo_transaccion,   clase,    fecha,    usuario, 
     terminal,     oficina,            tabla,   lsrv,     srv,
     codigo,       descripcion,        estado,  ambito
   ) 
   values(
     @s_ssn,       @t_trn,             'A',     @w_today,    @s_user,
     @s_term,      @s_ofi,             'cu_dependencias',    @s_lsrv,   @s_srv,  
     @i_codigo,    @i_descripcion,     @i_estado,            @i_ambito
   )

   if @@error <> 0 
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903003
      return 1 
   end


end --@i_operacion = 'U'


if @i_operacion = 'S'
begin

    set rowcount 20
    select @i_codigo = isnull(@i_codigo, '')

    select "Codigo"      = de_codigo, 
           "Descripcion" = de_descripcion, 
           "Estado"      = de_estado,
           "Desc.Estado" = (select C.valor
                            from cobis..cl_tabla T, cobis..cl_catalogo C
                            where T.tabla = 'cl_estado_ser'
                            and T.codigo = C.tabla
                            and C.codigo = D.de_estado),
           "Ambito"      = de_ambito
    from cu_dependencias D
    where de_codigo > @i_codigo
    order by de_codigo

    set rowcount 0


end --@i_operacion = 'S'


if @i_operacion = 'H'
begin

    set rowcount 20
    select @i_codigo = isnull(@i_codigo, '')

    if @i_opcion = 'A'
       select "Codigo"      = de_codigo, 
              "Descripcion" = de_descripcion
       from cu_dependencias
       where de_estado = 'V'
      and de_codigo > @i_codigo
      order by de_codigo

    if @i_opcion = 'E'

       select de_descripcion
       from cu_dependencias
       where de_estado = 'V'
       and de_codigo = @i_codigo
      
    set rowcount 0

end --@i_operacion = 'H'

return 0
go


