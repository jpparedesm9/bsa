use cobis
go



if exists (select * from sysobjects where name = 'sp_submit_RPC')

        drop proc sp_submit_RPC

go

print 'sp_submit_RPC'

go

create proc sp_submit_RPC  

(  

    @i_server varchar(32),  

    @i_sproc varchar(64)  ,

    @t_online char(1)='S'

)  

as 

    if @t_online ='N'

    begin

        raiserror 40002 'Server fuera de linea'

        return 1

    end

    raiserror 44441 'x'  

    select @i_server,@i_sproc  

    return 0  

go

