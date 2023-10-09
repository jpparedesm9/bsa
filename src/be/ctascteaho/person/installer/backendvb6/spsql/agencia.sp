/****************************************************************************/
/*     Archivo:     agencia.sp                                              */
/*     Stored procedure: sp_agencia                                         */
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
           where  name = 'sp_agencia')
  drop proc sp_agencia
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_agencia (
	@t_debug	char(1) = 'N',
	@t_file		char(1) =  null,
	@i_help		char(1),
	@i_filial	tinyint,
	@i_ofi		smallint = null,
	@i_sig		smallint = 0,
	@i_cob		smallint = null,
    @i_tipo         char(1)  = null,
    @o_subtipo      char(1)  = null out,
    @o_oficob       smallint = null out,
    @o_nombre  varchar(20) = null out
)
as
declare 
  @w_nombre    varchar(30)

if @i_help = 'A'
begin
	set rowcount 20
	select of_oficina,substring(of_nombre,1,30)
    from cobis..cl_oficina
    where of_filial = @i_filial
    and of_oficina > @i_sig
	set rowcount 0
end
else
   if @i_help = 'C'		--Oficinas del COB
   begin

	set rowcount 46
	select of_oficina,
               of_nombre
    from cobis..cl_oficina
         where of_filial  = @i_filial
	   and of_subtipo = 'O'
	   and of_cob     = @i_cob
       and of_oficina > @i_sig
        order by of_oficina
    set rowcount 0
    end
    else
      if @i_help = 'L'		--Lostfocus Oficina del COB
      begin

         if @i_tipo = 'O'
         begin 
             select @o_nombre = of_nombre
             from cobis..cl_oficina
             where of_filial  = @i_filial
             and of_oficina = @i_sig
              --  and isnull(of_cob,@i_sig) = @i_cob
                                                                                                                                                                                                          
             if @@rowcount = 0
             begin
	            exec cobis..sp_cerror
		        @t_debug  = @t_debug,
		        @t_file   = @t_file,
		        @t_from   = 'sp_agencia',
		        @i_num	   = 201094
	            return 201094
             end
         end 
         else
         begin

             select of_nombre
             from cobis..cl_oficina
             where of_filial  = @i_filial
             and of_oficina = @i_sig
             and isnull(of_cob,@i_sig) = @i_cob
                                                                                                                                                                                                            
             if @@rowcount = 0
             begin
	            exec cobis..sp_cerror
		        @t_debug  = @t_debug,
		        @t_file   = @t_file,
		        @t_from   = 'sp_agencia',
		        @i_num	   = 201094
	            return 201094
            end
         end 
      end
      else
         if @i_help = 'O'       --Unicamente oficinas
         begin
            set rowcount 20
            select of_oficina, of_nombre
            from cobis..cl_oficina
            where of_filial  = @i_filial
 	        and of_subtipo = 'O'
            and of_oficina > @i_sig
            order by of_oficina
                                                                                                                                                                                                                              
            set rowcount 0
	 end
         else
            if @i_help = 'R'       --Unicamente Regionales
            begin
                set rowcount 20
                select of_oficina, of_nombre
                from cobis..cl_oficina
                where of_filial  = @i_filial
 	            and of_subtipo = 'R'
                and of_oficina > @i_sig
                order by of_oficina
                set rowcount 0
   	        end
            else
            if @i_help = 'Q'        --Lostfocus Oficina o regional
	        begin
                select of_nombre
                from cobis..cl_oficina
                where of_filial  = @i_filial
                and of_oficina = @i_ofi
                and of_subtipo = (SELECT CASE WHEN @i_sig = 1 THEN 'O' 
                                              WHEN @i_sig = 2 THEN 'R' END)
                                                                                                                                                                                
                if @@rowcount = 0
                begin
	               exec cobis..sp_cerror
		           @t_debug  = @t_debug,
		           @t_file   = @t_file,
		           @t_from   = 'sp_agencia',
		           @i_num	= 201094,
	               @i_msg 	= 'NO EXISTE OFICINA CORRESPONDIENTE AL TIPO'
	               return 201094
                end
            end
 	    else            
            if @i_help = 'B'        --Verifica si es cob u oficina	    
            begin
                select @o_subtipo = of_subtipo, 
                       @o_oficob  = of_oficina
                from   cobis..cl_oficina                 
                where  of_filial  = @i_filial                   
                and    of_oficina = @i_ofi                
                   
                if @@rowcount = 0      
                 begin	            
                        exec cobis..sp_cerror		      
                             @t_debug  = @t_debug,		      
                             @t_file   = @t_file,		      
                             @t_from   = 'sp_agencia',		      
                             @i_num	= 201094,	              
                             @i_msg 	= 'NO EXISTE OFICINA CORRESPONDIENTE AL TIPO'	            
                        return 201094                
                   end                     
            end
            else
            begin
                select substring(of_nombre,1,30)
  	            from cobis..cl_oficina
	            where of_filial = @i_filial
                and   of_oficina = @i_ofi
                
	            if @@rowcount = 0
	            begin
		           exec cobis..sp_cerror
			       @t_debug	= @t_debug,
			       @t_file		= @t_file,
			       @t_from		= 'sp_agencia',
			       @i_num		= 201094
	   	           return 201094
	            end
	      end
                                                                                                                                                                                                                                                    
return 0


GO


