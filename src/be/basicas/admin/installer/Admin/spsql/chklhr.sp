use cobis
go

if exists (select * from sysobjects where name = 'sp_check_loghorol')

        drop proc sp_check_loghorol

go



create proc sp_check_loghorol ( 

    @i_login varchar(32),

    @i_rol int,

    @o_fini varchar(8) out,

    @o_ffin varchar(8) out

)

as

declare @w_result int,

    @w_hora varchar(8),

    @w_dia    int,

    @w_diac    char

 

 

select @w_result=ur_tipo_horario

from ad_usuario_rol, cl_funcionario

where ur_login = fu_login

      and ur_estado = 'V'

      and fu_estado = 'V'

      and ur_login=@i_login

      and ur_rol=@i_rol



if @w_result is null

    return 1



select  @w_dia=datepart(weekday,getdate())-1

if @w_dia=0

    select @w_dia=7

select @w_diac=convert(char,@w_dia)



select @o_fini=convert(char(8), ho_hr_inicio, 8),

    @o_ffin=convert(char(8), ho_hr_fin, 8)

from ad_tipo_horario, ad_horario

where th_tipo=@w_result

      and th_tipo = ho_tipo_horario

      and th_estado = 'V'

      and ho_estado = 'V'

--    and ho_dia=convert(char,datepart(weekday,getdate()))

      and ho_dia=@w_diac



select @w_hora=convert(char(8), getdate(), 8)



if @o_fini is null or @o_ffin is null

    return 1



if @w_hora < @o_fini or @w_hora > @o_ffin

    return 1



return 0

go

