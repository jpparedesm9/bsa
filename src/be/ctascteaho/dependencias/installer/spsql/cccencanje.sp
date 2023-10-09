/************************************************************************/
/*  Archivo:                cccencanje.sp                               */
/*  Stored procedure:       sp_centro_canje                             */
/*  Base de datos:          cob_cuentas                                 */
/*  Producto:               Cuentas Corrientes                          */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este programa procesa la transaccion de:                            */
/*  Mantenimiento de Centros de Canje.                                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR           RAZON                               */
/*  28/06/2016      Jorge Salazar   Migracion a CEN                     */
/************************************************************************/
use cob_cuentas
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_centro_canje')
  drop proc sp_centro_canje
go

create proc sp_centro_canje 
(
       @s_srv          varchar(16)  = null,
       @t_debug        char(1)      = 'N', 
       @t_file		   varchar(14)  = null,
       @t_from		   varchar(32)  = null,
       @t_trn		   smallint,
       @t_show_version bit          = 0,
       @i_filial       tinyint      = 1,
       @i_opcion       char(2),
       @i_sec          int          = null,
       @i_oficina      int          = null,
       @i_desc         varchar(255) = null,
       @i_ciudad       int          = null,
       @i_tipo         char(2)      = null,
       @i_modo         tinyint      = 0,
       @i_ofi_canje    int          = null
)
as

declare 
    @w_sp_name    varchar(64),
	@w_return 	  int,
    @w_secuencial int

/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_centro_canje'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
  print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
  return 0
end

/*  Valida codigo de Transaccion  */
if @t_trn != 2810 and @t_trn != 2862
  begin
  /*  Error en codigo de transaccion  */
    exec cobis..sp_cerror
	 @t_debug= @t_debug,
	 @t_file= @t_file,
	 @t_from= @t_from,
	 @i_num	= 201048
	 return 201048
  end

/* Se verifica la opcion*/

begin tran
if @i_opcion = 'I' /*Insertar registro*/
   begin
     if exists (select 1 from cob_cuentas..cc_centro_canje
                where ca_oficina = @i_oficina and
                      ca_ciudad = @i_ciudad)
        begin
          /*  Error registro ya existe  */
           exec cobis..sp_cerror
	      @t_debug= @t_debug,
	      @t_file= @t_file,
	      @t_from= @t_from,
	      @i_num	= 351047
	      return 351047          
        end
     else
        begin

          /*Se busca el secuencial de la tabla*/

          exec @w_return  = cobis..sp_cseqnos
          @t_debug        = @t_debug,
          @t_file         = @t_file,
          @t_from         = @w_sp_name,
          @i_tabla        = 'cc_cencanje',
          @o_siguiente    = @w_secuencial out

          if @w_return != 0   
            return @w_return           

          insert into cob_cuentas..cc_centro_canje
          values (@w_secuencial,@i_oficina,@i_desc,@i_ciudad)

          if @@error <> 0
             begin
          /*  Error insertando centro de canje  */
               exec cobis..sp_cerror
	          @t_debug= @t_debug,
	          @t_file= @t_file,
	          @t_from= @t_from,
	          @i_num= 203049
	          return 203049         
             end
        end   

   end
else if @i_opcion = 'U' /*Actualizar registro*/
   begin
     if not exists (select 1 from cob_cuentas..cc_centro_canje
                where ca_sec = @i_sec)
        begin
          /*  Error registro no existe  */
           exec cobis..sp_cerror
	      @t_debug= @t_debug,
	      @t_file= @t_file,
	      @t_from= @t_from,
	      @i_num	= 351049
	      return 351049          
        end
      else
        begin

          update cob_cuentas..cc_centro_canje
          set ca_oficina = @i_oficina,
              ca_desc = @i_desc,
              ca_ciudad = @i_ciudad
          where ca_sec = @i_sec

          if @@error <> 0
             begin
          /*  Error actualizando centro de canje  */
               exec cobis..sp_cerror
	          @t_debug= @t_debug,
	          @t_file= @t_file,
	          @t_from= @t_from,
	          @i_num= 205042
	          return 205042        
             end

        end
   end
