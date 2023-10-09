use cobis
go
/* **********************************************************************/
/*      Archivo           : sp_generar_curp.sp                          */
/*      Stored procedure  : sp_generar_curp                             */
/*      Base de datos     : cobis                                       */
/*      Producto          : Clientes                                    */
/*      Disenado por      : LGU                                         */
/*      Fecha de escritura: 14-Jun-2017                                 */
/* **********************************************************************/
/*                          IMPORTANTE                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Permite calcular el CURP y RFC (mexico)                             */
/* **********************************************************************/
/*                             MODIFICACIONES                           */
/*      FECHA       AUTOR                RAZON                          */
/*   14/Jun/2017    LGU     Emision inicial                             */
/*   30/Nov/2018    MTA     Correcion de nombre                         */
/*   04/Abr/2018    ACH     Corec. Seccion2Apellidos                    */
/*   09/Dic/2019    SRO     Modificaciones Colectivos                   */
/*   20/Ene/2020    ACH     Se añade parametro por caso #133126 en      */
/*                          fn_filtra_acentos                           */
/*   12/May/2023    KVI     Version productiva                          */
/*   27/Jun/2023    ACH     #210163 Error en CURP-no debemos generar    */
/************************************************************************/

if exists (select 1 from sysobjects where name = 'sp_generar_curp')
   drop proc sp_generar_curp
go

create proc sp_generar_curp(
    @t_debug                char(1)     = 'N',
    @t_file                 varchar(10) = null,
    @t_from                 varchar(32) = null,
    @i_primer_apellido      varchar(100),
    @i_segundo_apellido     varchar(100),
    @i_nombres              varchar(100),
    @i_sexo                 varchar(10),
    @i_fecha_nacimiento     datetime,
    @i_entidad_nacimiento   int,
    @i_ente                 int = 0,
    @o_mensaje              varchar(100) = null output,
    @o_curp                 varchar(30) = null output,
    @o_rfc                  varchar(30) = null output)
as
declare
    @w_sp_name          varchar(30),
    @w_alfa             varchar(30),
    @w_curp             varchar(30),
	@w_curp_rfc         varchar(30),
    @w_pos              smallint,
    @i_nombres_aux      varchar(100),
    @w_apellido_aux     varchar(100),
    @w_entidad_aux      varchar(10),
    @w_p_apellido_aux   varchar(100),
    @w_s_apellido_aux   varchar(100),
    @w_anio             char,
    @w_fecha_nac        varchar(10),
	@w_primer_apellido_aux      varchar(100)

    select @w_sp_name = 'cobis..sp_generar_curp'

    -- caracteres alfabeticos permitidos
   select @w_alfa = '%[^A-ZÑ0-9]%'

   select
        @i_primer_apellido     = replace(replace(replace(replace(@i_primer_apellido, 'Ñ', 'X'), '-', ''), '_', ''), '.', ''),
        @i_segundo_apellido    = replace(replace(replace(replace(@i_segundo_apellido, 'Ñ', 'X'), '-', ''), '_', ''), '.', ''),
        @i_nombres             = replace(replace(replace(replace(@i_nombres, 'Ñ', 'X'), '-', ''), '_', ''), '.', '')
		
   select
        @i_primer_apellido  = upper(rtrim(ltrim( isnull(@i_primer_apellido,'') ))),
        @i_segundo_apellido = upper(rtrim(ltrim( isnull(@i_segundo_apellido,'') ))),
        @i_nombres          = upper(rtrim(ltrim( isnull(@i_nombres,'')))),
        @i_sexo             = upper(rtrim(ltrim( @i_sexo)))

    select
        @i_primer_apellido     = cobis.dbo.fn_filtra_acentos(@i_primer_apellido ),
        @i_segundo_apellido    = cobis.dbo.fn_filtra_acentos(@i_segundo_apellido ),
        @i_nombres             = cobis.dbo.fn_filtra_acentos(@i_nombres )

    if @i_sexo = 'M' select @i_sexo = 'H' else select @i_sexo = 'M'

