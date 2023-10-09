use cob_conta_super
go
if object_id ('dbo.fn_formatea_texto') is not null
    drop function fn_formatea_texto
go
create function fn_formatea_texto(  @w_tamanio          int,
                                    @w_valor_string     varchar(255),
                                    @w_valor_int        int,
                                    @w_isright          char(1),
                                    @w_esfija           char(1),
				    @w_conlen           char(1))
returns varchar(255)
begin
    declare @w_cadena    varchar(255),
            @w_tamanio_s varchar(5),
            @w_str_rtrn varchar(255),
            @w_cant_cero int
select @w_cant_cero = 2

    if(@w_valor_string is not null)
    begin
        select @w_cadena    =   upper(@w_valor_string)
    end

    if(@w_valor_int is not null)
    begin
        select @w_cadena    =   convert(varchar(10),@w_valor_int)
    end

    if(@w_cadena is null)
    begin
        select @w_cadena=''
    end


    if(@w_esfija = 'S')
    begin
	
        select @w_tamanio_s = right(replicate('0',@w_cant_cero) + convert(varchar,@w_tamanio),@w_cant_cero)

        if(@w_isright = 'S')
        begin
            select @w_str_rtrn = @w_tamanio_s + @w_cadena + space(@w_tamanio - len(@w_cadena))
        end
        else
        begin
            select @w_str_rtrn = @w_tamanio_s + space(@w_tamanio - len(@w_cadena)) + @w_cadena
        end
    end
    else
    begin
        select @w_tamanio_s = right(replicate('0',@w_cant_cero) + convert(varchar,len(@w_cadena)),@w_cant_cero)
        select @w_str_rtrn = @w_tamanio_s + @w_cadena
    end

    if(@w_conlen = 'N')
    begin
	return substring(@w_str_rtrn,@w_cant_cero + 1,len(@w_str_rtrn))
    end

    return @w_str_rtrn
end
go


-- -------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------------------------------------------------
if object_id ('dbo.fn_formatea_ascii_ext') is not null
    drop function fn_formatea_ascii_ext
go
create function fn_formatea_ascii_ext(
   @w_valor_str varchar(255),
   @w_tipo char(2)
)
returns varchar(255)
begin
declare
   @w_cadena   varchar(255),
   @w_cad_ant  varchar(255),
   @w_cont     int

   if @w_valor_str is not null
   begin
      select @w_cont = 1, @w_cadena = ltrim(rtrim(@w_valor_str))
   end

   while len(@w_cadena) >= @w_cont
   begin
      select @w_cad_ant = @w_cadena
      if exists(select eq_valor_cat
                  from cob_conta_super..sb_equivalencias
                 where eq_catalogo  = 'CHAR_ASCII' 
                   and eq_valor_cat = substring(@w_cadena,@w_cont,1)
                   and eq_estado    = 'V')
      begin
         select @w_cadena = replace(@w_cadena, eq_valor_cat, (case @w_tipo when 'A' then eq_valor_arch when 'AN' then eq_descripcion end))
           from cob_conta_super..sb_equivalencias 
          where eq_catalogo = 'CHAR_ASCII' 
            and eq_valor_cat = substring(@w_cadena,@w_cont,1)
            and eq_estado = 'V'
      end
      else
      begin
         select @w_cadena = replace(@w_cadena,substring(@w_cadena,@w_cont,1),'')
      end
      if len(@w_cad_ant) = len(@w_cadena)
      begin
         select @w_cont = @w_cont + 1
      end
   end

   return @w_cadena
end
go

