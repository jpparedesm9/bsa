/***********************************************************************/

/* rtryinit: Guardar parametro de procedimiento en el REENTRY          */

/* PTO: 98/10/14: Emision inicial                                      */

/* Procedure: sp_reentry_param                                         */

/***********************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_reentry_param')
    drop proc sp_reentry_param
go

create proc sp_reentry_param
(
    @i_server           varchar(32),
    @i_num              int,
    @i_nomparam         varchar(30),
    @i_tipo_io          tinyint = null,
    @i_tipodato         varchar(30) = null,
    @i_header           tinyint = null,
    @i_v_char           varchar(255) = null,
    @i_v_varchar        varchar(255) = null,
    @i_v_int            int = null,
    @i_v_smallint       smallint = null,
    @i_v_tinyint        tinyint = null,
    @i_v_money          money = null,
    @i_v_datetime       datetime = null,
    @i_v_float          float = null,
    @i_v_real           real = null,
    @i_v_smalldatetime  smalldatetime = null,
    @i_v_smallmoney     smallmoney = null
)
as
declare @w_sp_name  varchar(30),
        @w_tipodato tinyint,
        @w_largo    tinyint
                
/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_reentry_param'

if @i_tipo_io is null
    select @i_tipo_io = case substring(@i_nomparam,2,1)
        when 'o' then 1
        else 0
    end
else if @i_tipo_io not in (0,1)
    select @i_tipo_io = 0

if @i_tipodato is null
    /* No se puede enviar nulos */
    select @w_tipodato = case
        when @i_v_char is not null          then 47
        when @i_v_varchar is not null       then 39
        when @i_v_int is not null           then 56
        when @i_v_smallint is not null      then 52
        when @i_v_tinyint is not null       then 48
        when @i_v_money is not null         then 60
        when @i_v_datetime is not null      then 61
        when @i_v_float is not null         then 62
        when @i_v_real is not null          then 59
        when @i_v_smalldatetime is not null then 58
        when @i_v_smallmoney is not null    then 122
        else 0
    end
else 
    select @w_tipodato = case @i_tipodato
        when 'char'          then 47
        when 'varchar'       then 39
        when 'int'           then 56
        when 'smallint'      then 52
        when 'tinyint'       then 48
        when 'money'         then 60
        when 'datetime'      then 61
        when 'float'         then 62
        when 'real'          then 59
        when 'smalldatetime' then 58
        when 'small money'   then 122        
       
        when '34'  then 34
        when '35'  then 35
        when '36'  then 36
        when '37'  then 37
        when '38'  then 38
        when '45'  then 45
        when '49'  then 49
        when '50'  then 50
        when '51'  then 51
        when '55'  then 55
        when '63'  then 63
        when '106' then 106
        when '108' then 108
        when '109' then 109
        when '110' then 110
        when '111' then 111
        when '123' then 123
        when '135' then 135
        when '147' then 147
        when '155' then 155                                                      
        else 0
    end

if @w_tipodato = 0
begin
    exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 50001,
        @i_sev  = 1,
        @i_msg  = 'El tipo de dato del parametro no es valido'
    return 1
end

if @w_tipodato = 47
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_varchar,pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_char),0),@i_v_char,@i_header)
else if @w_tipodato = 39
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_varchar,pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_varchar),0),@i_v_varchar,@i_header)
else if 
@w_tipodato = 56
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_int,pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_int),0),@i_v_int,@i_header)
else if @w_tipodato = 52
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_smallint,pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_smallint),0),@i_v_smallint,@i_header) 

else if @w_tipodato = 48
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_tinyint, pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_tinyint),0),@i_v_tinyint, 
@i_header)
else if @w_tipodato = 60
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_money, pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_money),0),@i_v_money, @i_header)
else if @w_tipodato = 61
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_datetime, pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_datetime),0),@i_v_datetime, @i_header)
else if @w_tipodato = 62
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_float,pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_float),0),@i_v_float, @i_header)
else if @w_tipodato = 59
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_real, pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_real),0),@i_v_real,@i_header)
else if @w_tipodato = 58
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_smalldatetime, pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_smalldatetime),0),@i_v_smalldatetime, @i_header)
else if @w_tipodato = 122
	insert    into re_parametro
					(pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_smallmoney, pa_header)
	values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,isnull(datalength(@i_v_smallmoney),0),@i_v_smallmoney, @i_header)

