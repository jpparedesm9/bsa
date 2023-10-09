/************************************************************************/
/*  Archivo:            cenumlet.sp                                     */
/*  Stored procedure:   sp_conv_numero_letras                           */
/*  Base de datos:      cob_credito                                      */
/*  Producto:           Comercio Exterior                               */
/*  Disenado por:       Fabian Espinosa                                 */
/*  Fecha de escritura:     14-07-1994                                  */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programas transforma a letras un cantidad pasada como          */
/*  parametro.                                                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR              RAZON                            */
/*  14-07-1994      F.Espinosa         Emision inicial                  */
/*  10-Sep-1996     R.Martinez Abril   Actualizacion para no            */
/*                                     manejar tablas.                  */
/*  16-Oct-1996     R.Martinez Abril   Actualizacion i_opcion           */
/*  31-Jul-1997     Jaime Portugal A.  Plural de la moneda              */
/*  19-Mar-2018     Adriana Chiluisa.  Se toma fuentes de FIE, para     */
/*                                     incidencia 93608, se cambia la   */ 
/*                                     base de cob_comext a cob_credito */
/************************************************************************/
use cob_credito
go

IF OBJECT_ID ('dbo.sp_conv_numero_letras') IS NOT NULL
	DROP PROCEDURE dbo.sp_conv_numero_letras
GO

create proc sp_conv_numero_letras ( 
        @t_trn              smallint = null,
        @t_debug            char(1) = 'N',
        @t_file             varchar(14) = null,
        @t_from             varchar(30) = null,
        @i_dinero           money,
        @i_moneda           tinyint = null,
        -- @i_mdesc         char(1) = 'S', /* S - Incluir Descripcion de la moneda */
        @i_opcion           tinyint = 0, /* 0 con descr. moneda */
                            /* 1 sin unidades */
                            /* 2 con descr. dias */
        @o_letras           varchar(255) out
) as
declare     
        @w_sp_name          varchar(30),
        @centavos           varchar(6), 
        @entero             varchar(30), 
        @indice             tinyint,
        @txt                varchar(250), 
        @valor              varchar(30), 
        @w_nconv            varchar(30), 
        @length             tinyint,
        @ceros              tinyint, 
        @w_pos              tinyint, 
        @tmp                varchar(30), 
        @numero             tinyint, 
        @unidad             varchar(30),
        @w_desc_unidades    descripcion,
        @w_unidades         varchar(255),
        @w_unidades1        varchar(255),
        @w_decenas          varchar(255),
        @w_centenas         varchar(255)

  /*  Captura nombre del Stored Procedure  */
  select @w_sp_name = 'sp_conv_numero_letras'


/*** Inicializar unidades, decenas, centenas ***/

select @w_unidades = '@0@1UN@2DOS@3TRES@4CUATRO@5CINCO@6SEIS@7SIETE@8OCHO'
select @w_unidades = @w_unidades + '@9NUEVE@10DIEZ@11ONCE@12DOCE@13TRECE' 
select @w_unidades = @w_unidades + '@14CATORCE@15QUINCE@16DIECISEIS@17DIECISIETE'
select @w_unidades = @w_unidades + '@18DIECIOCHO@19DIECINUEVE@'


select @w_unidades1 = @w_unidades1 + '@20VEINTE@21VEINTIUNO@22VEINTIDOS@23VEINTITRES'
select @w_unidades1 = @w_unidades1 + '@24VEINTICUATRO@25VEINTICINCO@26VEINTISEIS'
select @w_unidades1 = @w_unidades1 + '@27VEINTISIETE@28VEINTIOCHO@29VEINTINUEVE@'


select @w_decenas = '@1DIEZ@2VEINTE@3TREINTA@4CUARENTA@5CINCUENTA'
select @w_decenas = @w_decenas + '@6SESENTA@7SETENTA@8OCHENTA@9NOVENTA@'

select @w_centenas = '@1CIENTO@2DOSCIENTOS@3TRESCIENTOS@4CUATROCIENTOS'
select @w_centenas = @w_centenas + '@5QUINIENTOS@6SEISCIENTOS@7SETECIENTOS'
select @w_centenas = @w_centenas + '@8OCHOCIENTOS@9NOVECIENTOS@'

/*  Transforma la cantidad en letras  */
select @valor = convert(varchar, @i_dinero)
select @indice = charindex('.', @valor) + 1

