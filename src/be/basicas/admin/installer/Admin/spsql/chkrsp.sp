use cobis
go

if exists (select * from sysobjects where name = 'sp_check_rolspro')

    drop proc sp_check_rolspro

go



create proc sp_check_rolspro (

    @i_trn int,

    @i_rol tinyint,

    @i_base varchar(64),

    @i_sp varchar(64)

)

as

declare @w_result int



select @w_result=count(*)

from ad_tr_autorizada

where ta_rol=@i_rol

      and ta_transaccion=@i_trn

      and ta_estado = 'V'



if @w_result=0

    return 1



select @w_result=count(*)

    from ad_pro_transaccion, ad_procedure

where pt_estado = 'V'

      and pd_estado = 'V'

      and pd_procedure = pt_procedure

      and pt_transaccion=@i_trn

      and @i_base=pd_base_datos

      and @i_sp=pd_stored_procedure



if @w_result=0

    return 1



return 0

go

