use cob_workflow
go

if exists (select 1 from sysobjects where name = 'sp_user_office')
   drop proc sp_user_office
go

declare
@sp_exists  int,
@table_exists  int 

select @sp_exists =  1 from sysobjects where name = 'sp_ambito_gen'
select @table_exists =  1 from cobis..sysobjects where name = 'ad_ambito_tmp'

IF @sp_exists = 1 and  @table_exists = 1 

BEGIN

exec('

CREATE PROCEDURE sp_user_office(
/************************************************************/

/*   ARCHIVO:         wf_user_office .sp                    */

/*   NOMBRE LOGICO:   sp_user_office                        */

/*   PRODUCTO:        COBIS INBOX                           */

/************************************************************/

/*                     IMPORTANTE                           */

/*   Esta aplicacion es parte de los  paquetes bancarios    */

/*   propiedad de MACOSA S.A.                               */

/*   Su uso no autorizado queda  expresamente  prohibido    */

/*   asi como cualquier alteracion o agregado hecho  por    */

/*   alguno de sus usuarios sin el debido consentimiento    */

/*   por escrito de MACOSA.                                 */

/*   Este programa esta protegido por la ley de derechos    */

/*   de autor y por las convenciones  internacionales de    */

/*   propiedad intelectual.  Su uso  no  autorizado dara    */

/*   derecho a MACOSA para obtener ordenes  de secuestro    */

/*   o  retencion  y  para  perseguir  penalmente a  los    */

/*   autores de cualquier infraccion.                       */

/************************************************************/

/*                     PROPOSITO                            */

/*   Consulta de Oficinas por usuario.                      */

/************************************************************/

/*                     MODIFICACIONES                       */

/*   FECHA        AUTOR               RAZON                 */

/*   30-Oct-2015  Esteban Báez.       Emision Inicial       */

/************************************************************/

   @s_ssn              int,
   @s_user             login       = null,
   @s_term             varchar(32) = null,
   @s_date             datetime    = null,
   @s_srv              varchar(30) = null,
   @s_lsrv             varchar(30) = null,
   @s_ofi              smallint    = null,
   @s_rol              smallint    = NULL,
   @s_org_err          char(1)     = NULL,
   @s_error            int         = NULL,
   @s_sev              tinyint     = NULL,
   @s_msg              descripcion = NULL,
   @s_org              char(1)     = NULL,
   @t_debug            char(1)     = ' + '''' + 'N' + '''' + ',
   @t_file             varchar(10) = null,
   @t_from             varchar(32) = null,
   @t_trn              int    = null,
   @t_show_version     bit         = 0,   
   @i_operacion        char(1)     = null,
   @i_modo             int         = null,
   @i_oficina          smallint    = null,
   @i_siguiente        int         = 0,
   @i_usuario          varchar(16) = null,
   --@i_ssn              int         = null,
   @i_filas            int         = 20,
   @i_nombre_oficina   NOMBRE      = null
      
)
AS
declare @w_error int
declare @w_rol int
declare @w_oficina int

if @i_operacion = ' + '''' + 'C' + '''' + '

begin      
if(@i_nombre_oficina is null or @i_nombre_oficina=' + '''' + '' + '''' + ')
   begin
          if (@i_modo=0)		  
		  begin
		  
		  select @w_oficina = us_oficina from cobis..ad_usuario where us_login =  @i_usuario
		  select @w_rol = ur_rol from cobis..ad_usuario_rol where ur_login = @i_usuario
		  
		  exec @w_error = cobis..sp_ambito_gen 
                @s_ssn=@s_ssn,
                @s_user=@i_usuario,
				@s_date=@s_date,
				@t_trn=15411,
                @i_operacion=' + '''' + 'D' + '''' + ',
    			@i_modo = 1			
		  
		  exec @w_error = cobis..sp_ambito_gen 
                @s_ssn=@s_ssn,
                @s_user=@i_usuario,
                @s_date=@s_date,
                @s_ofi = @w_oficina,
                @s_rol= @w_rol,
                @t_trn=15410,
                @i_operacion=' + '''' + 'I' + '''' + ',
    			@i_modo = 0
				
		  set rowcount @i_filas
	      select 
	      ' + '''' + 'ID' + '''' + '           = of_oficina,
          ' + '''' + 'DESCRIPCION' + '''' + ' = of_nombre
          from cobis..cl_oficina
          where of_oficina in (SELECT distinct  at_oficina from cobis..ad_ambito_tmp where at_user = @i_usuario) 
	      and ((of_oficina >= @i_oficina and @i_modo = 0)
          or  (of_oficina > @i_oficina and @i_modo = 1))
	      order by of_oficina
		end
		else
		begin
		  				
	      set rowcount @i_filas
	      select 
	      ' + '''' + 'ID' + '''' + '           = of_oficina,
          ' + '''' + 'DESCRIPCION' + '''' + ' = of_nombre
          from cobis..cl_oficina
          where of_oficina in (SELECT distinct  at_oficina from cobis..ad_ambito_tmp where at_user = @i_usuario) 
	      and ((of_oficina >= @i_oficina and @i_modo = 0)
          or  (of_oficina > @i_oficina and @i_modo = 1))
	      order by of_oficina
       end  
   end
else	
   BEGIN
		
		 if (@i_modo=0)
		  begin
		  
		  exec @w_error = cobis..sp_ambito_gen 
                @s_ssn=@s_ssn,
                @s_user=@i_usuario,
				@s_date=@s_date,
				@t_trn=15411,
                @i_operacion=' + '''' + 'D' + '''' + ',
    			@i_modo = 1
				
		  
		  exec @w_error = cobis..sp_ambito_gen 
                @s_ssn=@s_ssn,
                @s_user=@i_usuario,
                @s_date=@s_date,
                @s_ofi = @w_oficina,
                @s_rol=@w_rol,
                @t_trn=15410,
                @i_operacion=' + '''' + 'I' + '''' + ',
    			@i_modo = 0
            set rowcount @i_filas
	        select 
	        ' + '''' + 'ID' + '''' + '           = of_oficina,
			' + '''' + 'DESCRIPCION' + '''' + ' = of_nombre
            from cobis..cl_oficina
            where of_oficina in (SELECT distinct  at_oficina from cobis..ad_ambito_tmp where at_user = @i_usuario) 
	        AND UPPER(of_nombre) LIKE ' + '''' + '%' + '''' + '+UPPER(@i_nombre_oficina)+' + '''' + '%' + '''' + '
	         and ((of_oficina >= @i_oficina and @i_modo = 0)
             or  (of_oficina > @i_oficina and @i_modo = 1))
	         order by of_oficina
		  end
		  else
		begin
		     set rowcount @i_filas
			 select 
	        ' + '''' + 'ID' + '''' + '           = of_oficina,
			' + '''' + 'DESCRIPCION' + '''' + ' = of_nombre
            from cobis..cl_oficina
            where of_oficina in (SELECT distinct  at_oficina from cobis..ad_ambito_tmp where at_user = @i_usuario) 
	        AND UPPER(of_nombre) LIKE ' + '''' + '%' + '''' + '+UPPER(@i_nombre_oficina)+' + '''' + '%' + '''' + '
	         and ((of_oficina >= @i_oficina and @i_modo = 0)
             or  (of_oficina > @i_oficina and @i_modo = 1))
	         order by of_oficina
		end
   end
end
else if @i_operacion = ' + '''' + 'T' + '''' + '
begin
	       select 
		   ' + '''' + 'ID' + '''' + '           = of_oficina,
		   ' + '''' + 'DESCRIPCION' + '''' + ' = of_nombre
          from cobis..cl_oficina
          where of_oficina in (SELECT distinct  at_oficina from cobis..ad_ambito_tmp where at_user = @i_usuario) 
	      order by of_oficina
end
return 0
')


END
ELSE
BEGIN


exec('

CREATE PROCEDURE sp_user_office(
/************************************************************/

/*   ARCHIVO:         wf_user_office .sp                    */

/*   NOMBRE LOGICO:   sp_user_office                        */

/*   PRODUCTO:        COBIS INBOX                           */

/************************************************************/

/*                     IMPORTANTE                           */

/*   Esta aplicacion es parte de los  paquetes bancarios    */

/*   propiedad de MACOSA S.A.                               */

/*   Su uso no autorizado queda  expresamente  prohibido    */

/*   asi como cualquier alteracion o agregado hecho  por    */

/*   alguno de sus usuarios sin el debido consentimiento    */

/*   por escrito de MACOSA.                                 */

/*   Este programa esta protegido por la ley de derechos    */

/*   de autor y por las convenciones  internacionales de    */

/*   propiedad intelectual.  Su uso  no  autorizado dara    */

/*   derecho a MACOSA para obtener ordenes  de secuestro    */

/*   o  retencion  y  para  perseguir  penalmente a  los    */

/*   autores de cualquier infraccion.                       */

/************************************************************/

/*                     PROPOSITO                            */

/*   Consulta de Oficinas por usuario.                      */

/************************************************************/

/*                     MODIFICACIONES                       */

/*   FECHA        AUTOR               RAZON                 */

/*   30-Oct-2015  Esteban Báez.       Emision Inicial       */

/************************************************************/

   @s_ssn              int,
   @s_user             login       = null,
   @s_term             varchar(32) = null,
   @s_date             datetime    = null,
   @s_srv              varchar(30) = null,
   @s_lsrv             varchar(30) = null,
   @s_ofi              smallint    = null,
   @s_rol              smallint    = NULL,
   @s_org_err          char(1)     = NULL,
   @s_error            int         = NULL,
   @s_sev              tinyint     = NULL,
   @s_msg              descripcion = NULL,
   @s_org              char(1)     = NULL,
   @t_debug            char(1)     = ' + '''' + 'N' + '''' + ',
   @t_file             varchar(10) = null,
   @t_from             varchar(32) = null,
   @t_trn              int    = null,
   @t_show_version     bit         = 0,   
   @i_operacion        char(1)     = null,
   @i_modo             int         = null,
   @i_oficina          smallint    = null,
   @i_siguiente        int         = 0,
   @i_usuario          varchar(16) = null,
   @i_filas            int         = 20,
   @i_nombre_oficina   NOMBRE      = null
      
)
AS
declare @w_error int
declare @w_rol int
declare @w_oficina int

if @i_operacion = ' + '''' + 'C' + '''' + '

begin      
if(@i_nombre_oficina is null or @i_nombre_oficina=' + '''' + '' + '''' + ')
   begin
          if (@i_modo=0)		  
		  begin
		  
		  set rowcount @i_filas
	      select 
	      ' + '''' + 'ID' + '''' + '           = of_oficina,
          ' + '''' + 'DESCRIPCION' + '''' + ' = of_nombre
          from cobis..cl_oficina
          where of_oficina in (select distinct of_oficina from cobis..cl_oficina) 
	      and ((of_oficina >= @i_oficina and @i_modo = 0)
          or  (of_oficina > @i_oficina and @i_modo = 1))
	      order by of_oficina
		end
		else
		begin
		  				
	      set rowcount @i_filas
	      select 
	      ' + '''' + 'ID' + '''' + '           = of_oficina,
          ' + '''' + 'DESCRIPCION' + '''' + ' = of_nombre
          from cobis..cl_oficina
          where of_oficina in (select distinct of_oficina from cobis..cl_oficina) 
	      and ((of_oficina >= @i_oficina and @i_modo = 0)
          or  (of_oficina > @i_oficina and @i_modo = 1))
	      order by of_oficina
       end  
   end
else	
   BEGIN
		
		 if (@i_modo=0)
		  begin
		  
            set rowcount @i_filas
	        select 
	        ' + '''' + 'ID' + '''' + '           = of_oficina,
			' + '''' + 'DESCRIPCION' + '''' + ' = of_nombre
            from cobis..cl_oficina
            where of_oficina in (select distinct of_oficina from cobis..cl_oficina) 
	        AND UPPER(of_nombre) LIKE ' + '''' + '%' + '''' + '+UPPER(@i_nombre_oficina)+' + '''' + '%' + '''' + '
	         and ((of_oficina >= @i_oficina and @i_modo = 0)
             or  (of_oficina > @i_oficina and @i_modo = 1))
	         order by of_oficina
		  end
		  else
		begin
		     set rowcount @i_filas
			 select 
	        ' + '''' + 'ID' + '''' + '           = of_oficina,
			' + '''' + 'DESCRIPCION' + '''' + ' = of_nombre
            from cobis..cl_oficina
            where of_oficina in (select distinct of_oficina from cobis..cl_oficina) 
	        AND UPPER(of_nombre) LIKE ' + '''' + '%' + '''' + '+UPPER(@i_nombre_oficina)+' + '''' + '%' + '''' + '
	         and ((of_oficina >= @i_oficina and @i_modo = 0)
             or  (of_oficina > @i_oficina and @i_modo = 1))
	         order by of_oficina
		end
   end
end
else if @i_operacion = ' + '''' + 'T' + '''' + '
begin
	       select 
		   ' + '''' + 'ID' + '''' + '           = of_oficina,
		   ' + '''' + 'DESCRIPCION' + '''' + ' = of_nombre
          from cobis..cl_oficina
	      order by of_oficina
end
return 0
')

END
go