else if @i_opcion = 'D' /*Eliminar registro*/
   begin
     if not exists (select 1 from cob_cuentas..cc_centro_canje
                where ca_sec = @i_sec)
        begin
          /*  Error registro no existe  */
           exec cobis..sp_cerror
	      @t_debug= @t_debug,
	      @t_file= @t_file,
	      @t_from= @t_from,
	      @i_num	= 351049
	      return 351049          
        end
      else
        begin

          /*Eliminando relacion oficina-centro de canje*/

          delete from cob_cuentas..cc_ofi_centro
          where oc_centro = @i_sec

          if @@error <> 0
             begin
          /*  Error eliminando centro de canje  */
               exec cobis..sp_cerror
	          @t_debug= @t_debug,
	          @t_file= @t_file,
	       @t_from= @t_from,
	          @i_num= 207018
	          return 207018       
             end
 

          /*Eliminando centro de canje*/          

          delete from cob_cuentas..cc_centro_canje
          where ca_sec = @i_sec

          if @@error <> 0
             begin
          /*  Error eliminando centro de canje  */
               exec cobis..sp_cerror
	          @t_debug= @t_debug,
	          @t_file= @t_file,
	          @t_from= @t_from,
	          @i_num= 207017
	          return 207017       
             end
        end
   end
else 

if @i_opcion = 'S' /*Busqueda de informacion*/
begin
  set rowcount 20
  if @i_modo = 0
  begin
       
       select '5088739' = ca_sec,'503203' = ca_oficina,'503233' = ca_desc,'509092' = ca_ciudad
         from cob_cuentas..cc_centro_canje
        where ca_sec > @i_sec
        order by ca_sec
     
  end
  else
  begin
      
       select '5088739' = ca_sec,'503203' = ca_oficina,'503233' = ca_desc,'509092' = ca_ciudad
         from cob_cuentas..cc_centro_canje
        where ca_sec > @i_sec
        order by ca_sec
      
  end
    set rowcount 0
end




else if @i_opcion = 'H'
  begin
    if @i_tipo = 'V'
       begin
	select ci_descripcion
	from cobis..cl_ciudad
	where ci_ciudad = @i_ciudad and
	      ci_estado = 'V'
     	if @@rowcount = 0
		exec cobis..sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101024
	       	/*' No existe dato en catalogo'*/
		return 0
       end
      else if @i_tipo = 'A'
	begin
		set rowcount 20

		select '509093'=ci_ciudad,
		       '500126'=ci_descripcion
   	        from cobis..cl_ciudad, cobis..cl_provincia
		where ci_provincia = pv_provincia
		      and ci_estado = 'V'
		      and ci_ciudad > @i_ciudad			
                order by ci_ciudad

     		set rowcount 0 

	end
  end
else if @i_opcion = 'H1'
  begin
      if @i_tipo = 'V'
       begin
         select ca_desc
         from cob_cuentas..cc_centro_canje
         where ca_sec = @i_sec 

     	 if @@rowcount = 0
		   exec cobis..sp_cerror
		     @t_debug	= @t_debug,
		     @t_file	= @t_file,
		     @t_from	= @w_sp_name,
		     @i_num		= 208106
	       	/*' No existe dato en catalogo'*/
		    return 0
       end
       else if @i_tipo = 'A'
	    begin
		  set rowcount 20

		  select '509093'   = ca_sec,
		         '500126' = ca_desc
   	      from   cob_cuentas..cc_centro_canje
		  where ca_sec > @i_sec			
          order by ca_sec

     		set rowcount 0 
        end
         else if @i_tipo = 'C'  -- Busca nombre CtroCanje 
           begin
             select ca_desc
             from   cob_cuentas..cc_centro_canje
             where  ca_oficina = @i_oficina
           end
           else if @i_tipo = 'O'  -- Busca Nombre Oficinas del CtroCanje x Catalogo
            begin
	          select '509094' = of_oficina,
                     '509095' = of_nombre
              from cob_cuentas..cc_centro_canje, 
                   cob_cuentas..cc_ofi_centro,
                   cobis..cl_oficina
              where ca_oficina = @i_oficina
              and   ca_sec     = oc_centro
              and   of_oficina = oc_oficina
              order by of_oficina
            end
             else if @i_tipo = 'Q'  -- Busca Nombre Oficinas por Focus
              begin
	            select of_nombre
                from cob_cuentas..cc_centro_canje, 
                     cob_cuentas..cc_ofi_centro,
                     cobis..cl_oficina
                where ca_oficina = @i_oficina
                and   ca_sec     = oc_centro
                and   of_oficina = @i_ofi_canje  -- Ofc de un CtroCanje
                and   oc_oficina = @i_ofi_canje  -- Ofc de un CtroCanje
                order by of_oficina
            end
            else if @i_tipo = 'C1'
             begin
             select ca_oficina, ca_desc
             from   cob_cuentas..cc_centro_canje
             where  ca_oficina = @i_oficina
           end

  end
commit tran
return 0
go