select @centavos = substring(@valor, @indice, datalength(@valor)-@indice+1)
select @entero = substring(@valor, 1, @indice - 2)
select @length = datalength(@entero)
select @indice = 1
select @txt = ''
while ( @indice <= @length )
begin
    
        select @numero = convert(tinyint, substring(@entero, @indice, 1))
        select @ceros = @length - @indice

        if ( @ceros + 1 in (15, 14, 13) )
        begin
            if (@ceros+1) = 13 and @numero = 1  
                select @unidad = ' BILLON'
            else
                select @unidad = ' BILLONES'
        end
        else
            if ( @ceros + 1 in (18,17,16,12,11,10,6,5,4) ) 
            select @unidad = ' MIL'
            else
                if ( @ceros + 1 in (9, 8, 7) )
                begin
                    if (@ceros+1) = @length and (@ceros+1) = 7 and @numero = 1
                        select @unidad = ' MILLON'
                    else
                        select @unidad = ' MILLONES'
                end
                else
                    if ( @ceros + 1 in (3, 2, 1) )
                    begin
                        if (@ceros+1) = 1 and @numero = 1
                            select @unidad = ' UNO'
                        else
                            select @unidad = ''
                    end
    if @numero <> 0
        begin
            if ( @ceros in (17, 14, 11, 8, 5, 2) )
            begin
                /*** TRANSFORMAR A LETRAS LAS CENTENAS ***/
                select @w_pos= charindex(('@'+convert(varchar,@numero)),@w_centenas)
                     + datalength(@numero)

                --DGO if @w_pos > 0 select @w_nconv = stuff(@w_centenas,1,@w_pos,null)
                if @w_pos > 0 
                    select @w_nconv = substring(@w_centenas,@w_pos+1,
                                          len(@w_centenas))
                select @w_pos = charindex('@',@w_nconv) - 1
                if @w_pos > 0 
                select @w_nconv = substring(@w_nconv,1,@w_pos)

                if @numero = 1 and substring(@entero,@indice+1,2) = '00'
                begin
                        select @w_pos = charindex('TO',@w_nconv)
                        --select @w_nconv = stuff(@w_nconv,@w_pos,@w_pos+1,null)
                        select @w_nconv = substring(@w_nconv,1,@w_pos-1) +
                                                  substring(@w_nconv,@w_pos+2,
                                              len(@w_nconv))
                end

	            if substring(@entero,@indice+1,2) <> '00'
	                        select @unidad = ''
	
	            if @ceros in (8) and substring(@entero,@indice+1,2) = '00'
	                        select @unidad = ''
	
	                select @tmp = @w_nconv
            end

            if ( @ceros in (16, 13, 10, 7, 4, 1) )
            begin
            -- print '@w_decenas %1! @numero %2!', @w_decenas, @numero
                if ( @numero in (0, 1,2) )
                begin
                -- print '@w_decenas %1! @numero %2!', @w_decenas, @numero

                select @numero = convert(tinyint, substring(@entero, @indice, 2))

                    /*** TRANSFORMAR A LETRAS LAS UNIDADES ***/
                -- print '@numero %1!', @numero
                
                if @numero >= 20 and @numero <= 29
                begin

                        select @w_pos = charindex(('@'+convert(varchar(2),@numero)),@w_unidades1)
                                  + datalength(@numero)+1 


                        if @w_pos > 0 
                                --select @w_nconv = stuff(@w_unidades1,1,@w_pos,null)
                                select @w_nconv = substring(@w_unidades1,@w_pos+1,
                                                   len(@w_unidades1))

                        select @w_pos = charindex('@',@w_nconv) - 1
                        if @w_pos > 0 
                        select @w_nconv = substring(@w_nconv,1,@w_pos)
                        select @tmp = @w_nconv 
                    select @indice = @indice + 1
                end
                else
                begin
                        select @w_pos = charindex(('@'+convert(varchar(2),@numero)),@w_unidades)
                                  + datalength(@numero)+1 
                        if @w_pos > 0 
                                --select @w_nconv = stuff(@w_unidades,1,@w_pos,null)
                                select @w_nconv = substring(@w_unidades,@w_pos+1,
                                                   len(@w_unidades))

                        select @w_pos = charindex('@',@w_nconv) - 1
                        if @w_pos > 0 
                        select @w_nconv = substring(@w_nconv,1,@w_pos)
                        select @tmp = @w_nconv 
                    select @indice = @indice + 1

                end
            end
                else
                begin
                    /*** TRANSFORMAR A LETRAS LAS DECENAS ***/

                    select @w_pos= charindex(('@'+convert(varchar(2),@numero)),@w_decenas)
                         + datalength(@numero)
                    --DGO if @w_pos > 0 select @w_nconv = stuff(@w_decenas,1,@w_pos,null)
                    if @w_pos > 0 
                            select @w_nconv = substring(@w_decenas,@w_pos+1,
                                              len(@w_decenas))
                    select @w_pos = charindex('@',@w_nconv) - 1
                    if @w_pos > 0 
      select @w_nconv = substring(@w_nconv,1,@w_pos)

                    select @tmp = @w_nconv

                if ( substring(@entero, @indice + 1, 1) <> '0' )
                        select @tmp = @tmp + ' Y',
                               @unidad = ''

                    if @ceros in (8,7) and substring(@entero,@indice,1) <> '1'
                            select @unidad = ''
                   print '@w_nconv ' + @w_nconv

            END
            
            END
            
            if ( @ceros in (18,15,12,9, 6,3,0) )
            begin
                /*** TRANSFORMAR A LETRAS LAS UNIDADES ***/
                select @w_pos= charindex(('@'+convert(varchar,@numero)),@w_unidades)
                     + datalength(@numero)
                --DGO if @w_pos > 0 select @w_nconv = stuff(@w_unidades,1,@w_pos,null)
                if @w_pos > 0 
                    select @w_nconv = substring(@w_unidades,@w_pos+1, 
                                          len(@w_unidades))
                select @w_pos = charindex('@',@w_nconv) - 1
                if @w_pos > 0 
                select @w_nconv = substring(@w_nconv,1,@w_pos)
                if @ceros = 0 and @numero = 1
                    select @w_nconv = null 
            /* consideracion para el caso de que el numero sea 1.000 */
            /*if @ceros = 3 and @numero = 1
                select @tmp = ''
            else*/
                select @tmp = @w_nconv

            end
            select @tmp = @tmp + @unidad
        end
    else
            if @ceros in (6)
                select @tmp = @tmp + @unidad

        if @tmp IS NOT null 
           select @txt = @txt + ' ' + rtrim(ltrim(@tmp))

        select @tmp = '',
               @unidad = ''
        select @indice = @indice + 1