--/////////////////////////////////////
   select
        @w_p_apellido_aux  = @i_primer_apellido,
        @w_s_apellido_aux  = @i_segundo_apellido,
        @i_nombres_aux     = @i_nombres
		
   
    select @i_nombres          = cobis.dbo.fn_filtra_nombres(@i_nombres,'S')
	select @w_primer_apellido_aux  = cobis.dbo.fn_filtra_nombres(@i_primer_apellido,'N')
    select @i_primer_apellido  = cobis.dbo.fn_filtra_nombres(@i_primer_apellido,'S')
    select @i_segundo_apellido = cobis.dbo.fn_filtra_nombres(@i_segundo_apellido,'N')
	
	
    --// validar que los datos estan correctors
    if  @i_primer_apellido = ''
    begin
        select @o_mensaje = 'Primer apellido es obligatorio'
        return 1
    end
    if @i_primer_apellido like @w_alfa
    begin
        select @o_mensaje = 'Primer apellido no valido, caracteres validos: A-Z (incluso Ñ)'
        return 2
    END

    if @i_segundo_apellido <> '' and @i_segundo_apellido like @w_alfa
    begin
        select @o_mensaje = 'Segundo apellido no valido, caracteres validos: A-Z (incluso Ñ)'
        return 4
    end
    if @i_nombres = ''
    begin
        select @o_mensaje = 'Nombre(s) es obligatorio'
        return 5
    end
    if @i_nombres like @w_alfa
    begin
        select @o_mensaje = 'Nombre(s) no valido, caracteres validos: A-Z (incluso Ñ)'
        return 6
    end

    if @i_sexo not in ('H', 'M')
    begin
        select @o_mensaje = 'Sexo no valido'
        return 7
    end

    if @i_fecha_nacimiento is null
    begin
        select @o_mensaje = 'Fecha de nacimiento no valido'
        return 8
    end

    if @i_entidad_nacimiento = 0
    begin
        select @o_mensaje = 'Entidad de nacimiento es obligatorio'
        return 9
    end


    select  @w_entidad_aux = e2.eq_valor_arch
    from cob_conta_super..sb_equivalencias e1, cob_conta_super..sb_equivalencias e2
    where e1.eq_catalogo = 'ENT_FED'
    and e1.eq_valor_cat = convert(varchar, @i_entidad_nacimiento)
    and e2.eq_catalogo = 'ENT_CURP'
    and e2.eq_valor_cat = e1.eq_valor_arch

    select @w_entidad_aux = isnull(@w_entidad_aux ,'')
    if @w_entidad_aux = ''
    begin
        select @o_mensaje = 'No existe Entidad de nacimiento'
        return 10
    end

 --/////////////////////////////////////
    select @w_fecha_nac = substring(convert(varchar,@i_fecha_nacimiento,101),9,2) + -- anio
                          substring(convert(varchar,@i_fecha_nacimiento,101),1,2) + -- mes
                          substring(convert(varchar,@i_fecha_nacimiento,101),4,2)   -- dia

    --/////////////////////////////////////////////////////
    --calclular RFC
    /*
    if len(@i_primer_apellido) > 0 and len(@i_segundo_apellido) > 0
    begin
        if len(@i_primer_apellido) < 3
        begin
            select @o_rfc = substring(@i_primer_apellido,1, 1) +
                            substring(@i_segundo_apellido,1, 1)+
                            substring(@i_nombres,1, 2)+
                            @w_fecha_nac
                            
            select @w_apellido_aux = @i_segundo_apellido
        end
        else
        begin
            select @o_rfc = substring(@i_primer_apellido,1, 1) +
                            cobis.dbo.fn_primera_letra(substring(@i_primer_apellido,2,100),'V'  ) + -- primera vocal
                            substring(@i_segundo_apellido,1, 1)+
                            substring(@i_nombres,1, 1)+
                            @w_fecha_nac
                            
            select @w_apellido_aux = @i_segundo_apellido
        end
    end
    else
        if len(@i_primer_apellido) = 0 or len(@i_segundo_apellido) = 0
        begin
            if len(@i_primer_apellido) > 0 and len(@i_segundo_apellido) = 0
            	select @w_apellido_aux = substring(@i_primer_apellido,1, 2)
            else
            	if len(@i_primer_apellido) = 0 and len(@i_segundo_apellido) > 0
            		select @w_apellido_aux = substring(@i_segundo_apellido,1, 2)
            	else
		            select @w_apellido_aux = substring(@i_nombres,1, 2)

            select @o_rfc = @w_apellido_aux +
                            substring(@i_nombres,1, 2)+
                            @w_fecha_nac
        end
     */
		

	/*If Len(@i_segundo_apellido) = 0 
	    SELECT @o_rfc = SUBSTRING(@i_primer_apellido, 1,2) + SUBSTRING(@i_nombres, 1,2)
	ELSE
	If Len(@i_primer_apellido) < 3 
	    SELECT @o_rfc = substring(@i_primer_apellido, 1,1) +  substring(@i_segundo_apellido, 1,1) + substring(@i_nombres, 1,2)
	Else
	    SELECT @o_rfc = substring(@i_primer_apellido, 1,1) +
	    				cobis.dbo.fn_primera_letra(substring(@i_primer_apellido,2,100),'V'  ) + -- primera vocal
					    substring(@i_segundo_apellido, 1,1) + substring(@i_nombres, 1,1)
    SELECT @o_rfc = cobis.dbo.fn_altisonante('RFC',@o_rfc)
    
    SELECT @o_rfc = @o_rfc + @w_fecha_nac*/

    -- generar el CURP
    --/////////////////////////////////////////////////////
    --select @w_curp = substring(@i_primer_apellido,1,1) +                                       -- 1ra letra apellido 1
	--				 cobis.dbo.fn_primera_letra( substring(@i_primer_apellido   ,2,100),'V')   -- 1ra vocal apellido 1
	--				 
	--if len(@i_segundo_apellido) <= 0
	--	select @w_curp = @w_curp + 'X'
	--else
	--	select @w_curp = @w_curp + substring(@i_segundo_apellido,1,1)  -- 1ra letra apellido 2
    --
	--select @w_curp = @w_curp + substring(@i_nombres,1,1)  -- 1ra letra del nombre

	--INICIA PARA CURP Y RFC
    select @w_curp_rfc = substring(@i_primer_apellido,1,1) +                                   -- 1ra letra apellido 1
					     cobis.dbo.fn_primera_letra( substring(@i_primer_apellido   ,2,100),'V')   -- 1ra vocal apellido 1					 
	if len(@i_segundo_apellido) <= 0
		select @w_curp_rfc = @w_curp_rfc + 'X'
	else
		select @w_curp_rfc = @w_curp_rfc + substring(@i_segundo_apellido,1,1)  -- 1ra letra apellido 2
    
	select @w_curp_rfc = @w_curp_rfc + substring(@i_nombres,1,1)  -- 1ra letra del nombre
	SELECT @w_curp_rfc = @w_curp_rfc + @w_fecha_nac
	select @w_curp_rfc = cobis.dbo.fn_altisonante('CURP',@w_curp_rfc) --Cambia palabras por otras
	--FIN PARA CURP Y RFC
	
	--INICIA RFC
	select @o_rfc = @w_curp_rfc + cobis.dbo.fn_homoclave_rfc (@i_nombres_aux, @w_p_apellido_aux, @w_s_apellido_aux)
	select @o_rfc = @o_rfc + cobis.dbo.fn_digito_rfc (@o_rfc)
	--FIN RFC
	
	--INICIA CURP
    select @w_curp = @w_curp_rfc + @i_sexo
    select @w_curp = @w_curp + @w_entidad_aux
    
    select @w_curp = @w_curp + cobis.dbo.fn_primera_letra( substring(@w_primer_apellido_aux,2,100),'C')  -- segunda consonante

	if len(@i_segundo_apellido) <= 0
		select @w_curp = @w_curp + 'X'
	else
	    select @w_curp = @w_curp + cobis.dbo.fn_primera_letra( substring(@i_segundo_apellido   ,2,100),'C')     -- primera consonante

    select @w_curp = @w_curp + cobis.dbo.fn_primera_letra( substring(@i_nombres        ,2,100),'C')          -- primera consonante

    if convert(int,substring(convert(varchar,@i_fecha_nacimiento,101),7,4)) < 2000 select @w_anio = '0' else select @w_anio = 'A'

    select @w_curp = @w_curp + @w_anio
    select @o_curp = @w_curp + cobis.dbo.fn_digito_curp (@w_curp)

    -- solo en caso de que no haya generado 18 caracteres, para identificar como error
    select @o_curp = replicate('X',18-len(@o_curp)) + @o_curp
    --FIN CURP


    --print ' ----> CURP: ' + @o_curp + '   RFC: ' + @o_rfc
    if (@i_ente = 0 or @i_ente is null ) begin 
        if exists(select 1 from cobis..cl_ente where en_rfc = @o_rfc)
        begin
           /*--Ya existe una persona con esta Identificacion. RFC*/
           return 70011008
        end
	end else begin
        if exists(select 1 from cobis..cl_ente where en_rfc = @o_rfc and en_ente != @i_ente)
        begin
           /*--Ya existe una persona con esta Identificacion. RFC*/
           return 70011008
        end
		
	end
	--Ya no valida, porque este campo debe ser de ingreso y no de cAlculo
	--if exists(select 1 from cobis..cl_ente where en_ced_ruc = @o_curp)
	--begin
	--   /*--Ya existe una persona con esta Identificacion. CURP*/
	--   return 70011007
	--end
	
    return 0

GO


