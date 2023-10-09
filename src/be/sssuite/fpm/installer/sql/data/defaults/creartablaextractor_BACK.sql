use cob_fpm
go
if exists (select 1
            from  sysobjects
            where id = object_id('fp_extractordata')
            and   type = 'U')
   drop table fp_extractordata
go

CREATE TABLE cob_fpm..fp_extractordata (
         ed_bankingProductName VARCHAR(10)
       )

go