/*POR SEGURIDAD HAY QUE CONSIDERAR TODOS LOS TIPOS PARA ESTABLECER EL DATA LENGTH (BYTES QUE OCUPA UN TIPO DE DATO)  */
else if @w_tipodato in (34,35,36,37,38,45,49,50,51,55,63,106,108,109,110,111,123,135,147,155)
begin
    /* declare @w_image      image,     34
               @w_text       text,      35
               @w_extended   extended,  36
               @w_timestamp  timestamp, 37
               @w_intn       intn,      38         
               @w_binary     binary,    45
               @w_date       date,      49
               @w_bit        bit,       50
               @w_time       time,      51
               @w_decimal    decimal,   55
               @w_numeric    numeric,   63
               @w_decimaln   decimaln,  106
               @w_numericn   numericn,  108
               @w_floatn     floatn,    109
               @w_moneyn     moneyn,    110
               @w_datetimn   datetimn,  111
               @w_daten      daten,     123
               @w_unichar    unichar,   135
               @w_timen      timen,     147
               @w_univarchar univarchar 145 */
                                
    if @w_tipodato = 34 
      begin   select @w_largo = isnull(datalength(@i_v_varchar),0) end
    else if @w_tipodato = 35 
      begin select @w_largo = isnull(datalength(@i_v_varchar),0) end
    else if @w_tipodato = 36 
      begin select @w_largo = isnull(datalength(@i_v_varchar),0) end
    else if @w_tipodato = 37 
      begin select @w_largo = isnull(datalength(@i_v_varchar),0) end
    else if @w_tipodato = 38 
       begin select @w_largo = isnull(4,0)    end
    else if @w_tipodato = 45 
       begin select @w_largo = isnull(datalength(@i_v_varchar),0) end     
    else if @w_tipodato = 49 
        begin select @w_largo = isnull(4,0) end
    else if @w_tipodato = 50 
        begin select @w_largo = isnull(1,0) end
    else if @w_tipodato = 51 
        begin select @w_largo = isnull(4,0) end    
    else if @w_tipodato = 55 
        begin select @w_largo = isnull(17,0) end    
    
    else if @w_tipodato = 63 
        begin select @w_largo = isnull(17,0) end
    else if @w_tipodato = 106 
        begin select @w_largo = isnull(17,0) end
    else if @w_tipodato = 108 
        begin select @w_largo = isnull(17,0) end    
    else if @w_tipodato = 109 
        begin select @w_largo = isnull(8,0) end        
    else if @w_tipodato = 110 
        begin select @w_largo = isnull(8,0) end    
    else if @w_tipodato = 111 
        begin select @w_largo = isnull(8,0) end        
    else if @w_tipodato = 123 
        begin select @w_largo = isnull(4,0) end
    else if @w_tipodato = 135 
        begin select @w_largo = isnull(datalength(@i_v_varchar),0) end
    else if @w_tipodato = 147
        begin select @w_largo = isnull(4,0) end    
    else if @w_tipodato = 155 
        begin select @w_largo = isnull(datalength(@i_v_varchar),0) end    
                                                
    insert    into re_parametro
                    (pa_server, pa_proc,pa_nomparam,pa_tipo_io,pa_tipodato,pa_largo,pa_varchar, pa_header)
    values   (@i_server, @i_num,@i_nomparam,@i_tipo_io,@w_tipodato,@w_largo,@i_v_varchar, @i_header)

end
                
if @@error <> 0
begin
    exec cobis..sp_cerror
        @t_from = @w_sp_name,
        @i_num  = 50002,
        @i_sev  = 1,
        @i_msg  = 'No se pudo guardar el parametro'
    return 1
end
return 0