end

if @i_opcion = 0
  begin

    /*  Determina Moneda  */
    select  @w_desc_unidades = mo_descripcion
      from  cobis..cl_moneda
     where  mo_moneda = @i_moneda
     if @@rowcount <> 1
     begin
      /*  Codigo de Moneda no Existe  */
      exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file   = @t_file,
          @t_from   = @w_sp_name,
          @i_num    = 701069
      return 1
     end



     if (select(substring(ltrim(rtrim(@w_desc_unidades)),
    len(ltrim(rtrim(@w_desc_unidades))), 1)))
    in ('A','E','I','O','U')
    select @w_desc_unidades = (@w_desc_unidades + 'S')
     else
    if (select(substring(ltrim(rtrim(@w_desc_unidades)),
        len(ltrim(rtrim(@w_desc_unidades)))-1, 2)))
        in ('AS','ES','IS','OS','US')
       select @w_desc_unidades = @w_desc_unidades
    else
       select @w_desc_unidades = (@w_desc_unidades + 'ES')

    select  @w_desc_unidades = ' ' + @centavos + '/100 ' + 
            rtrim(@w_desc_unidades)
  end
else
if @i_opcion = 1
  begin
    -- select @w_desc_unidades = ''
    select  @w_desc_unidades = ' ' + @centavos + '/100 ' 

  end
else
if @i_opcion = 2
  begin
    select @w_desc_unidades = ' DIAS'
  end

if @i_opcion = 3
  begin
    select @w_desc_unidades = ' '
  end
else

if @i_opcion = 4
  begin

    /*  Determina Moneda  */
    select  @w_desc_unidades = mo_descripcion
      from  cobis..cl_moneda
     where  mo_moneda = @i_moneda
     if @@rowcount <> 1
     begin
      /*  Codigo de Moneda no Existe  */
      exec cobis..sp_cerror
          @t_debug= @t_debug,
          @t_file   = @t_file,
          @t_from   = @w_sp_name,
          @i_num    = 701069
      return 1
     end

     if (select(substring(ltrim(rtrim(@w_desc_unidades)),
    len(ltrim(rtrim(@w_desc_unidades))), 1)))
    in ('A','E','I','O','U')
    select @w_desc_unidades = (@w_desc_unidades + 'S')
     else
    if (select(substring(ltrim(rtrim(@w_desc_unidades)),
        len(ltrim(rtrim(@w_desc_unidades)))-1, 2)))
        in ('AS','ES','IS','OS','US')
       select @w_desc_unidades = @w_desc_unidades
    else
       select @w_desc_unidades = (@w_desc_unidades + 'ES')

    select  @w_desc_unidades = ' ' + 
            rtrim(@w_desc_unidades) + ' '+ @centavos + '/100 ' 
  end
  
  select  @o_letras = ltrim(@txt) + @w_desc_unidades
  select  @o_letras =  UPPER(LEFT(@o_letras, 1)) + LOWER(SUBSTRING(@o_letras, 2, LEN(@o_letras)))

GO

