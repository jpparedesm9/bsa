/****************************************************************************/
/*     Archivo:     caubusq.sp                                              */
/*     Stored procedure: sp_caubusq                                         */
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
           where  name = 'sp_caubusq')
  drop proc sp_caubusq
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_caubusq (
   @s_ssn          int = NULL,
   @s_user         login = NULL,
   @s_sesn         int = NULL,
   @s_term         varchar(30) = NULL,
   @s_date         datetime = NULL,
   @s_srv          varchar(30) = NULL,
   @s_lsrv         varchar(30) = NULL, 
   @s_rol          smallint = NULL,
   @s_ofi          smallint = NULL,
   @s_org_err      char(1) = NULL,
   @s_error        int = NULL,
   @s_sev          tinyint = NULL,
   @s_msg          descripcion = NULL,
   @s_org          char(1) = NULL,
   @t_debug        char(1) = 'N',
   @t_file         varchar(14) = null,
   @t_from         varchar(32) = null,
   @t_trn          smallint = null,
   @i_tipo         char(1) = null,
   @i_modo         smallint = null,
   @i_causal       char(10) = null,
   @i_descripcion  varchar(64) = null,
   @i_valor        varchar(30) = '%',
   @i_tabla        varchar(30) = null
)
as
declare
	@w_sp_name		varchar(32),
	@w_tldc			tinyint			--ADU: 2001-11-28

select @w_sp_name = 'sp_caubusq'


If @t_trn = 741
begin
   if @i_tipo = '1'
   begin
        set rowcount 20
        if @i_modo = 0
        begin
        
           select 
           'COD. CAUSAL' = b.codigo,
           'DESCRIPCION' = b.valor  
           from cobis..cl_tabla a, 
                cobis..cl_catalogo b 
           where a.tabla = @i_tabla 
           and b.tabla   = a.codigo 
           and convert(varchar,b.codigo) like @i_valor 
           and b.estado  = 'V'
           order by b.codigo asc
           if @@rowcount=0
           Begin
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101000
              set rowcount 0
              return 1
           End
           
          set rowcount 0
        end
   
        if @i_modo = 1
        begin
        
           select 
           'COD. CAUSAL' = b.codigo,
           'DESCRIPCION' = b.valor  
           from cobis..cl_tabla a, 
                cobis..cl_catalogo b 
           where a.tabla = @i_tabla 
           and b.tabla   = a.codigo 
           and convert(varchar,b.codigo) like @i_valor
           and b.codigo > @i_causal 
           and b.estado  = 'V'
           order by b.codigo asc
           if @@rowcount=0
           begin
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101000
              set rowcount 0
              return 1
           end     
           
          set rowcount 0
        end
    return 0
   end 
   
   
   if @i_tipo = '2'
   begin
        set rowcount 20
        if @i_modo = 0
        begin
        
           select 
           'COD. CAUSAL' = b.codigo,
           'DESCRIPCION' = b.valor  
           from cobis..cl_tabla a, 
                cobis..cl_catalogo b 
           where a.tabla = @i_tabla 
           and b.tabla   = a.codigo 
           and convert(varchar,b.valor) like @i_valor
           and b.estado  = 'V'
           order by b.valor asc
           if @@rowcount=0
           Begin
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101000
              set rowcount 0
              return 1
           End
   
          set rowcount 0
        end
   
   
        if @i_modo = 1
        begin
        
           select 
           'COD. CAUSAL' = b.codigo,
           'DESCRIPCION' = b.valor  
           from cobis..cl_tabla a, 
                cobis..cl_catalogo b 
           where a.tabla = @i_tabla 
           and b.tabla   = a.codigo 
           and convert(varchar,b.valor) like @i_valor
           and b.valor > @i_descripcion
           and b.estado  = 'V'
           order by b.valor asc
           if @@rowcount=0
           Begin
              exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101000
              set rowcount 0
              return 1
           End
           
          set rowcount 0
        end
    return 0
   end
   
   if @i_tipo = '3'
   begin
   
      select 
      b.codigo
      from cobis..cl_tabla a, 
           cobis..cl_catalogo b 
      where a.tabla = @i_tabla 
      and b.tabla   = a.codigo 
      and b.codigo  = @i_valor
      and b.estado  = 'V'
      order by b.codigo
      if @@rowcount=0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 101000
      end
      
   end 
else
begin
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 151051
   /*  'No corresponde codigo de transaccion' */
return 1
end
end


GO


