use cobis
go



if exists (select * from sysobjects where name = 'sp_loghorol')

    drop proc sp_loghorol

go

create proc sp_loghorol

as

select ur_login, ur_rol, ho_dia, 

       convert(char(8), ho_hr_inicio, 8),

       convert(char(8), ho_hr_fin, 8)

from ad_usuario_rol, ad_tipo_horario, ad_horario, cl_funcionario

where ur_tipo_horario = th_tipo

      and th_tipo = ho_tipo_horario

      and ur_login = fu_login

      and ur_estado = 'V'

      and th_estado = 'V'

      and ho_estado = 'V'

      and fu_estado = 'V'

order by ur_login, ur_rol, ho_dia, ho_hr_inicio, ho_hr_fin

go

