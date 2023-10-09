use cobis
go



if exists (select * from sysobjects where name = 'sp_local_response')

        drop proc sp_local_response

go



create proc sp_local_response  

as  

    raiserror 44441 'q'  

    return 0  



go

