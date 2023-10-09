/************************************************************************/
/*    Archivo:              codpostal.sp                                */
/*    Stored procedure:     sp_codigo_postal                            */
/*    Base de datos:        cobis                                       */
/*    Producto:             Clientes                                    */
/*    Disenado por:         Maria Jose Taco                             */
/*    Fecha de escritura:   14/Jun/2017                                 */
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
/*      Dado un codigo postal recuperar los codigos de los catalogos    */
/*      de municipio, estados y colonias                                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA        AUTOR           RAZON                                */
/*    14/Jun/17    Ma. Jose Taco   Emision Inicial                      */

/************************************************************************/
use cobis
go

if exists (select 1 from   sysobjects where  name = 'sp_codigo_postal')
  drop proc sp_codigo_postal
go

create proc sp_codigo_postal
(
  @s_ssn          int          = null,
  @t_debug        char (1)     = 'N',
  @t_file         varchar (14) = null,
  @t_trn          smallint     = null,
  @t_show_version bit          = 0,
  @i_codpostal    varchar(10)  = null,
  @i_operacion    char(1)      = NULL,
  @i_colonia      INT		   = null,
  @o_estado       int          = 0 out,
  @o_municipio    int          = 0 out,
  @o_colonia      int          = 0 out
)
as
declare
@w_sp_name         varchar(30),
@w_estado          int,
@w_municipio       int,
@w_colonia         int,
@w_pais            INT,
@w_codigo_postal   INT
    

  --Captura nombre de Stored Procedure
  select @w_sp_name = 'sp_codigo_postal'

  ---- VERSIONAMIENTO DEL PROGRAMA ---
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  
  select @w_pais = pa_smallint
    from cobis..cl_parametro
   where pa_nemonico= 'CP'
     and pa_producto = 'ADM'

  if (@i_operacion = 'S')
  begin
     set rowcount 1
     select @w_estado    = cp_estado,
            @w_municipio = cp_municipio,
            @w_colonia   = cp_colonia
       from cl_codigo_postal
      where cp_codigo = @i_codpostal
        and cp_pais   = @w_pais
     
     if(@@rowcount = 0)
     begin
        exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103117 --NO EXISTE DATO SOLICITADO
        return 1
     end
	 
	 --Req 119772, se agrega outputs para alta masiva de clientes
	 select 
	 @o_estado    = @w_estado,
	 @o_municipio = @w_municipio,
	 @o_colonia   = @w_colonia
	 
	 
     select 'Estado'    = @w_estado,   
            'Municipio' = @w_municipio,
            'Colonia'   = @w_colonia
            
   end
  
   if (@i_operacion = 'Q')
  begin
     set rowcount 1
     select @w_codigo_postal    = cp_codigo
       from cl_codigo_postal
      where cp_colonia = @i_colonia
     
     if(@@rowcount = 0)
     begin
        exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103117 --NO EXISTE DATO SOLICITADO
        return 1
     end
     select 'CodigoPostal'    = @w_codigo_postal
            
   end
    
  return 0
  
go