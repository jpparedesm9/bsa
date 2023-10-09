/************************************************************************/
/*      Archivo:                cu_depusu.sp                            */
/*      Stored procedure:       sp_dep_usuario                          */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Garantias                               */
/*      Disenado por:           Silvia Portilla S.                      */
/*      Fecha de escritura:     17/03/2006                              */
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
/*      los usuarios de las dependencias de custodia de documentos      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*         FECHA              AUTOR                  RAZON              */
/*      17/Marzo/2006    Silvia Portilla S.      Emision Inicial        */
/************************************************************************/
use cob_custodia 
go

if exists (select 1 from sysobjects where name = 'sp_dep_usuario')
   drop proc sp_dep_usuario
go


create proc sp_dep_usuario
(
   @s_ssn           int         = null,
   @s_user          login       = null,
   @s_sesn          int         = null,
   @s_term          varchar(30) = null,
   @s_date          datetime    = null,
   @s_srv           varchar(30) = null,
   @s_lsrv          varchar(30) = null,
   @s_rol           smallint    = NULL,
   @s_ofi           smallint    = NULL,
   @s_org_err       char(1)     = NULL,
   @s_error         int         = NULL,
   @s_sev           tinyint     = NULL,
   @s_msg           descripcion = NULL,
   @s_org           char(1)     = NULL,
   @t_rty           char(1)     = null,
   @t_trn           smallint    = null,
   @t_debug         char(1)     = 'N',
   @t_file          varchar(14) = null,
   @t_from          varchar(30) = null,
   @i_operacion     char(1)     = null,
   @i_dependencia   catalogo    = null,
   @i_usuario       login       = null,
   @i_descripcion   descripcion = null,
   @i_estado        catalogo    = null,
   @i_opcion        char(1)     = null




)
as
declare
   @w_sp_name      varchar(254),
   @w_today        datetime,
   @w_dependencia  catalogo,
   @w_usuario      login  ,
   @w_descripcion  descripcion,
   @w_estado       catalogo


select @w_sp_name = 'sp_dep_usuario',
       @w_today   = getdate()

if @i_operacion = 'I'
begin

   if exists (select 1 from cu_dep_usuario 
              where du_dependencia > '' and du_usuario = @i_usuario and du_estado = 'V')
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1901050
      return 1 
   end


   insert into cu_dep_usuario
   (du_dependencia,  du_usuario,   du_descripcion,   du_estado)
   values(@i_dependencia,  @i_usuario,   @i_descripcion,   @i_estado)

   if @@error <> 0 
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1903001
      return 1 
   end

   insert into ts_dep_usuario
   ( secuencial,   tipo_transaccion,   clase,    fecha,    usuario, 
     terminal,     oficina,            tabla,   lsrv,      srv,
     dependencia,  usuariod,           descripcion,        estado
   ) 
   values(
     @s_ssn,          @t_trn,       'N',                @w_today,    @s_user,
     @s_term,         @s_ofi,       'cu_dep_usuario',   @s_lsrv,     @s_srv,  
     @i_dependencia,  @i_usuario,   @i_descripcion,     @i_estado
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


    select @w_dependencia = du_dependencia,
           @w_usuario     = du_usuario ,
           @w_descripcion = du_descripcion,
           @w_estado      = du_estado
    from cu_dep_usuario D
    where du_dependencia = @i_dependencia
    and du_usuario       = @i_usuario

    if @@rowcount = 0
    begin
       print 'No existe el usuario solicitado'
       return 1
    end
   insert into ts_dep_usuario
   ( secuencial,   tipo_transaccion,   clase,    fecha,    usuario, 
     terminal,     oficina,            tabla,   lsrv,      srv,
     dependencia,  usuariod,           descripcion,        estado
   ) 
   values(
     @s_ssn,          @t_trn,       'P',                 @w_today,  @s_user,
     @s_term,         @s_ofi,       'cu_dep_usuario',    @s_lsrv,   @s_srv,  
     @i_dependencia,  @w_usuario,   @w_descripcion,      @w_estado
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


    update  cu_dep_usuario
    set du_descripcion = @i_descripcion,
        du_estado      = @i_estado
    where du_dependencia = @i_dependencia
    and du_usuario       = @i_usuario

   if @@error <> 0 
   begin
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1905001
      return 1 
   end

   insert into ts_dep_usuario
   ( secuencial,   tipo_transaccion,   clase,    fecha,    usuario, 
     terminal,     oficina,            tabla,   lsrv,      srv,
     dependencia,  usuariod,           descripcion,        estado
   ) 
   values(
     @s_ssn,          @t_trn,       'A',                 @w_today,  @s_user,
     @s_term,         @s_ofi,       'cu_dep_usuario',    @s_lsrv,   @s_srv,  
     @i_dependencia,  @i_usuario,   @i_descripcion,      @i_estado
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
    select @i_usuario     = isnull(@i_usuario,'')

    select "Dependencia" = du_dependencia,
           "Usuario"     = du_usuario,
           "Descripcion" = du_descripcion ,
           "Estado"      = du_estado,
           "Desc.Estado" = (select C.valor
                            from cobis..cl_tabla T, cobis..cl_catalogo C
                            where T.tabla = 'cl_estado_ser'
                            and T.codigo = C.tabla
                            and C.codigo = D.du_estado)
    from  cu_dep_usuario D
    where du_dependencia = @i_dependencia
    and 	 du_usuario     > @i_usuario
    order by du_dependencia, du_usuario
    
    set rowcount 0
end --@i_operacion = 'S'

if @i_operacion = 'H'
begin
	if @i_opcion = 'U'
	begin
		select de_codigo, 
				 de_ambito, 
				 du_descripcion
		from 	cu_dependencias, cu_dep_usuario
		where de_codigo  = du_dependencia
		and 	du_estado  = 'V'
		and 	du_usuario = @i_usuario
	end
	if @i_opcion = 'C'
	begin
		select de_codigo
		from 	cu_dependencias, cu_dep_usuario
		where de_codigo  = du_dependencia
		and 	du_estado  = 'V'
		and 	du_usuario = @i_usuario
		
		if @@rowcount = 0 
	   begin
	     exec cobis..sp_cerror
	         @t_debug = @t_debug,
	         @t_file  = @t_file, 
	         @t_from  = @w_sp_name,
	         @i_num   = 1901051
	      return 1 			
		end		
	end
end --@i_operacion = 'H'


return 0
go


